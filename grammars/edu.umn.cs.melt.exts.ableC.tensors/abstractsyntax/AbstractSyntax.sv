grammar edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

imports edu:umn:cs:melt:ableC:abstractsyntax;
imports edu:umn:cs:melt:ableC:concretesyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;
imports silver:langutil:pp;
imports silver:langutil;
imports edu:umn:cs:melt:ableC:abstractsyntax:env;

abstract production create_a
e::Expr ::= numDim :: Expr dimSize :: Expr count :: Expr data :: Expr
{
  forwards to directCallExpr(
    name(
     "create_tensor",
     location = loc
    ),
    consExpr(numDim,
      consExpr(dimSize,
		    consExpr(count,
          consExpr(data,
 	          nilExpr()
          )
		    )
      )
    ),
    location = loc
  );
}

abstract production access_a
e::Expr ::= tensor :: Expr interval :: Expr
{
  forwards to directCallExpr(
    name(
     "access_tensor",
     location = loc
    ),
    consExpr(tensor,
      consExpr(interval,
        nilExpr()
      )
    ),
    location = loc
  );
}

abstract production copy_tensor_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "copy_tensor",
      location = e.location
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = e.location
  );
}

abstract production transpose_tensor_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "transpose",
      location = e.location
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = e.location
  );
}

abstract production identity_tensor_a
e::Expr ::= numDim :: Expr sizeDim :: Expr
{
  forwards to directCallExpr(
    name(
     "create_identity_tensor",
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

abstract production identity_tensor_asymmetric_a
e::Expr ::=  numDim :: Expr dimArr :: Expr
{
  forwards to directCallExpr(
    name(
     "create_identity_tensor_asymmetric",
     location = loc
    ),
    consExpr(numDim,
      consExpr(dimArr,
        nilExpr()
      )
    ),
    location = loc
  );
}

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

abstract production map_a
e::Expr ::= fun :: Expr tensor :: Expr
{
  forwards to directCallExpr(
    name(
     "map",
     location = loc
    ),
    consExpr(fun,
      consExpr(tensor,
        nilExpr()
      )
    ),
    location = loc
  );
}

abstract production square_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "square",
      location = e.location
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = e.location
  );
}

abstract production increment_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "increment",
      location = e.location
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = e.location
  );
}

abstract production trace_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "trace",
      location = e.location
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = e.location
  );
}

abstract production tensor_trace_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "tensor_trace",
      location = e.location
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = e.location
  );
}

abstract production free_tensor_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "free_tensor",
      location = e.location
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = e.location
  );
}

abstract production free_tensor_dynamic_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "free_tensor_dynamic",
      location = e.location
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = e.location
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
