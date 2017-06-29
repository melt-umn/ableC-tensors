grammar edu:umn:cs:melt:exts:ableC:tensors:concretesyntax;

imports edu:umn:cs:melt:ableC:concretesyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;

imports edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

imports silver:langutil:pp;
imports silver:langutil;

marking terminal TensorEnvOpen_t '[.';
terminal TensorEnvClose_t '.]';

{-marking terminal Create_tensor 'create';
marking terminal Access_tensor 'access'; --done
-}
marking terminal Float_to_tensor 'float_to_tensor'; --done
{-
marking terminal Copy_tensor 'copy'; --done
marking terminal Transpose 'trans'; --done
marking terminal Identity_tensor 'id'; --done
marking terminal Identity_tensor_asymmetric 'id_as'; --done
marking terminal Fill_tensor 'fill';
marking terminal Ones 'onesss' lexer classes {Ckeyword};
marking terminal Zeros 'zeros';
marking terminal Tensor_to_float 'ten_to_float'; --done

marking terminal Map_tensor 'map';
marking terminal Square_all 'square'; --done
marking terminal Increment 'inc'; --done

marking terminal Fold 'fold';
marking terminal Max 'max'; --done
marking terminal Min 'min'; --done
marking terminal Sum 'sum'; --done
marking terminal Product 'prod'; --done
marking terminal Tensor_max 'ten_max'; --done
marking terminal Tensor_min 'ten_min'; --done
marking terminal Tensor_sum 'ten_sum'; --done
marking terminal Tensor_product 'ten_prod'; --done

marking terminal Tensor_combine 'tensor_combine';
marking terminal Tensor_elem_add 'tensor_elem_add'; --done
marking terminal Tensor_elem_subtract 'tensor_elem_subtract'; --done
marking terminal Tensor_elem_multiply 'tensor_elem_multiply'; --done
marking terminal Tensor_elem_divide 'tensor_elem_divide'; --done

marking terminal Dot_product 'dot'; --done
marking terminal Float_dot_product 'float_dot'; --done
marking terminal Float_dot_product_vtwo 'float_dot_vtwo'; --done
marking terminal Cross_product 'cross'; --done
marking terminal Scalar_triple_product 'scalar_triple_product'; --done
marking terminal Float_scalar_triple_product 'float_triple_product'; --done
marking terminal Vector_triple_product 'vector_triple_product'; --done

marking terminal Trace 'trace'; --done
marking terminal Tensor_trace 'tensor_trace'; --done

marking terminal Free 'free'; --done
marking terminal Free_dynamic 'free_dynamic'; --done
marking terminal Tensor_print 'printt' lexer classes {Ckeyword}; --done
concrete production create_c
e::Expr_c ::= 'create' '(' numDim :: AssignExpr_c ',' dimSize :: AssignExpr_c ',' count :: AssignExpr_c ',' data :: AssignExpr_c')'
{
  e.ast = create_a(numDim, dimSize, count, data);
}

concrete production access_c
e::Expr_c ::= 'access' '(' tensor :: AssignExpr_c ',' interval :: AssignExpr_c ')'
{
  e.ast = access_a (tensor.ast);
}
-}
concrete production float_to_scalar_tensor_c
e::PrimaryExpr_c ::= left :: TensorEnvOpen_t value :: AssignExpr_c '.]'
{
  e.ast = float_to_scalar_tensor_a(value.ast, location = left.location);
}
{-
concrete production copy_tensor_c
e::Expr_c ::= 'copy' '(' value :: AssignExpr_c ')'
{
  e.ast = copy_tensor_a(value.ast);
}

concrete production transpose_tensor_c
e::Expr_c ::= 'trans' '(' value :: AssignExpr_c ')'
{
  e.ast = tranpose_tensor_a(value.ast);
}

concrete production identity_tensor_c
e::Expr_c ::= 'id' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = identity_tensor_a(numDim.ast, sizeDim.ast);
}

concrete production fill_tensor_c
e::Expr_c ::= 'fill' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ',' toFill :: AssignExpr_c ')'
{
  e.ast = fill_tensor_a(numDim.ast, sizeDim.ast, toFill.ast);
}

concrete production identity_tensor_asymmetric_c
e::Expr_c ::= 'id_as' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = identity_tensor_assymetric_a(numDim.ast, sizeDim.ast);
}
concrete production ones_c
e::AssignExpr_c ::= 'onesss' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = ones_a(numDim.ast, sizeDim.ast, location = txtLoc("ableC-tensors"));
}
concrete production zeros_c
e::Expr_c ::= 'zeros' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = zeros_a(numDim.ast, sizeDim.ast);
}

concrete production scalar_tensor_to_float
e::AssignExpr_c ::= 'ten_to_float' '(' value :: AssignExpr_c ')'
{
  e.ast = scalar_tensor_to_float_a(value.ast);
}

concrete production square_c
e::Expr_c ::= 'square' '(' value :: AssignExpr_c ')'
{
  e.ast = square_a(value.ast);
}

concrete production increment_c
e::Expr_c ::= 'inc' '(' value :: AssignExpr_c ')'
{
  e.ast = increment_a(value.ast);
}

concrete production max_c
e::AssignExpr_c ::= 'max' '(' value :: AssignExpr_c ')'
{
  e.ast = max_a(value.ast);
}

concrete production min_c
e::AssignExpr_c ::= 'min' '(' value :: AssignExpr_c ')'
{
  e.ast = min_a(value.ast);
}

concrete production sum_c
e::AssignExpr_c ::= 'sum' '(' value :: AssignExpr_c ')'
{
  e.ast = sum_a(value.ast);
}

concrete production product_c
e::AssignExpr_c ::= 'prod' '(' value :: AssignExpr_c ')'
{
  e.ast = product_a(value.ast);
}

concrete production tensor_max_c
e::Expr_c ::= 'ten_max' '(' value :: AssignExpr_c ')'
{
  e.ast = tensor_max_a(value.ast);
}

concrete production tensor_min_c
e::Expr_c ::= 'ten_min' '(' value :: AssignExpr_c ')'
{
  e.ast = tensor_min_a(value.ast);
}

concrete production tensor_sum_c
e::Expr_c ::= 'ten_sum' '(' value :: AssignExpr_c ')'
{
  e.ast = tensor_sum_a(value.ast);
}

concrete production tensor_product_c
e::Expr_c ::= 'ten_prod' '(' value :: AssignExpr_c ')'
{
  e.ast = tensor_product_a(value.ast);
}

concrete production tensor_elem_add_c
e::Expr_c ::= 'tensor_elem_add' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = tensor_elem_add_a(valueOne.ast,valueTwo.ast);
}

concrete production tensor_elem_subtract_c
e::Expr_c ::= 'tensor_elem_subtract' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = tensor_elem_subtract_a(valueOne.ast,valueTwo.ast);
}

concrete production tensor_elem_multiply_c
e::Expr_c ::= 'tensor_elem_multiply' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = tensor_elem_multiply_a(valueOne.ast,valueTwo.ast);
}

concrete production tensor_elem_divide_c
e::Expr_c ::= 'tensor_elem_divide' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = tensor_elem_divide_a(valueOne.ast,valueTwo.ast);
}

concrete production dot_product_c
e::Expr_c ::= 'dot' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = dot_product_a(valueOne.ast,valueTwo.ast);
}

concrete production float_dot_product_c
e::AssignExpr_c ::= 'float_dot' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = float_dot_product_a(valueOne.ast,valueTwo.ast);
}

concrete production float_dot_product_vtwo_c
e::AssignExpr_c ::= 'float_dot_vtwo' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = float_dot_product_vtwo_a(valueOne.ast,valueTwo.ast);
}

concrete production cross_product_c
e::Expr_c ::= 'cross' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = cross_product_a(valueOne.ast,valueTwo.ast);
}

concrete production scalar_triple_product_c
e::Expr_c ::= 'scalar_triple_product' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ','
                      valueThree :: AssignExpr_c ')'
{
  e.ast = scalar_triple_product_a(valueOne.ast,valueTwo.ast,valueThree.ast);
}

concrete production float_scalar_triple_product_c
e::AssignExpr_c ::= 'float_triple_product' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ','
                      valueThree :: AssignExpr_c ')'
{
  e.ast = float_scalar_triple_product_a(valueOne.ast,valueTwo.ast,valueThree.ast);
}

concrete production vector_triple_product_c
e::Expr_c ::= 'vector_triple_product' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ','
                      valueThree :: AssignExpr_c ')'
{
  e.ast = vector_triple_product_a(valueOne.ast,valueTwo.ast,valueThree.ast);
}


concrete production trace_c
e::Expr_c ::= 'trace' '(' value :: AssignExpr_c ')'
{
  e.ast = trace_a(value.ast);
}

concrete production tensor_trace_c
e::Expr_c ::= 'tensor_trace' '(' value :: AssignExpr_c ')'
{
  e.ast = tensor_trace_a(value.ast);
}

--no return type, not sure what to put?
concrete production free_tensor_c
e::Expr_c ::= 'free' '(' value :: AssignExpr_c ')'
{
  e.ast = free_tensor_a(value.ast);
}

concrete production free_tensor_dynamic_c
e::Expr_c ::= 'free_dynamic' '(' value :: AssignExpr_c ')'
{
  e.ast = free_tensor_dynamic_a(value.ast);
}
concrete production print_tensor_c
--not sure how a tensor should be, using this since it's used in matlab concretesyntax
e::AssignExpr_c ::= 'printt' '(' value :: AssignExpr_c ')'
{
  e.ast = print_tensor_a(value.ast, location = txtLoc("ableC-tensors"));
}
-}
