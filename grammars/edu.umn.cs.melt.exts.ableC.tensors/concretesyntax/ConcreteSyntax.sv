grammar edu:umn:cs:melt:exts:ableC:tensors:concretesyntax;

--this is definitely wrong based on where things go now
imports edu:umn:cs:melt:ableC:concretesyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;

imports edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

imports silver:langutil only ast;


--lol idk how to reference pointers? so avoiding all the equations that use pointers lol

marking terminal TensorEnvOpen_t '[.';
terminal TensorEnvClose_t '.]';

--we don't need these, they're defined in ableC:concretesyntax
--terminal leftParen '(';
--terminal rightParen ')';

marking terminal create_tensor 'create';
marking terminal access_tensor 'access';
marking terminal copy_tensor 'copy';
marking terminal transpose 'trans';
marking terminal identity_tensor 'id';
marking terminal identity_tensor_asymmetric 'id_as';
marking terminal fill_tensor 'fill';
marking terminal ones 'ones';
marking terminal zeros 'zeros';
marking terminal tensor_to_float 'tens_to_float';

marking terminal map 'map';
marking terminal square_all 'square';
marking terminal increment 'inc';

marking terminal tensorPrint 'print'; --done
marking terminal freeDynamic 'free_dynamic'; --done
marking terminal free 'free'; --done

concrete production single_element_tensor_c
--not positive FloatConstant_t is the one we want to use (from ableC:concretesyntax)
--will ask Eric about this, but using this for all floats for now :)
e::PrimaryExpr_c ::= '[.' value :: FloatConstant_t '.]'
{
  e.ast = float_to_scalar_tensor_a (value.ast, location = left.location);
}

concrete production create_identity_tensor_c
e::PrimaryExpr_c ::= 'id' '(' numDim :: DecConstant_t sizeDim :: DecConstant_t ')'
{
  e.ast = identity_tensor_a(numDim.ast, sizeDim.ast, location = left.location);
}

concrete production print_tensor_c
--not sure how a tensor should be, using this since it's used in matlab concretesyntax
e::PrimaryExpr_c ::= 'print' '(' value :: AssignExpr_c ')'
{
  e.ast = print_tensor_a(value.ast,location = left.location);
}

concrete production free_tensor_c
e::PrimaryExpr_c ::= 'free' '(' value :: AssignExpr_c ')'
{
  e.ast = free_tensor_a(value.ast,location = left.location);
}

concrete production free_tensor_dynamic_c
e::PrimaryExpr_c ::= 'free_dynamic' '(' value :: AssignExpr_c ')'
{
  e.ast = free_tensor_dynamic_a(value.ast,location = left.location);
}
