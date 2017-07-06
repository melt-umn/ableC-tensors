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
      location = loc
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = loc
  );
}

abstract production transpose_tensor_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "transpose",
      location = loc
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = loc
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

{-
abstract production float_to_scalar_tensor_a
e::Expr ::= float :: Expr
{
  local localErrors::[Message] =
    (if float.typerep.isArithmeticType && !float.typerep.isIntegerType
    then [err(float.location,s"Tensor element must have float type (got ${showType(float.typerep)})")]
    else []);
  local fwrd::Expr =
    directCallExpr(
      name(
        "float_to_scalar_tensor", location = loc
      ),
      consExpr(float,
        nilExpr()
      ),
      location = loc
    );
  forwards to mkErrorCheck(localErrors, fwrd);
}
-}

abstract production float_to_scalar_tensor_a
e::Expr ::= float :: Expr
{
  forwards to directCallExpr(
    name(
      "float_to_scalar_tensor",
      location = loc
    ),
    consExpr (float,
      nilExpr()
    ),
    location = loc
  );
}


abstract production scalar_tensor_to_float_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "scalar_tensor_to_float",
      location = loc
    ),
    consExpr(tensor,
      nilExpr()
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
      location = loc
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = loc
  );
}

abstract production increment_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "increment",
      location = loc
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = loc
  );
}

abstract production fold_a
e::Expr ::= fun :: Expr valueStart :: Expr tensor :: Expr
{
  forwards to directCallExpr(
    name(
     "fold",
     location = loc
    ),
    consExpr(fun,
      consExpr(valueStart,
		    consExpr(tensor,
 	       nilExpr()
		    )
      )
    ),
    location = loc
  );
}

abstract production tensor_fold_a
e::Expr ::= fun :: Expr tensorStart :: Expr tensor :: Expr
{
  forwards to directCallExpr(
    name(
     "tensor_fold",
     location = loc
    ),
    consExpr(fun,
      consExpr(tensorStart,
		    consExpr(tensor,
 	       nilExpr()
		    )
      )
    ),
    location = loc
  );
}

abstract production max_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "max",
      location = loc
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = loc
  );
}

abstract production min_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "min",
      location = loc
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = loc
  );
}

abstract production sum_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "sum",
      location = loc
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = loc
  );
}

abstract production product_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "product",
      location = loc
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = loc
  );
}

abstract production tensor_max_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "tensor_max",
      location = loc
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = loc
  );
}

abstract production tensor_min_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "tensor_min",
      location = loc
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = loc
  );
}

abstract production tensor_sum_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "tensor_sum",
      location = loc
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = loc
  );
}

abstract production tensor_product_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "tensor_product",
      location = loc
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = loc
  );
}

abstract production tensor_combine_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "tensor_combine",
     location = loc
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = loc
  );
}

abstract production tensor_elem_add_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "tensor_elem_add",
     location = loc
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = loc
  );
}

abstract production tensor_elem_subtract_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "tensor_elem_subtract",
     location = loc
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = loc
  );
}

abstract production tensor_elem_multiply_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "tensor_elem_multiply",
     location = loc
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = loc
  );
}

abstract production tensor_elem_divide_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "tensor_elem_divide",
     location = loc
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = loc
  );
}

abstract production tensor_multiply_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "tensor_multiply",
     location = loc
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = loc
  );
}

abstract production dot_product_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "dot_product",
     location = loc
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = loc
  );
}

abstract production float_dot_product_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "float_dot_product",
     location = loc
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = loc
  );
}


abstract production float_dot_product_vtwo_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "float_dot_product_vtwo",
     location = loc
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = loc
  );
}


abstract production cross_product_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "cross_product",
     location = loc
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = loc
  );
}

abstract production scalar_triple_product_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr tenThree :: Expr
{
  forwards to directCallExpr(
    name(
     "scalar_triple_product",
     location = loc
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        consExpr(tenThree,
          nilExpr()
        )
      )
    ),
    location = loc
  );
}

abstract production float_scalar_triple_product_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr tenThree :: Expr
{
  forwards to directCallExpr(
    name(
     "float_scalar_triple_product",
     location = loc
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        consExpr(tenThree,
          nilExpr()
        )
      )
    ),
    location = loc
  );
}

abstract production vector_triple_product_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr tenThree :: Expr
{
  forwards to directCallExpr(
    name(
     "vector_triple_product",
     location = loc
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        consExpr(tenThree,
          nilExpr()
        )
      )
    ),
    location = loc
  );
}

abstract production trace_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "trace",
      location = loc
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = loc
  );
}

abstract production tensor_trace_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "tensor_trace",
      location = loc
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = loc
  );
}

abstract production free_tensor_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "free_tensor",
      location = loc
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = loc
  );
}

abstract production free_tensor_dynamic_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "free_tensor_dynamic",
      location = loc
    ),
    consExpr(tensor,
      nilExpr()
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
      location = loc
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = loc
  );
}

<<<<<<< HEAD
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

abstract production generate_location
loc::Location ::= 

global loc::Location = txtLoc("ableC-tensors");
