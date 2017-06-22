grammar edu:umn:cs:melt:exts:ableC:tensors:concretesyntax;

--this is definitely wrong based on where things go now
imports edu:umn:cs:melt:ableC:concretesyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;

imports edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

imports silver:langutil only ast;

--lol idk how to reference pointers? so avoiding all the equations that use pointers lol
--also not sure how location works and where it's needed, so i'm not using it anywhere yet

marking terminal TensorEnvOpen_t '[.';
terminal TensorEnvClose_t '.]';

--we don't need these, they're defined in ableC:concretesyntax
--terminal leftParen '(';
--terminal rightParen ')';

marking terminal create_tensor 'create';
marking terminal access_tensor 'access';
marking terminal copy_tensor 'copy'; --done
marking terminal transpose 'trans'; --done
marking terminal identity_tensor 'id'; --done
marking terminal identity_tensor_asymmetric 'id_as';
marking terminal fill_tensor 'fill';
marking terminal ones 'ones';
marking terminal zeros 'zeros';
marking terminal tensor_to_float 'ten_to_float'; --done

marking terminal map 'map';
marking terminal square_all 'square'; --done
marking terminal increment 'inc'; --done

marking terminal fold 'fold';
marking terminal max 'max'; --done
marking terminal min 'min'; --done
marking terminal sum 'sum'; --done
marking terminal product 'prod'; --done
marking terminal tensor_max 'ten_max'; --done
marking terminal tensor_min 'ten_min'; --done
marking terminal tensor_sum 'ten_sum'; --done
marking terminal tensor_product 'ten_prod'; --done

marking terminal tensor_combine 'tensor_combine';
marking terminal tensor_elem_add 'tensor_elem_add'; --done
marking terminal tensor_elem_subtract 'tensor_elem_subtract'; --done
marking terminal tensor_elem_multiply 'tensor_elem_multiply'; --done
marking terminal tensor_elem_divide 'tensor_elem_divide'; --done

marking terminal dot_product 'dot'; --done
marking terminal float_dot_product 'float_dot'; --done
marking terminal float_dot_product_vtwo 'float_dot_vtwo'; --done
marking terminal cross_product 'cross'; --done
marking terminal scalar_triple_product 'scalar_triple_product'; --done
marking terminal float_scalar_triple_product 'float_triple_product'; --done
marking terminal vector_triple_product 'vector_triple_product'; --done

marking terminal trace 'trace'; --done
marking terminal tensor_trace 'tensor_trace'; --done

marking terminal free 'free'; --done
marking terminal free_dynamic 'free_dynamic'; --done
marking terminal tensor_print 'print'; --done


concrete production float_to_scalar_tensor_c
--not positive FloatConstant_t is the one we want to use (from ableC:concretesyntax)
--will ask Eric about this, but using this for all floats for now :)
e::PrimaryExpr_c ::= '[.' value :: FloatConstant_t '.]'
{
  e.ast = float_to_scalar_tensor_a (value.ast, location = left.location);
}

concrete production copy_tensor_c
e::PrimaryExpr_c ::= 'copy' '(' value :: AssignExpr_c ')';
{
  e.ast = copy_tensor_a(value.ast);
}

concrete production transpose_tensor_c
e::PrimaryExpr_c ::= 'trans' '(' value :: AssignExpr_c ')';
{
  e.ast = tranpose_tensor_a(value.ast);
}

concrete production identity_tensor_c
e::PrimaryExpr_c ::= 'id' '(' numDim :: DecConstant_t ',' sizeDim :: DecConstant_t ')'
{
  e.ast = identity_tensor_a(numDim.ast, sizeDim.ast);
}

concrete production scalar_tensor_to_float
e::FloatConstant_t ::= 'ten_to_float' '(' value :: AssignExpr_c ')'
{
  e.ast = scalar_tensor_to_float_a(value.ast);
}

concrete production square_c
e::PrimaryExpr_c ::= 'square' '(' value :: AssignExpr_c ')'
{
  e.ast = square_a(value.ast);
}

concrete production increment_c
e::PrimaryExpr_c ::= 'inc' '(' value :: AssignExpr_c ')'
{
  e.ast = increment_a(value.ast);
}

concrete production max_c
e::FloatConstant_t ::= 'max' '(' value :: AssignExpr_c ')'
{
  e.ast = max_a(value.ast);
}

concrete production min_c
e::FloatConstant_t ::= 'min' '(' value :: AssignExpr_c ')'
{
  e.ast = min_a(value.ast);
}

concrete production sum_c
e::FloatConstant_t ::= 'sum' '(' value :: AssignExpr_c ')'
{
  e.ast = sum_a(value.ast);
}

concrete production product_c
e::FloatConstant_t ::= 'prod' '(' value :: AssignExpr_c ')'
{
  e.ast = product_a(value.ast);
}

concrete production tensor_max_c
e::PrimaryExpr_c ::= 'ten_max' '(' value :: AssignExpr_c ')'
{
  e.ast = tensor_max_a(value.ast);
}

concrete production tensor_min_c
e::PrimaryExpr_c ::= 'ten_min' '(' value :: AssignExpr_c ')'
{
  e.ast = tensor_min_a(value.ast);
}

concrete production tensor_sum_c
e::PrimaryExpr_c ::= 'ten_sum' '(' value :: AssignExpr_c ')'
{
  e.ast = tensor_sum_a(value.ast);
}

concrete production tensor_product_c
e::PrimaryExpr_c ::= 'ten_prod' '(' value :: AssignExpr_c ')'
{
  e.ast = tensor_product_a(value.ast);
}

concrete production tensor_elem_add_c
e::PrimaryExpr_c ::= 'tensor_elem_add' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = tensor_elem_add_a(valueOne.ast,valueTwo.ast);
}

concrete production tensor_elem_subtract_c
e::PrimaryExpr_c ::= 'tensor_elem_subtract' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = tensor_elem_subtract_a(valueOne.ast,valueTwo.ast);
}

concrete production tensor_elem_multiply_c
e::PrimaryExpr_c ::= 'tensor_elem_multiply' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = tensor_elem_multiply_a(valueOne.ast,valueTwo.ast);
}

concrete production tensor_elem_divide_c
e::PrimaryExpr_c ::= 'tensor_elem_divide' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = tensor_elem_divide_a(valueOne.ast,valueTwo.ast);
}

concrete production dot_product_c
e::PrimaryExpr_c ::= 'dot' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = dot_product_a(valueOne.ast,valueTwo.ast);
}

concrete production float_dot_product_c
e::FloatConstant_t ::= 'float_dot' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = float_dot_product_a(valueOne.ast,valueTwo.ast);
}

concrete production float_dot_product_vtwo_c
e::FloatConstant_t ::= 'float_dot_vtwo' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = float_dot_product_vtwo_a(valueOne.ast,valueTwo.ast);
}

concrete production cross_product_c
e::PrimaryExpr_c ::= 'cross' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c ')'
{
  e.ast = cross_product_a(valueOne.ast,valueTwo.ast);
}

concrete production scalar_triple_product_c
e::PrimaryExpr_c ::= 'scalar_triple_product' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c,
                      valueThree :: AssignExpr_c ')'
{
  e.ast = scalar_triple_product_a(valueOne.ast,valueTwo.ast,valueThree.ast);
}

concrete production float_scalar_triple_product_c
e::FloatConstant_t ::= 'float_triple_product' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c,
                      valueThree :: AssignExpr_c ')'
{
  e.ast = float_scalar_triple_product_a(valueOne.ast,valueTwo.ast,valueThree.ast);
}

concrete production vector_triple_product_c
e::PrimaryExpr_c ::= 'vector_triple_product' '(' valueOne :: AssignExpr_c ',' valueTwo :: AssignExpr_c,
                      valueThree :: AssignExpr_c ')'
{
  e.ast = vector_triple_product_a(valueOne.ast,valueTwo.ast,valueThree.ast);
}


concrete production trace_c
e::PrimaryExpr_c ::= 'trace' '(' value :: AssignExpr_c ')'
{
  e.ast = trace_a(value.ast);
}

concrete production tensor_trace_c
e::PrimaryExpr_c ::= 'tensor_trace' '(' value :: AssignExpr_c ')'
{
  e.ast = tensor_trace_a(value.ast);
}

--no return type, not sure what to put?
concrete production free_tensor_c
e ::= 'free' '(' value :: AssignExpr_c ')'
{
  e.ast = free_tensor_a(value.ast);
}

concrete production free_tensor_dynamic_c
e ::= 'free_dynamic' '(' value :: AssignExpr_c ')'
{
  e.ast = free_tensor_dynamic_a(value.ast);
}

concrete production print_tensor_c
--not sure how a tensor should be, using this since it's used in matlab concretesyntax
e ::= 'print' '(' value :: AssignExpr_c ')'
{
  e.ast = print_tensor_a(value.ast);
}
