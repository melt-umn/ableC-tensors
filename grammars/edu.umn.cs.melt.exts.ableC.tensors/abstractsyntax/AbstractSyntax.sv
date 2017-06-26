grammar edu:umn:cs:melt:exts:ableC:tensors:concretesyntax;

imports edu:umn:cs:melt:ableC:abstractsyntax;

imports edu:umn:cs:melt:ableC:abstractsyntax:construction;

abstract production ones_c
e::PrimaryExpr_c ::= numDim :: AssignExpr_c sizeDim :: AssignExpr_c
{
  forwards to txtExpr("ones(" ++ numDim.pp ++ ", " ++ sizeDim.pp ++ ")");
}
