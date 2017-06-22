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
marking terminal copy_tensor 'copy';
marking terminal transpose 'trans'; --done
marking terminal identity_tensor 'id'; --done
marking terminal identity_tensor_asymmetric 'id_as';
marking terminal fill_tensor 'fill';
marking terminal ones 'ones';
marking terminal zeros 'zeros';
marking terminal tensor_to_float 'ten_to_float'; --done

marking terminal map 'map';
marking terminal square_all 'square';
marking terminal increment 'inc';

marking terminal fold 'fold';
marking terminal max 'max';
marking terminal min 'min';
marking terminal sum 'sum';
marking terminal product 'prod';
marking terminal tensor_max 'ten_max';
marking terminal tensor_min 'ten_min';
marking terminal tensor_sum 'ten_sum';
marking terminal tensor_product 'ten_prod';

marking terminal tensor_print 'print'; --done
marking terminal free_dynamic 'free_dynamic'; --done
marking terminal free 'free'; --done

concrete production float_to_scalar_tensor_c
--not positive FloatConstant_t is the one we want to use (from ableC:concretesyntax)
--will ask Eric about this, but using this for all floats for now :)
e::PrimaryExpr_c ::= '[.' value :: FloatConstant_t '.]'
{
  e.ast = float_to_scalar_tensor_a (value.ast, location = left.location);
}

concrete production transpose_tensor_c
e::PrimaryExpr_c ::= 'trans' '(' value :: AssignExpr_c ')';
{
  e.ast = tranpose_tensor_a(value.ast);
}

concrete production identity_tensor_c
e::PrimaryExpr_c ::= 'id' '(' numDim :: DecConstant_t sizeDim :: DecConstant_t ')'
{
  e.ast = identity_tensor_a(numDim.ast, sizeDim.ast);
}

concrete production scalar_tensor_to_float
e::PrimaryExpr_c ::= 'ten_to_float' '(' value :: AssignExpr_c ')'
{
  e.ast = scalar_tensor_to_float_a(value.ast);
}

concrete production print_tensor_c
--not sure how a tensor should be, using this since it's used in matlab concretesyntax
e::PrimaryExpr_c ::= 'print' '(' value :: AssignExpr_c ')'
{
  e.ast = print_tensor_a(value.ast);
}

concrete production free_tensor_c
e::PrimaryExpr_c ::= 'free' '(' value :: AssignExpr_c ')'
{
  e.ast = free_tensor_a(value.ast);
}

concrete production free_tensor_dynamic_c
e::PrimaryExpr_c ::= 'free_dynamic' '(' value :: AssignExpr_c ')'
{
  e.ast = free_tensor_dynamic_a(value.ast);
}
