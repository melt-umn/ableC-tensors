grammar edu:umn:cs:melt:exts:ableC:tensors:concretesyntax;

imports edu:umn:cs:melt:ableC:concretesyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;

imports edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

imports silver:langutil:pp;
imports silver:langutil;

nonterminal TensorExpr with ast<Expr>, location;
nonterminal TensorCross_Expr with ast<Expr>, location;
nonterminal TensorDot_Expr with ast<Expr>, location;

marking terminal TensorEnvOpen_t '[.';
terminal TensorEnvClose_t '.]';

{-
marking terminal Create_tensor 'create' lexer classes {Ckeyword};
marking terminal Access_tensor 'access' lexer classes {Ckeyword};

marking terminal Copy_tensor 'copy' lexer classes {Ckeyword};
marking terminal Transpose 'trans' lexer classes {Ckeyword};
marking terminal Identity_tensor 'id' lexer classes {Ckeyword};
marking terminal Identity_tensor_asymmetric 'id_as' lexer classes {Ckeyword};

marking terminal Fill_tensor 'fill' lexer classes {Ckeyword};
marking terminal Ones 'onesT' lexer classes {Ckeyword};
marking terminal Zeros 'zerosT' lexer classes {Ckeyword};
-}

marking terminal Float_to_tensor 'float_to_ten' lexer classes {Ckeyword};

marking terminal Tensor_to_float 'ten_to_float' lexer classes {Ckeyword};

{-
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
marking terminal Tensor_elem_add 'ten_elem_add' lexer classes {Ckeyword};
marking terminal Tensor_elem_subtract 'ten_elem_subtract' lexer classes {Ckeyword};
marking terminal Tensor_elem_multiply 'ten_elem_multiply' lexer classes {Ckeyword};
marking terminal Tensor_elem_divide 'ten_elem_divide' lexer classes {Ckeyword};

marking terminal Tensor_multiply 'ten_multiply' lexer classes {Ckeyword};
-}
terminal Dot_product '.*' lexer classes {Csymbol};
{-
marking terminal Float_dot_product 'float_dot' lexer classes {Ckeyword};
marking terminal Float_dot_product_vtwo 'float_dot_vtwo' lexer classes {Ckeyword};
-}
marking terminal Cross_product 'cross' lexer classes {Ckeyword};
{-
marking terminal Scalar_triple_product 'scalar_triple_productT' lexer classes {Ckeyword};
marking terminal Float_scalar_triple_product 'float_triple_productT' lexer classes {Ckeyword};
marking terminal Vector_triple_product 'vector_triple_productT' lexer classes {Ckeyword};

marking terminal Trace 'traceT' lexer classes {Ckeyword};
marking terminal Tensor_trace 'tensor_traceT' lexer classes {Ckeyword};

marking terminal Free 'freeT' lexer classes {Ckeyword};
marking terminal Free_dynamic 'free_dynamic' lexer classes {Ckeyword};
marking terminal Tensor_print 'printT' lexer classes {Ckeyword};
-}


concrete production assignExpr_c
e::AssignExpr_c ::= t::TensorExpr
{
  e.ast = t.ast;
}

concrete production tensorExpr_c
e::TensorExpr ::= t::TensorCross_Expr
{
  e.ast = t.ast;
}

concrete production tensorCross_Expr_c
e::TensorCross_Expr ::= t::TensorDot_Expr
{
  e.ast = t.ast;
}

concrete production tensorDot_Expr_c
e::TensorDot_Expr ::= t::Expr_c
{
  e.ast = t.ast;
}


{-
concrete production create_c
e::TensorExpr ::= 'create' '(' numDim :: AssignExpr_c ',' dimSize :: AssignExpr_c ',' count :: AssignExpr_c ',' data :: AssignExpr_c')'
{
  e.ast = create_a(numDim.ast, dimSize.ast, count.ast, data.ast, location = e.location);
}

concrete production access_c
e::TensorExpr ::= 'access' '(' tensor :: AssignExpr_c ',' interval :: AssignExpr_c ')'
{
  e.ast = access_a (tensor.ast, interval.ast, location = e.location);
}
-}

concrete production float_to_scalar_tensor_c
e::TensorDot_Expr ::= '[.' value :: AssignExpr_c '.]'
{
  e.ast = float_to_scalar_tensor_a(value.ast, location = e.location);
}

{-
concrete production copy_tensor_c
e::TensorExpr ::= 'copy' '(' value :: TensorExpr ')'
{
  e.ast = copy_tensor_a(value.ast, location = e.location);
}

concrete production transpose_tensor_c
e::TensorExpr ::= 'trans' '(' value :: TensorExpr ')'
{
  e.ast = transpose_tensor_a(value.ast, location = e.location);
}

concrete production identity_tensor_c
e::TensorExpr ::= 'id' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = identity_tensor_a(numDim.ast, sizeDim.ast, location = e.location);
}

concrete production identity_tensor_asymmetric_c
e::TensorExpr ::= 'id_as' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = identity_tensor_asymmetric_a(numDim.ast, sizeDim.ast, location = e.location);
}

concrete production fill_tensor_c
e::TensorExpr ::= 'fill' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ',' toFill :: AssignExpr_c ')'
{
  e.ast = fill_tensor_a(numDim.ast, sizeDim.ast, toFill.ast, location = e.location);
}

concrete production ones_c
e::TensorExpr ::= 'onesT' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = ones_a(numDim.ast, sizeDim.ast, location = e.location);
}

concrete production zeros_c
e::TensorExpr ::= 'zerosT' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = zeros_a(numDim.ast, sizeDim.ast, location = e.location);
}

concrete production float_to_scalar_tensor_fun_c
e::TensorDot_Expr ::= 'float_to_ten' '(' value :: AssignExpr_c ')'
{
  e.ast = float_to_scalar_tensor_a(value.ast, location = e.location);
}
-}
concrete production scalar_tensor_to_float_c
e::AssignExpr_c ::= 'ten_to_float' '(' value :: TensorDot_Expr ')'
{
  e.ast = scalar_tensor_to_float_a(value.ast, location = e.location);
}
{-

concrete production map_c
e::TensorExpr ::= 'mapT' '(' fun :: AssignExpr_c ',' tensor :: TensorExpr  ')'
{
	e.ast = map_a(fun.ast, tensor.ast, location = e.location);
}

concrete production square_c
e::TensorExpr ::= 'squareT' '(' value :: TensorExpr ')'
{
  e.ast = square_a(value.ast, location = e.location);
}

concrete production increment_c
e::TensorExpr ::= 'inc' '(' value :: TensorExpr ')'
{
  e.ast = increment_a(value.ast, location = e.location);
}

concrete production fold_c
e::TensorExpr ::= 'foldT' '(' fun :: AssignExpr_c ',' valueStart :: AssignExpr_c ',' ten :: TensorExpr ')'
{
  e.ast = fold_a(fun.ast, valueStart.ast, ten.ast, location = e.location);
}

concrete production tensor_fold_c
e::TensorExpr ::= 'ten_foldT' '(' fun :: AssignExpr_c ',' tensorStart :: TensorExpr ',' ten :: TensorExpr ')'
{
  e.ast = tensor_fold_a(fun.ast, tensorStart.ast, ten.ast, location = e.location);
}

concrete production max_c
e::AssignExpr_c ::= 'maxT' '(' tensor :: TensorExpr ')'
{
  e.ast = max_a(tensor.ast, location = e.location);
}

concrete production min_c
e::AssignExpr_c ::= 'minT' '(' tensor :: TensorExpr ')'
{
  e.ast = min_a(tensor.ast, location = e.location);
}

concrete production sum_c
e::AssignExpr_c ::= 'sumT' '(' tensor :: TensorExpr ')'
{
  e.ast = sum_a(tensor.ast, location = e.location);
}

concrete production product_c
e::AssignExpr_c ::= 'prodT' '(' tensor :: TensorExpr ')'
{
  e.ast = product_a(tensor.ast, location = e.location);
}

concrete production tensor_max_c
e::TensorExpr ::= 'ten_max' '(' tensor :: TensorExpr ')'
{
  e.ast = tensor_max_a(tensor.ast, location = e.location);
}

concrete production tensor_min_c
e::TensorExpr ::= 'ten_min' '(' tensor :: TensorExpr ')'
{
  e.ast = tensor_min_a(tensor.ast, location = e.location);
}

concrete production tensor_sum_c
e::TensorExpr ::= 'ten_sum' '(' tensor :: TensorExpr ')'
{
  e.ast = tensor_sum_a(tensor.ast, location = e.location);
}

concrete production tensor_product_c
e::TensorExpr ::= 'ten_prod' '(' tensor :: TensorExpr ')'
{
  e.ast = tensor_product_a(tensor.ast, location = e.location);
}

concrete production tensor_combine_c
e::TensorExpr ::= 'ten_combine' '(' tenOne :: TensorExpr ',' tenTwo :: TensorExpr ')'
{
  e.ast = tensor_combine_a(tenOne.ast,tenTwo.ast, location = e.location);
}

concrete production tensor_elem_add_c
e::TensorExpr ::= 'ten_elem_add' '(' tenOne :: TensorExpr ',' tenTwo :: TensorExpr ')'
{
  e.ast = tensor_elem_add_a(tenOne.ast,tenTwo.ast, location = e.location);
}

concrete production tensor_elem_subtract_c
e::TensorExpr ::= 'ten_elem_subtract' '(' tenOne :: TensorExpr ',' tenTwo :: TensorExpr ')'
{
  e.ast = tensor_elem_subtract_a(tenOne.ast,tenTwo.ast, location = e.location);
}

concrete production tensor_elem_multiply_c
e::TensorExpr ::= 'ten_elem_multiply' '(' tenOne :: TensorExpr ',' tenTwo :: TensorExpr ')'
{
  e.ast = tensor_elem_multiply_a(tenOne.ast,tenTwo.ast, location = e.location);
}

concrete production tensor_elem_divide_c
e::TensorExpr ::= 'ten_elem_divide' '(' tenOne :: TensorExpr ',' tenTwo :: TensorExpr ')'
{
  e.ast = tensor_elem_divide_a(tenOne.ast,tenTwo.ast, location = e.location);
}

concrete production tensor_multiply_c
e::TensorExpr ::= 'ten_multiply' '(' tenOne :: TensorExpr ',' tenTwo :: TensorExpr ')'
{
  e.ast = tensor_multiply_a(tenOne.ast,tenTwo.ast, location = e.location);
}
-}

concrete production dot_product_c
e::TensorDot_Expr ::= tenOne :: TensorDot_Expr '.*' tenTwo :: TensorCross_Expr
{
  e.ast = dot_product_a(tenOne.ast,tenTwo.ast, location = e.location);
}

{-
concrete production float_dot_product_c
e::AssignExpr_c ::= 'float_dot' '(' tenOne :: TensorExpr ',' tenTwo :: TensorExpr ')'
{
  e.ast = float_dot_product_a(tenOne.ast,tenTwo.ast, location = e.location);
}

concrete production float_dot_product_vtwo_c
e::AssignExpr_c ::= 'float_dot_vtwo' '(' tenOne :: TensorExpr ',' tenTwo :: TensorExpr ')'
{
  e.ast = float_dot_product_vtwo_a(tenOne.ast,tenTwo.ast, location = e.location);
}
-}
concrete production cross_product_c
e::TensorCross_Expr ::= 'cross' '(' tenOne :: TensorCross_Expr ',' tenTwo :: TensorExpr ')'
{
  e.ast = cross_product_a(tenOne.ast,tenTwo.ast, location = e.location);
}
{-
concrete production scalar_triple_product_c
e::TensorExpr ::= 'scalar_triple_productT' '(' tenOne :: TensorExpr ',' tenTwo :: TensorExpr ','
                      tenThree :: TensorExpr ')'
{
  e.ast = scalar_triple_product_a(tenOne.ast,tenTwo.ast,tenThree.ast, location = e.location);
}

concrete production float_scalar_triple_product_c
e::AssignExpr_c ::= 'float_triple_productT' '(' tenOne :: TensorExpr ',' tenTwo :: TensorExpr ','
                      tenThree :: TensorExpr ')'
{
  e.ast = float_scalar_triple_product_a(tenOne.ast,tenTwo.ast,tenThree.ast, location = e.location);
}

concrete production vector_triple_product_c
e::TensorExpr ::= 'vector_triple_productT' '(' tenOne :: TensorExpr ',' tenTwo :: TensorExpr ','
                      tenThree :: TensorExpr ')'
{
  e.ast = vector_triple_product_a(tenOne.ast,tenTwo.ast,tenThree.ast, location = e.location);
}

concrete production trace_c
e::TensorExpr ::= 'traceT' '(' value :: TensorExpr ')'
{
  e.ast = trace_a(value.ast, location = e.location);
}

concrete production tensor_trace_c
e::TensorExpr ::= 'tensor_traceT' '(' value :: TensorExpr ')'
{
  e.ast = tensor_trace_a(value.ast, location = e.location);
}

concrete production free_tensor_c
e::TensorExpr ::= 'freeT' '(' value :: TensorExpr ')'
{
  e.ast = free_tensor_a(value.ast, location = e.location);
}

concrete production free_tensor_dynamic_c
e::AssignExpr_c ::= 'free_dynamic' '(' value :: AssignExpr_c ')'
{
  e.ast = free_tensor_dynamic_a(value.ast, location = e.location);
}

concrete production print_tensor_c
e::AssignExpr_c ::= 'printT' '(' value :: TensorExpr ')'
{
  e.ast = print_tensor_a(value.ast, location = e.location);
}
-}
