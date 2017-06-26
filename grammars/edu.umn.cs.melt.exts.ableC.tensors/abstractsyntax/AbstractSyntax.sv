grammar edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

imports edu:umn:cs:melt:ableC:abstractsyntax;
imports edu:umn:cs:melt:ableC:concretesyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;
imports silver:langutil:pp;
imports silver:langutil;
imports edu:umn:cs:melt:ableC:abstractsyntax:env;

abstract production ones_a
e::Expr ::= numDim :: Expr sizeDim :: Expr
{
  forwards to txtExpr("ones(" ++ show(80, numDim.pp) ++ ", " ++ show(80, sizeDim.pp) ++ ")", location = txtLoc("ableC-tensors"));
  numDim.env = e.env;
  sizeDim.env = e.env;
}

abstract production print_tensor_a
e::Expr ::= tensor :: Expr{
  forwards to directCallExpr (
    name(ones), tensor
  );
  tensor.env = e.env;
}
