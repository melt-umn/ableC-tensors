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
  forwards to directCallExpr(
    name(
    "ones",
    location = txtLoc("ableC-tensors")),
    consExpr (
      numDim,
      consExpr(
        sizeDim,
        nilExpr()
      )
    ),
    location = txtLoc("ableC-tensors")
  );
}

abstract production print_tensor_a
e::Expr ::= tensor :: Expr
{
  forwards to txtExpr("print_tensor(" ++ show(80, tensor.pp) ++ ", delimiters, 10)", location = txtLoc("ableC-tensors"));
}

--i changed it to just float_to_scalar_tensor_a to begin with since that's the one most similar to matlab
--when i try to make, it can't find the function for some reason. i'm not sure why, but it makes me sad. :(
--check type of float in here probably? if it isn't a float we want to raise an error instead of passing it to the function
abstract production float_to_scalar_tensor_a
e::Expr ::= float :: Expr
{
  forwards to floatToScalarTensor(float, e.location);
}

--matlab splits up the c calls as functions, separate from the abstract productions
--do we wish to do this as well? :)
function floatToScalarTensor
Expr ::= float :: Expr l :: Location
{
  return
    directCallExpr(
      name("float_to_scalar_tensor", location = l),
      consExpr (float, nilExpr()),
      location = l
    );
}
