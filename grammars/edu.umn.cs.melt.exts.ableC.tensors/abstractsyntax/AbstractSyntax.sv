grammar edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

imports edu:umn:cs:melt:ableC:abstractsyntax;
imports edu:umn:cs:melt:ableC:concretesyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;
imports silver:langutil:pp;
imports silver:langutil;

abstract production ones_a
e::Expr ::= numDim :: Expr sizeDim :: Expr
{
  forwards to txtExpr("ones(" ++ show(80, numDim.pp) ++ ", " ++ show(80, sizeDim.pp) ++ ")", location = txtLoc("ableC-tensors"));
}
