grammar edu:umn:cs:melt:exts:ableC:tensors:concretesyntax;

imports edu:umn:cs:melt:ableC:concretesyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;

imports edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

imports silver:langutil:pp;
imports silver:langutil;

nonterminal Tensor_Expr with ast<Expr>, location;
nonterminal Tensor_Cross with ast<Expr>, location;
nonterminal Tensor_Dot with ast<Expr>, location;

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


concrete production AssignExpr_c
e::AssignExpr_c ::= t::Tensor_Expr
{
  e.ast = t.ast;
}

concrete production Tensor_Expr
e::Tensor_Expr ::= t::Tensor_Cross
{
  e.ast = t.ast;
}

concrete production Tensor_Cross
e::Tensor_Cross ::= t::Tensor_Dot
{
  e.ast = t.ast;
}


{-
concrete production create_c
e::Tensor_Expr ::= 'create' '(' numDim :: AssignExpr_c ',' dimSize :: AssignExpr_c ',' count :: AssignExpr_c ',' data :: AssignExpr_c')'
{
  e.ast = create_a(numDim.ast, dimSize.ast, count.ast, data.ast, location = e.location);
}

concrete production access_c
e::Tensor_Expr ::= 'access' '(' tensor :: AssignExpr_c ',' interval :: AssignExpr_c ')'
{
  e.ast = access_a (tensor.ast, interval.ast, location = e.location);
}
-}

concrete production float_to_scalar_tensor_c
e::Tensor_Expr ::= '[.' value :: AssignExpr_c '.]'
{
  e.ast = float_to_scalar_tensor_a(value.ast, location = e.location);
}

{-
concrete production copy_tensor_c
e::Tensor_Expr ::= 'copy' '(' value :: Tensor_Expr ')'
{
  e.ast = copy_tensor_a(value.ast, location = e.location);
}

concrete production transpose_tensor_c
e::Tensor_Expr ::= 'trans' '(' value :: Tensor_Expr ')'
{
  e.ast = transpose_tensor_a(value.ast, location = e.location);
}

concrete production identity_tensor_c
e::Tensor_Expr ::= 'id' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = identity_tensor_a(numDim.ast, sizeDim.ast, location = e.location);
}

concrete production identity_tensor_asymmetric_c
e::Tensor_Expr ::= 'id_as' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = identity_tensor_asymmetric_a(numDim.ast, sizeDim.ast, location = e.location);
}

concrete production fill_tensor_c
e::Tensor_Expr ::= 'fill' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ',' toFill :: AssignExpr_c ')'
{
  e.ast = fill_tensor_a(numDim.ast, sizeDim.ast, toFill.ast, location = e.location);
}

concrete production ones_c
e::Tensor_Expr ::= 'onesT' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = ones_a(numDim.ast, sizeDim.ast, location = e.location);
}

concrete production zeros_c
e::Tensor_Expr ::= 'zerosT' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = zeros_a(numDim.ast, sizeDim.ast, location = e.location);
}

concrete production float_to_scalar_tensor_fun_c
e::Tensor_Expr ::= 'float_to_ten' '(' value :: AssignExpr_c ')'
{
  e.ast = float_to_scalar_tensor_a(value.ast, location = e.location);
}
-}
concrete production scalar_tensor_to_float_c
e::AssignExpr_c ::= 'ten_to_float' '(' value :: Tensor_Dot ')'
{
  e.ast = scalar_tensor_to_float_a(value.ast, location = e.location);
}
{-

concrete production map_c
e::Tensor_Expr ::= 'mapT' '(' fun :: AssignExpr_c ',' tensor :: Tensor_Expr  ')'
{
	e.ast = map_a(fun.ast, tensor.ast, location = e.location);
}

concrete production square_c
e::Tensor_Expr ::= 'squareT' '(' value :: Tensor_Expr ')'
{
  e.ast = square_a(value.ast, location = e.location);
}

concrete production increment_c
e::Tensor_Expr ::= 'inc' '(' value :: Tensor_Expr ')'
{
  e.ast = increment_a(value.ast, location = e.location);
}

concrete production fold_c
e::Tensor_Expr ::= 'foldT' '(' fun :: AssignExpr_c ',' valueStart :: AssignExpr_c ',' ten :: Tensor_Expr ')'
{
  e.ast = fold_a(fun.ast, valueStart.ast, ten.ast, location = e.location);
}

concrete production tensor_fold_c
e::Tensor_Expr ::= 'ten_foldT' '(' fun :: AssignExpr_c ',' tensorStart :: Tensor_Expr ',' ten :: Tensor_Expr ')'
{
  e.ast = tensor_fold_a(fun.ast, tensorStart.ast, ten.ast, location = e.location);
}

concrete production max_c
e::AssignExpr_c ::= 'maxT' '(' tensor :: Tensor_Expr ')'
{
  e.ast = max_a(tensor.ast, location = e.location);
}

concrete production min_c
e::AssignExpr_c ::= 'minT' '(' tensor :: Tensor_Expr ')'
{
  e.ast = min_a(tensor.ast, location = e.location);
}

concrete production sum_c
e::AssignExpr_c ::= 'sumT' '(' tensor :: Tensor_Expr ')'
{
  e.ast = sum_a(tensor.ast, location = e.location);
}

concrete production product_c
e::AssignExpr_c ::= 'prodT' '(' tensor :: Tensor_Expr ')'
{
  e.ast = product_a(tensor.ast, location = e.location);
}

concrete production tensor_max_c
e::Tensor_Expr ::= 'ten_max' '(' tensor :: Tensor_Expr ')'
{
  e.ast = tensor_max_a(tensor.ast, location = e.location);
}

concrete production tensor_min_c
e::Tensor_Expr ::= 'ten_min' '(' tensor :: Tensor_Expr ')'
{
  e.ast = tensor_min_a(tensor.ast, location = e.location);
}

concrete production tensor_sum_c
e::Tensor_Expr ::= 'ten_sum' '(' tensor :: Tensor_Expr ')'
{
  e.ast = tensor_sum_a(tensor.ast, location = e.location);
}

concrete production tensor_product_c
e::Tensor_Expr ::= 'ten_prod' '(' tensor :: Tensor_Expr ')'
{
  e.ast = tensor_product_a(tensor.ast, location = e.location);
}

concrete production tensor_combine_c
e::Tensor_Expr ::= 'ten_combine' '(' tenOne :: Tensor_Expr ',' tenTwo :: Tensor_Expr ')'
{
  e.ast = tensor_combine_a(tenOne.ast,tenTwo.ast, location = e.location);
}

concrete production tensor_elem_add_c
e::Tensor_Expr ::= 'ten_elem_add' '(' tenOne :: Tensor_Expr ',' tenTwo :: Tensor_Expr ')'
{
  e.ast = tensor_elem_add_a(tenOne.ast,tenTwo.ast, location = e.location);
}

concrete production tensor_elem_subtract_c
e::Tensor_Expr ::= 'ten_elem_subtract' '(' tenOne :: Tensor_Expr ',' tenTwo :: Tensor_Expr ')'
{
  e.ast = tensor_elem_subtract_a(tenOne.ast,tenTwo.ast, location = e.location);
}

concrete production tensor_elem_multiply_c
e::Tensor_Expr ::= 'ten_elem_multiply' '(' tenOne :: Tensor_Expr ',' tenTwo :: Tensor_Expr ')'
{
  e.ast = tensor_elem_multiply_a(tenOne.ast,tenTwo.ast, location = e.location);
}

concrete production tensor_elem_divide_c
e::Tensor_Expr ::= 'ten_elem_divide' '(' tenOne :: Tensor_Expr ',' tenTwo :: Tensor_Expr ')'
{
  e.ast = tensor_elem_divide_a(tenOne.ast,tenTwo.ast, location = e.location);
}

concrete production tensor_multiply_c
e::Tensor_Expr ::= 'ten_multiply' '(' tenOne :: Tensor_Expr ',' tenTwo :: Tensor_Expr ')'
{
  e.ast = tensor_multiply_a(tenOne.ast,tenTwo.ast, location = e.location);
}
-}

concrete production dot_product_c
e::Tensor_Dot ::= tenOne :: Tensor_Dot '.*' tenTwo :: Tensor_Cross
{
  e.ast = dot_product_a(tenOne.ast,tenTwo.ast, location = e.location);
}

{-
concrete production float_dot_product_c
e::AssignExpr_c ::= 'float_dot' '(' tenOne :: Tensor_Expr ',' tenTwo :: Tensor_Expr ')'
{
  e.ast = float_dot_product_a(tenOne.ast,tenTwo.ast, location = e.location);
}

concrete production float_dot_product_vtwo_c
e::AssignExpr_c ::= 'float_dot_vtwo' '(' tenOne :: Tensor_Expr ',' tenTwo :: Tensor_Expr ')'
{
  e.ast = float_dot_product_vtwo_a(tenOne.ast,tenTwo.ast, location = e.location);
}
-}
concrete production cross_product_c
e::Tensor_Cross ::= 'cross' '(' tenOne :: Tensor_Cross ',' tenTwo :: Tensor_Expr ')'
{
  e.ast = cross_product_a(tenOne.ast,tenTwo.ast, location = e.location);
}
{-
concrete production scalar_triple_product_c
e::Tensor_Expr ::= 'scalar_triple_productT' '(' tenOne :: Tensor_Expr ',' tenTwo :: Tensor_Expr ','
                      tenThree :: Tensor_Expr ')'
{
  e.ast = scalar_triple_product_a(tenOne.ast,tenTwo.ast,tenThree.ast, location = e.location);
}

concrete production float_scalar_triple_product_c
e::AssignExpr_c ::= 'float_triple_productT' '(' tenOne :: Tensor_Expr ',' tenTwo :: Tensor_Expr ','
                      tenThree :: Tensor_Expr ')'
{
  e.ast = float_scalar_triple_product_a(tenOne.ast,tenTwo.ast,tenThree.ast, location = e.location);
}

concrete production vector_triple_product_c
e::Tensor_Expr ::= 'vector_triple_productT' '(' tenOne :: Tensor_Expr ',' tenTwo :: Tensor_Expr ','
                      tenThree :: Tensor_Expr ')'
{
  e.ast = vector_triple_product_a(tenOne.ast,tenTwo.ast,tenThree.ast, location = e.location);
}

concrete production trace_c
e::Tensor_Expr ::= 'traceT' '(' value :: Tensor_Expr ')'
{
  e.ast = trace_a(value.ast, location = e.location);
}

concrete production tensor_trace_c
e::Tensor_Expr ::= 'tensor_traceT' '(' value :: Tensor_Expr ')'
{
  e.ast = tensor_trace_a(value.ast, location = e.location);
}

concrete production free_tensor_c
e::Tensor_Expr ::= 'freeT' '(' value :: Tensor_Expr ')'
{
  e.ast = free_tensor_a(value.ast, location = e.location);
}

concrete production free_tensor_dynamic_c
e::AssignExpr_c ::= 'free_dynamic' '(' value :: AssignExpr_c ')'
{
  e.ast = free_tensor_dynamic_a(value.ast, location = e.location);
}

concrete production print_tensor_c
e::AssignExpr_c ::= 'printT' '(' value :: Tensor_Expr ')'
{
  e.ast = print_tensor_a(value.ast, location = e.location);
}
-}
