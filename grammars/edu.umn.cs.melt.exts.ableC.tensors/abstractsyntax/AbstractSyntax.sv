grammar edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

imports edu:umn:cs:melt:ableC:abstractsyntax;
imports edu:umn:cs:melt:ableC:concretesyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;
imports silver:langutil:pp;
imports silver:langutil;
imports edu:umn:cs:melt:ableC:abstractsyntax:env;

abstract production fill_tensor_a
e::Expr ::= numDim :: Expr sizeDim :: Expr toFill :: Expr
{
  forwards to directCallExpr(
    name(
     "fill_tensor",
     location = loc
    ),
    consExpr(numDim,
      consExpr(sizeDim,
		consExpr(toFill,
 	       nilExpr()
		)
      )
    ),
    location = loc
  );
}


abstract production ones_a
e::Expr ::= numDim :: Expr sizeDim :: Expr
{
  forwards to directCallExpr(
    name(
     "ones",
     location = loc
    ),
    consExpr(numDim,
      consExpr(sizeDim,
        nilExpr()
      )
    ),
    location = loc
  );
}

abstract production zeros_a
e::Expr ::= numDim :: Expr sizeDim :: Expr
{
  forwards to directCallExpr(
    name(
     "zeros",
     location = loc
    ),
    consExpr(numDim,
      consExpr(sizeDim,
        nilExpr()
      )
    ),
    location = loc
  );
}


abstract production print_tensor_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "print_tensor_compact",
      location = e.location
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = e.location
  );
}

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

global loc::Location = txtLoc("ableC-tensors");
