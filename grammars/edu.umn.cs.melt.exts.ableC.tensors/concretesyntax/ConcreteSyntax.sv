grammar edu:umn:cs:melt:exts:ableC:tensors:concretesyntax;

imports edu:umn:cs:melt:ableC:concretesyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;


imports edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

imports silver:langutil:pp;
imports silver:langutil;

marking terminal TensorEnvOpen_t '[.';
terminal TensorEnvClose_t '.]';

marking terminal Create_tensor 'create' lexer classes {Ckeyword};
marking terminal Access_tensor 'access' lexer classes {Ckeyword}; --done

marking terminal Copy_tensor 'copy' lexer classes {Ckeyword}; --done
marking terminal Transpose 'trans' lexer classes {Ckeyword}; --done
marking terminal Identity_tensor 'id' lexer classes {Ckeyword}; --done
marking terminal Identity_tensor_asymmetric 'id_as' lexer classes {Ckeyword}; --done

marking terminal Fill_tensor 'fill' lexer classes {Ckeyword};
marking terminal Ones 'onesT' lexer classes {Ckeyword};
marking terminal Zeros 'zerosT' lexer classes {Ckeyword};
marking terminal Float_to_tensor 'float_to_tensor' lexer classes {Ckeyword}; --done

marking terminal Tensor_to_float 'ten_to_float' lexer classes {Ckeyword}; --done

marking terminal Map_tensor 'mapT' lexer classes {Ckeyword};
marking terminal Square_all 'squareT' lexer classes {Ckeyword}; --done
marking terminal Increment 'inc' lexer classes {Ckeyword}; --done
{-
marking terminal Fold 'fold' lexer classes {Ckeyword};
marking terminal Max 'maxT' lexer classes {Ckeyword}; --done
marking terminal Min 'minT' lexer classes {Ckeyword}; --done
marking terminal Sum 'sumT' lexer classes {Ckeyword}; --done
marking terminal Product 'prodT' lexer classes {Ckeyword}; --done
marking terminal Tensor_max 'ten_max' lexer classes {Ckeyword}; --done
marking terminal Tensor_min 'ten_min' lexer classes {Ckeyword}; --done
marking terminal Tensor_sum 'ten_sum' lexer classes {Ckeyword}; --done
marking terminal Tensor_product 'ten_prod' lexer classes {Ckeyword}; --done

marking terminal Tensor_combine 'ten_combine' lexer classes {Ckeyword};
marking terminal Tensor_elem_add 'ten_elem_add' lexer classes {Ckeyword}; --done
marking terminal Tensor_elem_subtract 'ten_elem_subtract' lexer classes {Ckeyword}; --done
marking terminal Tensor_elem_multiply 'ten_elem_multiply' lexer classes {Ckeyword}; --done
marking terminal Tensor_elem_divide 'tenselem_divide' lexer classes {Ckeyword}; --done

marking terminal Dot_product 'dot' lexer classes {Ckeyword}; --done
marking terminal Float_dot_product 'float_dot' lexer classes {Ckeyword}; --done
marking terminal Float_dot_product_vtwo 'float_dot_vtwo' lexer classes {Ckeyword}; --done
marking terminal Cross_product 'cross' lexer classes {Ckeyword}; --done
marking terminal Scalar_triple_product 'scalar_triple_product' lexer classes {Ckeyword}; --done
marking terminal Float_scalar_triple_product 'float_triple_product' lexer classes {Ckeyword}; --done
marking terminal Vector_triple_product 'vector_triple_product' lexer classes {Ckeyword}; --done
-}

marking terminal Trace 'traceT' lexer classes {Ckeyword}; --done
marking terminal Tensor_trace 'tensor_traceT' lexer classes {Ckeyword}; --done

marking terminal Free 'freeT' lexer classes {Ckeyword}; --done
marking terminal Free_dynamic 'free_dynamic' lexer classes {Ckeyword}; --done
marking terminal Tensor_print 'printT' lexer classes {Ckeyword}; --done


concrete production create_c
e::AssignExpr_c ::= 'create' '(' numDim :: AssignExpr_c ',' dimSize :: AssignExpr_c ',' count :: AssignExpr_c ',' data :: AssignExpr_c')'
{
  e.ast = create_a(numDim, dimSize, count, data);
}

concrete production access_c
e::AssignExpr_c ::= 'access' '(' tensor :: AssignExpr_c ',' interval :: AssignExpr_c ')'
{
  e.ast = access_a (tensor.ast, interval.ast, location = e.location);
}

concrete production float_to_scalar_tensor_c
e::PrimaryExpr_c ::= left :: TensorEnvOpen_t value :: AssignExpr_c '.]'
{
  e.ast = float_to_scalar_tensor_a(value.ast, location = e.location);
}

concrete production copy_tensor_c
e::AssignExpr_c ::= 'copy' '(' value :: AssignExpr_c ')'
{
  e.ast = copy_tensor_a(value.ast, location = e.location);
}

concrete production transpose_tensor_c
e::AssignExpr_c ::= 'trans' '(' value :: AssignExpr_c ')'
{
  e.ast = transpose_tensor_a(value.ast, location = e.location);
}

concrete production identity_tensor_c
e::AssignExpr_c ::= 'id' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = identity_tensor_a(numDim.ast, sizeDim.ast, location = e.location);
}

concrete production identity_tensor_asymmetric_c
e::AssignExpr_c ::= 'id_as' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = identity_tensor_asymmetric_a(numDim.ast, sizeDim.ast, location = e.location);
}

concrete production fill_tensor_c
e::AssignExpr_c ::= 'fill' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ',' toFill :: AssignExpr_c ')'
{
  e.ast = fill_tensor_a(numDim.ast, sizeDim.ast, toFill.ast, location = e.location);
}

concrete production ones_c
e::AssignExpr_c ::= 'onesT' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = ones_a(numDim.ast, sizeDim.ast, location = e.location);
}

concrete production zeros_c
e::AssignExpr_c ::= 'zerosT' '(' numDim :: AssignExpr_c ',' sizeDim :: AssignExpr_c ')'
{
  e.ast = zeros_a(numDim.ast, sizeDim.ast, location = e.location);
}

{-
concrete production scalar_tensor_to_float_c
e::AssignExpr_c ::= 'ten_to_float' '(' value :: AssignExpr_c ')'
{
  e.ast = scalar_tensor_to_float_a(value.ast, location = e.location);
}
-}

concrete production map_c
e::AssignExpr_c ::= 'mapT' '(' fun :: AssignExpr_c ',' tensor :: AssignExpr_c  ')'
{
	e.ast = map_a(fun.ast, tensor.ast, location = e.location);
}

concrete production square_c
e::AssignExpr_c ::= 'squareT' '(' value :: AssignExpr_c ')'
{
  e.ast = square_a(value.ast, location = e.location);
}

concrete production increment_c
e::AssignExpr_c ::= 'inc' '(' value :: AssignExpr_c ')'
{
  e.ast = increment_a(value.ast, location = e.location);
}

{-
concrete production max_c
e::AssignExpr_c ::= 'maxT' '(' value :: AssignExpr_c ')'
{
  e.ast = max_a(value.ast, location = e.location);
}

concrete production min_c
e::AssignExpr_c ::= 'minT' '(' value :: AssignExpr_c ')'
{
  e.ast = min_a(value.ast, location = e.location);
}

concrete production sum_c
e::AssignExpr_c ::= 'sumT' '(' value :: AssignExpr_c ')'
{
  e.ast = sum_a(value.ast, location = e.location);
}

concrete production product_c
e::AssignExpr_c ::= 'prodT' '(' value :: AssignExpr_c ')'
{
  e.ast = product_a(value.ast, location = e.location);
}

concrete production tensor_max_c
e::AssignExpr_c ::= 'ten_max' '(' value :: AssignExpr_c ')'
{
  e.ast = tensor_max_a(value.ast, location = e.location);
}

concrete production tensor_min_c
e::AssignExpr_c ::= 'ten_min' '(' value :: AssignExpr_c ')'
{
  e.ast = tensor_min_a(value.ast, location = e.location);
}

concrete production tensor_sum_c
e::AssignExpr_c ::= 'ten_sum' '(' value :: AssignExpr_c ')'
{
  e.ast = tensor_sum_a(value.ast, location = e.location);
}

concrete production tensor_product_c
e::AssignExpr_c ::= 'ten_prod' '(' value :: AssignExpr_c ')'
{
  e.ast = tensor_product_a(value.ast, location = e.location);
}

concrete production tensor_elem_add_c
e::AssignExpr_c ::= 'tensor_elem_add' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = tensor_elem_add_a(valueOne.ast,valueTwo.ast, location = e.location);
}

concrete production tensor_elem_subtract_c
e::AssignExpr_c ::= 'tensor_elem_subtract' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = tensor_elem_subtract_a(valueOne.ast,valueTwo.ast, location = e.location);
}

concrete production tensor_elem_multiply_c
e::AssignExpr_c ::= 'tensor_elem_multiply' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = tensor_elem_multiply_a(valueOne.ast,valueTwo.ast, location = e.location);
}

concrete production tensor_elem_divide_c
e::AssignExpr_c ::= 'tensor_elem_divide' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = tensor_elem_divide_a(valueOne.ast,valueTwo.ast, location = e.location);
}

concrete production dot_product_c
e::AssignExpr_c ::= 'dot' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = dot_product_a(valueOne.ast,valueTwo.ast, location = e.location);
}

concrete production float_dot_product_c
e::AssignExpr_c ::= 'float_dot' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = float_dot_product_a(valueOne.ast,valueTwo.ast, location = e.location);
}

concrete production float_dot_product_vtwo_c
e::AssignExpr_c ::= 'float_dot_vtwo' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = float_dot_product_vtwo_a(valueOne.ast,valueTwo.ast, location = e.location);
}

concrete production cross_product_c
e::AssignExpr_c ::= 'cross' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = cross_product_a(valueOne.ast,valueTwo.ast, location = e.location);
}

concrete production scalar_triple_product_c
e::AssignExpr_c ::= 'scalar_triple_product' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ','
                      valueThree :: AssignExpr_c ')'
{
  e.ast = scalar_triple_product_a(valueOne.ast,valueTwo.ast,valueThree.ast, location = e.location);
}

concrete production float_scalar_triple_product_c
e::AssignExpr_c ::= 'float_triple_product' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ','
                      valueThree :: AssignExpr_c ')'
{
  e.ast = float_scalar_triple_product_a(valueOne.ast,valueTwo.ast,valueThree.ast, location = e.location);
}

concrete production vector_triple_product_c
e::AssignExpr_c ::= 'vector_triple_product' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ','
                      valueThree :: AssignExpr_c ')'
{
  e.ast = vector_triple_product_a(valueOne.ast,valueTwo.ast,valueThree.ast, location = e.location);
}
-}


concrete production trace_c
e::AssignExpr_c ::= 'traceT' '(' value :: AssignExpr_c ')'
{
  e.ast = trace_a(value.ast, location = e.location);
}

concrete production tensor_trace_c
e::AssignExpr_c ::= 'tensor_traceT' '(' value :: AssignExpr_c ')'
{
  e.ast = tensor_trace_a(value.ast, location = e.location);
}

concrete production free_tensor_c
e::AssignExpr_c ::= 'freeT' '(' value :: AssignExpr_c ')'
{
  e.ast = free_tensor_a(value.ast, location = e.location);
}

concrete production free_tensor_dynamic_c
e::AssignExpr_c ::= 'free_dynamic' '(' value :: AssignExpr_c ')'
{
  e.ast = free_tensor_dynamic_a(value.ast, location = e.location);
}

concrete production print_tensor_c
e::AssignExpr_c ::= 'printT' '(' value :: AssignExpr_c ')'
{
  e.ast = print_tensor_a(value.ast, location = e.location);
}
