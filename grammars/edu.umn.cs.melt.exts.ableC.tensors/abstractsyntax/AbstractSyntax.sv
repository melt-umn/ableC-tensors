grammar edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

imports edu:umn:cs:melt:ableC:abstractsyntax;
imports edu:umn:cs:melt:ableC:concretesyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;
imports silver:langutil:pp;
imports silver:langutil;
imports edu:umn:cs:melt:ableC:abstractsyntax:env;

global module_name::String = "ableC-tensors";

abstract production generate_location
generated::Location ::= original::Location module_name::String
{
  generated.unparse = "Generated by " ++ module_name ++ original.unparse;
  forwards to original;
}

{-
abstract production create_a
e::Expr ::= numDim :: Expr dimSize :: Expr count :: Expr data :: Expr
{
  forwards to directCallExpr(
    name(
     "create_tensor",
     location = generate_location(e.location, module_name)
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
    location = generate_location(e.location, module_name)
  );
}

abstract production access_a
e::Expr ::= tensor :: Expr interval :: Expr
{
  forwards to directCallExpr(
    name(
     "access_tensor",
     location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      consExpr(interval,
        nilExpr()
      )
    ),
    location = generate_location(e.location, module_name)
  );
}

abstract production copy_tensor_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "copy_tensor",
      location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}

abstract production transpose_tensor_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "transpose",
      location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}

abstract production identity_tensor_a
e::Expr ::= numDim :: Expr sizeDim :: Expr
{
  forwards to directCallExpr(
    name(
     "create_identity_tensor",
     location = generate_location(e.location, module_name)
    ),
    consExpr(numDim,
      consExpr(sizeDim,
        nilExpr()
      )
    ),
    location = generate_location(e.location, module_name)
  );
}

abstract production identity_tensor_asymmetric_a
e::Expr ::=  numDim :: Expr dimArr :: Expr
{
  forwards to directCallExpr(
    name(
     "create_identity_tensor_asymmetric",
     location = generate_location(e.location, module_name)
    ),
    consExpr(numDim,
      consExpr(dimArr,
        nilExpr()
      )
    ),
    location = generate_location(e.location, module_name)
  );
}
-}

abstract production fill_tensor_a
e::Expr ::= numDim :: Expr sizeDim :: Expr toFill :: Expr
{
  forwards to directCallExpr(
    name(
     "fill_tensor",
     location = generate_location(e.location, module_name)
    ),
    consExpr(numDim,
      consExpr(sizeDim,
		    consExpr(toFill,
 	       nilExpr()
		    )
      )
    ),
    location = generate_location(e.location, module_name)
  );
}

abstract production ones_a
e::Expr ::= numDim :: Expr sizeDim :: Expr
{
  forwards to directCallExpr(
    name(
     "ones",
     location = generate_location(e.location, module_name)
    ),
    consExpr(numDim,
      consExpr(sizeDim,
        nilExpr()
      )
    ),
    location = generate_location(e.location, module_name)
  );
}


abstract production zeros_a
e::Expr ::= numDim :: Expr sizeDim :: Expr
{
  forwards to directCallExpr(
    name(
     "zeros",
     location = generate_location(e.location, module_name)
    ),
    consExpr(numDim,
      consExpr(sizeDim,
        nilExpr()
      )
    ),
    location = generate_location(e.location, module_name)
  );
}

abstract production float_to_scalar_tensor_a
e::Expr ::= float :: Expr
{
  forwards to directCallExpr(
    name(
      "float_to_scalar_tensor",
      location = generate_location(e.location, module_name)
    ),
    consExpr (float,
      nilExpr()
    ),
    location = generate_location(e.location, module_name)
  );
}

abstract production scalar_tensor_to_float_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "scalar_tensor_to_float",
      location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      nilExpr()
    ),
    location = generate_location(e.location, module_name)
  );
}

{-

abstract production map_a
e::Expr ::= fun :: Expr tensor :: Expr
{
  forwards to directCallExpr(
    name(
     "map",
     location = generate_location(e.location, module_name)
    ),
    consExpr(fun,
      consExpr(tensor,
        nilExpr()
      )
    ),
    location = generate_location(e.location, module_name)
  );
}

abstract production square_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "square",
      location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}

abstract production increment_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "increment",
      location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}

abstract production fold_a
e::Expr ::= fun :: Expr valueStart :: Expr tensor :: Expr
{
  forwards to directCallExpr(
    name(
     "fold",
     location = generate_location(e.location, module_name)
    ),
    consExpr(fun,
      consExpr(valueStart,
		    consExpr(tensor,
 	       nilExpr()
		    )
      )
    ),
    location = generate_location(e.location, module_name)
  );
}

abstract production tensor_fold_a
e::Expr ::= fun :: Expr tensorStart :: Expr tensor :: Expr
{
  forwards to directCallExpr(
    name(
     "tensor_fold",
     location = generate_location(e.location, module_name)
    ),
    consExpr(fun,
      consExpr(tensorStart,
		    consExpr(tensor,
 	       nilExpr()
		    )
      )
    ),
    location = generate_location(e.location, module_name)
  );
}

abstract production max_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "max",
      location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}

abstract production min_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "min",
      location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}

abstract production sum_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "sum",
      location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}

abstract production product_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "product",
      location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}

abstract production tensor_max_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "tensor_max",
      location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}

abstract production tensor_min_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "tensor_min",
      location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}

abstract production tensor_sum_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "tensor_sum",
      location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}

abstract production tensor_product_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "tensor_product",
      location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}

abstract production tensor_combine_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "tensor_combine",
     location = generate_location(e.location, module_name)
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = generate_location(e.location, module_name)
  );
}

abstract production tensor_elem_add_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "tensor_elem_add",
     location = generate_location(e.location, module_name)
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = generate_location(e.location, module_name)
  );
}

abstract production tensor_elem_subtract_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "tensor_elem_subtract",
     location = generate_location(e.location, module_name)
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = generate_location(e.location, module_name)
  );
}

abstract production tensor_elem_multiply_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "tensor_elem_multiply",
     location = generate_location(e.location, module_name)
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = generate_location(e.location, module_name)
  );
}

abstract production tensor_elem_divide_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "tensor_elem_divide",
     location = generate_location(e.location, module_name)
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = generate_location(e.location, module_name)
  );
}

abstract production tensor_multiply_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "tensor_multiply",
     location = generate_location(e.location, module_name)
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = generate_location(e.location, module_name)
  );
}
-}

abstract production dot_product_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "dot_product",
     location = generate_location(e.location, module_name)
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = generate_location(e.location, module_name)
  );
}

abstract production float_dot_product_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "float_dot_product",
     location = generate_location(e.location, module_name)
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = generate_location(e.location, module_name)
  );
}


abstract production cross_product_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "cross_product",
     location = generate_location(e.location, module_name)
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        nilExpr()
      )
    ),
    location = generate_location(e.location, module_name)
  );
}
{-
abstract production scalar_triple_product_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr tenThree :: Expr
{
  forwards to directCallExpr(
    name(
     "scalar_triple_product",
     location = generate_location(e.location, module_name)
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        consExpr(tenThree,
          nilExpr()
        )
      )
    ),
    location = generate_location(e.location, module_name)
  );
}

abstract production float_scalar_triple_product_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr tenThree :: Expr
{
  forwards to directCallExpr(
    name(
     "float_scalar_triple_product",
     location = generate_location(e.location, module_name)
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        consExpr(tenThree,
          nilExpr()
        )
      )
    ),
    location = generate_location(e.location, module_name)
  );
}

abstract production vector_triple_product_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr tenThree :: Expr
{
  forwards to directCallExpr(
    name(
     "vector_triple_product",
     location = generate_location(e.location, module_name)
    ),
    consExpr(tenOne,
      consExpr(tenTwo,
        consExpr(tenThree,
          nilExpr()
        )
      )
    ),
    location = generate_location(e.location, module_name)
  );
}

abstract production trace_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "trace",
      location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}

abstract production tensor_trace_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "tensor_trace",
      location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}

abstract production free_tensor_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "free_tensor",
      location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}

abstract production free_tensor_dynamic_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "free_tensor_dynamic",
      location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}
-}

abstract production print_tensor_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "print_tensor_compact",
      location = generate_location(e.location, module_name)
    ),
    consExpr(tensor,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}
