grammar edu:umn:cs:melt:exts:ableC:tensors:concretesyntax;

imports edu:umn:cs:melt:ableC:concretesyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;

imports edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

imports silver:langutil only ast;


marking terminal TensorEnvOpen_t '[.';
terminal TensorEnvClose_t '.]';

marking terminal leftParen '(';
terminal rightParen ')';

marking terminal tensorPrint 'print';
marking terminal freeDynamic 'free_dynamic';
marking terminal free 'free';

concrete production single_element_tensor_c
e::PrimaryExpr_c ::= '[.' value :: AssignExpr_c '.]'
{
  e.ast = float_to_scalar_tensor (value.ast, location = left.location);
}

concrete production print_tensor_c
e::PrimaryExpr_c ::= 'print' '(' value :: AssignExpr_c ')'
{
  e.ast = print_tensor(value.ast,location = left.location);
}

concrete production free_tensor_c
e::PrimaryExpr_c ::= 'free' '(' value :: AssignExpr_c ')'
{
  e.ast = free_tensor(value.ast,location = left.location);
}

concrete production free_tensor_dynamic_c
e::PrimaryExpr_c ::= 'free_dynamic' '(' value :: AssignExpr_c ')'
{
  e.ast = free_tensor_dynamic(value.ast,location = left.location);
}
