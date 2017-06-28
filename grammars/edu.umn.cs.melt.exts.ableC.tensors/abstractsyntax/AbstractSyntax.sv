grammar edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

imports edu:umn:cs:melt:ableC:abstractsyntax;
imports edu:umn:cs:melt:ableC:concretesyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;
imports silver:langutil:pp;
imports silver:langutil;
imports edu:umn:cs:melt:ableC:abstractsyntax:env;

--i changed it to just float_to_scalar_tensor_a to begin with since that's the one most similar to matlab
--when i try to make, it can't find the function for some reason. i'm not sure why, but it makes me sad. :(

{-
abstract production ones_a
e::Expr ::= numDim :: Expr sizeDim :: Expr
{
  forwards to txtExpr("ones(" ++ show(80, numDim.pp) ++ ", " ++ show(80, sizeDim.pp) ++ ")", location = txtLoc("ableC-tensors"));
  numDim.env = e.env;
  sizeDim.env = e.env;
}
-}

abstract production float_to_scalar_tensor_a
e::Expr ::= float :: Expr l = Location{
	forwards to floatToScalarTensor(float, l);
}

{-
abstract production print_tensor_a
e::Expr ::= tensor :: Expr{
  forwards to directCallExpr (
    name(ones), tensor
  );
  tensor.env = e.env;
}
-}

function floatToScalarTensor
Expr ::= float :: Expr loc = Location
{
	return 
		directCallExpr(
			name("float_to_scalar_tensor", location = l),
			consExpr (float, nilExpr()),
			location = l
		);
}
