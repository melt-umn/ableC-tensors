grammar edu:umn:cs:melt:exts:ableC:tensors:concretesyntax;

imports edu:umn:cs:melt:ableC:concretesyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;

imports edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

imports silver:langutil:pp;
imports silver:langutil;

marking terminal IntervalEnvOpen_t '<.';
terminal IntervalEnvClose_t '.>';
marking terminal StartIntervalList '<.>';
terminal Between '.-.';

marking terminal TensorEnvOpen_t '[.';
terminal TensorEnvClose_t '.]';
--i assume a star exists? and the dash?

marking terminal Create_tensor 'create' lexer classes {Ckeyword};

marking terminal Access_tensor 'access' lexer classes {Ckeyword};

marking terminal Copy_tensor 'copy' lexer classes {Ckeyword};
marking terminal Transpose 'trans' lexer classes {Ckeyword};
marking terminal Identity_tensor 'id' lexer classes {Ckeyword};
marking terminal Identity_tensor_asymmetric 'id_as' lexer classes {Ckeyword};

marking terminal Fill_tensor 'fill' lexer classes {Ckeyword};
marking terminal Ones 'onesT' lexer classes {Ckeyword};
marking terminal Zeros 'zerosT' lexer classes {Ckeyword};

marking terminal Float_to_tensor 'float_to_ten' lexer classes {Ckeyword};
marking terminal Tensor_to_float 'ten_to_float' lexer classes {Ckeyword};

marking terminal Map_tensor 'mapT' lexer classes {Ckeyword};
marking terminal Square_all 'squareT' lexer classes {Ckeyword};
marking terminal Increment 'inc' lexer classes {Ckeyword};

marking terminal Fold 'foldT' lexer classes {Ckeyword};
marking terminal Tensor_fold 'ten_foldT' lexer classes {Ckeyword};
marking terminal Max 'maxT' lexer classes {Ckeyword};
marking terminal Min 'minT' lexer classes {Ckeyword};
marking terminal Sum 'sumT' lexer classes {Ckeyword};
marking terminal Product 'prodT' lexer classes {Ckeyword};
marking terminal Tensor_max 'ten_max' lexer classes {Ckeyword};
marking terminal Tensor_min 'ten_min' lexer classes {Ckeyword};
marking terminal Tensor_sum 'ten_sum' lexer classes {Ckeyword};
marking terminal Tensor_product 'ten_prod' lexer classes {Ckeyword};

marking terminal Tensor_combine 'ten_combine' lexer classes {Ckeyword};

marking terminal Tensor_multiply '**' lexer classes {Ckeyword};

terminal Dot_product '.*' lexer classes {Csymbol};
terminal Float_dot_product 'f.*' lexer classes {Ckeyword};

terminal Cross_product 'x*' lexer classes {Csymbol};

marking terminal Scalar_triple_product 'scalar_triple_productT' lexer classes {Ckeyword};
marking terminal Float_scalar_triple_product 'float_triple_productT' lexer classes {Ckeyword};
marking terminal Vector_triple_product 'vector_triple_productT' lexer classes {Ckeyword};

marking terminal Trace 'traceT' lexer classes {Ckeyword};
marking terminal Tensor_trace 'tensor_traceT' lexer classes {Ckeyword};

marking terminal Free 'freeT' lexer classes {Ckeyword};
marking terminal Free_dynamic 'free_dynamic' lexer classes {Ckeyword};

marking terminal Tensor_print 'printT' lexer classes {Ckeyword};

{-
-- Mirrors TypeNames_c
-- Can't use TypeNames_c due to constraints on adding new terminals to host follow sets
nonterminal TensorTypes_c with ast<AssignExpr_c>;

concrete production tensor_creation_c --only works for 1d tensors
e::PrimaryExpr_c ::= '[.' t :: TensorTypeNames_c '.]'
{
  e.ast = tensor_creation_c(t.ast, location = e.location);
}

concrete productions top::TensorTypes_c
| h::AssignExpr_c ',' t::TupleTypes_c --two or more tensor elements
    { top.ast = cons_tensor_a(h.ast, t.ast); }
| h::AssignExpr_c --one tensor element
    { top.ast = cons_tensor_a(h.ast, nil_tensor_a()); }
| --empty tensor
    { top.ast = nil_tensor_a(h.ast);}
-}

--concrete production nil_tensor_c
--e::PrimaryExpr_c ::= '[.' '.]'
--{
--  e.ast = nil_tensor_a(location = e.location);
--}
--
--concrete production float_to_scalar_tensor_c
--e::PrimaryExpr_c ::= '[.' value :: AssignExpr_c '.]'
--{
--  e.ast = float_to_scalar_tensor_a(value.ast, location = e.location);
--}


concrete productions top::PrimaryExpr_c
| '<.' oneDim :: AssignExpr_c '.>'
  { top.ast = create_interval_double_bound_a(oneDim.ast, oneDim.ast,
    location = top.location); }
| '<.' leftDim :: AssignExpr_c '.-.' rightDim :: AssignExpr_c '.>'
  { top.ast = create_interval_double_bound_a(leftDim.ast, rightDim.ast,
    location = top.location); }
| '<.' leftDim :: AssignExpr_c '.-.' '*' '.>'
  { top.ast = create_interval_left_bound_a(leftDim.ast,
    location = top.location); }
| '<.' '*' '.>'
  { top.ast = create_interval_no_bound_a(location = top.location); }

--rest of these are technically useless but will add for consistency
| '<.' '*' '.-.' rightDim :: AssignExpr_c '.>'
  { top.ast = create_interval_right_bound_a(rightDim.ast, location = top.location); }
| '<.' '*' '.-.' '*' '.>'
  { top.ast = create_interval_no_bound_a(location = top.location); }


concrete production create_c
e::PrimaryExpr_c ::= 'create' '(' numDim :: AssignExpr_c ',' dimSize :: AssignExpr_c ',' count :: AssignExpr_c ',' data :: AssignExpr_c')'
{
  e.ast = create_a(numDim.ast, dimSize.ast, count.ast, data.ast, location = e.location);
}

concrete production access_c
e::PrimaryExpr_c ::= 'access' '(' tensor :: AssignExpr_c ',' interval :: AssignExpr_c ')'
{
  e.ast = access_a (tensor.ast, interval.ast, location = e.location);
}

concrete production copy_tensor_c
e::PrimaryExpr_c ::= 'copy' '(' value :: AssignExpr_c ')'
{
  e.ast = copy_tensor_a(value.ast, location = e.location);
}

concrete production transpose_tensor_c
e::PrimaryExpr_c ::= 'trans' '(' value :: AssignExpr_c ')'
{
  e.ast = transpose_tensor_a(value.ast, location = e.location);
}

concrete production identity_tensor_c
e::PrimaryExpr_c ::= 'id' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = identity_tensor_a(numDim.ast, sizeDim.ast, location = e.location);
}

concrete production identity_tensor_asymmetric_c
e::PrimaryExpr_c ::= 'id_as' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = identity_tensor_asymmetric_a(numDim.ast, sizeDim.ast, location = e.location);
}

concrete production fill_tensor_c
e::PrimaryExpr_c ::= 'fill' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ',' toFill :: AssignExpr_c ')'
{
  e.ast = fill_tensor_a(numDim.ast, sizeDim.ast, toFill.ast, location = e.location);
}

concrete production ones_c
e::PrimaryExpr_c ::= 'onesT' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = ones_a(numDim.ast, sizeDim.ast, location = e.location);
}

concrete production zeros_c
e::PrimaryExpr_c ::= 'zerosT' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = zeros_a(numDim.ast, sizeDim.ast, location = e.location);
}

concrete production float_to_scalar_tensor_fun_c
e::PrimaryExpr_c ::= 'float_to_ten' '(' value :: AssignExpr_c ')'
{
  e.ast = float_to_scalar_tensor_a(value.ast, location = e.location);
}

concrete production scalar_tensor_to_float_c
e::PrimaryExpr_c ::= 'ten_to_float' '(' value :: AssignExpr_c ')'
{
  e.ast = scalar_tensor_to_float_a(value.ast, location = e.location);
}


concrete production map_c
e::PrimaryExpr_c ::= 'mapT' '(' fun :: AssignExpr_c ',' tensor :: AssignExpr_c  ')'
{
	e.ast = map_a(fun.ast, tensor.ast, location = e.location);
}

concrete production square_c
e::PrimaryExpr_c ::= 'squareT' '(' value :: AssignExpr_c ')'
{
  e.ast = square_a(value.ast, location = e.location);
}

concrete production increment_c
e::PrimaryExpr_c ::= 'inc' '(' value :: AssignExpr_c ')'
{
  e.ast = increment_a(value.ast, location = e.location);
}

concrete production fold_c
e::PrimaryExpr_c ::= 'foldT' '(' fun :: AssignExpr_c ',' valueStart :: AssignExpr_c ',' ten :: AssignExpr_c ')'
{
  e.ast = fold_a(fun.ast, valueStart.ast, ten.ast, location = e.location);
}

concrete production tensor_fold_c
e::PrimaryExpr_c ::= 'ten_foldT' '(' fun :: AssignExpr_c ',' tensorStart :: AssignExpr_c ',' ten :: AssignExpr_c ')'
{
  e.ast = tensor_fold_a(fun.ast, tensorStart.ast, ten.ast, location = e.location);
}

concrete production max_c
e::PrimaryExpr_c ::= 'maxT' '(' tensor :: AssignExpr_c ')'
{
  e.ast = max_a(tensor.ast, location = e.location);
}

concrete production min_c
e::PrimaryExpr_c ::= 'minT' '(' tensor :: AssignExpr_c ')'
{
  e.ast = min_a(tensor.ast, location = e.location);
}

concrete production sum_c
e::PrimaryExpr_c ::= 'sumT' '(' tensor :: AssignExpr_c ')'
{
  e.ast = sum_a(tensor.ast, location = e.location);
}

concrete production product_c
e::PrimaryExpr_c ::= 'prodT' '(' tensor :: AssignExpr_c ')'
{
  e.ast = product_a(tensor.ast, location = e.location);
}

concrete production tensor_max_c
e::PrimaryExpr_c ::= 'ten_max' '(' tensor :: AssignExpr_c ')'
{
  e.ast = tensor_max_a(tensor.ast, location = e.location);
}

concrete production tensor_min_c
e::PrimaryExpr_c ::= 'ten_min' '(' tensor :: AssignExpr_c ')'
{
  e.ast = tensor_min_a(tensor.ast, location = e.location);
}

concrete production tensor_sum_c
e::PrimaryExpr_c ::= 'ten_sum' '(' tensor :: AssignExpr_c ')'
{
  e.ast = tensor_sum_a(tensor.ast, location = e.location);
}

concrete production tensor_product_c
e::PrimaryExpr_c ::= 'ten_prod' '(' tensor :: AssignExpr_c ')'
{
  e.ast = tensor_product_a(tensor.ast, location = e.location);
}

concrete production tensor_combine_c
e::PrimaryExpr_c ::= 'ten_combine' '(' tenOne :: AssignExpr_c ',' tenTwo :: AssignExpr_c ')'
{
  e.ast = tensor_combine_a(tenOne.ast,tenTwo.ast, location = e.location);
}

concrete productions top::AdditiveOp_c
| '.*'
  { top.ast = dot_product_a(top.leftExpr, top.rightExpr,
    location = top.location); }
| 'f.*'
  { top.ast = float_dot_product_a(top.leftExpr, top.rightExpr,
    location = top.location); }

concrete productions top::AddMulNoneOp_c
| 'x*'
  { top.ast = cross_product_a(top.leftExpr, top.rightExpr,
    location = top.location); }
| '**'
  { top.ast = tensor_multiply_a(top.leftExpr,top.rightExpr,
    location = top.location); }

concrete productions top::AddMulRightOp_c
| '<.>'
  { top.ast = access_a(top.leftExpr, top.rightExpr,
    location = top.location); }


concrete production scalar_triple_product_c
e::PrimaryExpr_c ::= 'scalar_triple_productT' '(' tenOne :: AssignExpr_c ',' tenTwo :: AssignExpr_c ','
                      tenThree :: AssignExpr_c ')'
{
  e.ast = scalar_triple_product_a(tenOne.ast,tenTwo.ast,tenThree.ast, location = e.location);
}

concrete production float_scalar_triple_product_c
e::PrimaryExpr_c ::= 'float_triple_productT' '(' tenOne :: AssignExpr_c ',' tenTwo :: AssignExpr_c ','
                      tenThree :: AssignExpr_c ')'
{
  e.ast = float_scalar_triple_product_a(tenOne.ast,tenTwo.ast,tenThree.ast, location = e.location);
}

concrete production vector_triple_product_c
e::PrimaryExpr_c ::= 'vector_triple_productT' '(' tenOne :: AssignExpr_c ',' tenTwo :: AssignExpr_c ','
                      tenThree :: AssignExpr_c ')'
{
  e.ast = vector_triple_product_a(tenOne.ast,tenTwo.ast,tenThree.ast, location = e.location);
}

concrete production trace_c
e::PrimaryExpr_c ::= 'traceT' '(' value :: AssignExpr_c ')'
{
  e.ast = trace_a(value.ast, location = e.location);
}

concrete production tensor_trace_c
e::PrimaryExpr_c ::= 'tensor_traceT' '(' value :: AssignExpr_c ')'
{
  e.ast = tensor_trace_a(value.ast, location = e.location);
}

concrete production free_tensor_c
e::PrimaryExpr_c ::= 'freeT' '(' value :: AssignExpr_c ')'
{
  e.ast = free_tensor_a(value.ast, location = e.location);
}

concrete production free_tensor_dynamic_c
e::PrimaryExpr_c ::= 'free_dynamic' '(' value :: AssignExpr_c ')'
{
  e.ast = free_tensor_dynamic_a(value.ast, location = e.location);
}


concrete production print_tensor_c
e::PrimaryExpr_c ::= 'printT' '(' value :: AssignExpr_c ')'
{
  e.ast = print_tensor_a(value.ast, location = e.location);
}

nonterminal TensorSeq with location, ast<Expr>;

--Experimental tensor literal creation
concrete production tensor_literal_c
e::AssignExpr_c ::= '[.' tSeq :: TensorSeq '.]'
{
--  e.ast = expr_to_tensor(e.ast);
  e.ast = txtExpr("/* tensor_literal_c */", location=e.location);
}

concrete productions tSeq::TensorSeq
| e::AssignExpr_c
  {
--  t.ast = e.ast;
    tSeq.ast = txtExpr("/* tensorSeq */", location=e.location);
  }
| e::AssignExpr_c ',' anotherTSeq::TensorSeq
  {
--  t.ast = e.ast;
    tSeq.ast = txtExpr("/* tensorSeq */", location=e.location);
  }

