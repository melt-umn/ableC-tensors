grammar edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

imports edu:umn:cs:melt:ableC:abstractsyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;
imports edu:umn:cs:melt:ableC:abstractsyntax:substitution;
imports edu:umn:cs:melt:ableC:abstractsyntax:env;
imports edu:umn:cs:melt:ableC:abstractsyntax:overload as ovrld;

imports edu:umn:cs:melt:ableC:concretesyntax;
imports silver:langutil:pp;
imports silver:langutil;

global module_name::String = "tensors";

abstract production generate_location
generated::Location ::= original::Location module_name::String
{
  generated.unparse = "Generated by " ++ module_name ++ original.unparse;
  forwards to original;
}

--next functions are overloaded tensor functions
aspect function ovrld:getNegativeOpOverload
Maybe<(Expr ::= Expr Location)> ::= l::Type env::Decorated Env
{
  overloads <-
    [pair(
      "edu:umn:cs:melt:exts:ableC:tensors:tensors",
       \ lhs::Expr loc::Location -> tensor_elem_negate_a(lhs, location=loc))];
}

aspect function ovrld:getEqualsOpOverload
Maybe<(Expr ::= Expr Expr Location)> ::= l::Type r::Type env::Decorated Env
{
  overloads <-
    [pair(
       pair(
         "edu:umn:cs:melt:exts:ableC:tensors:tensors",
         "edu:umn:cs:melt:exts:ableC:tensors:tensors"),
       \ lhs::Expr rhs::Expr loc::Location -> tensor_equals_a(lhs, rhs, location=loc))];
}

aspect function ovrld:getAddOpOverload
Maybe<(Expr ::= Expr Expr Location)> ::= l::Type r::Type env::Decorated Env
{
  overloads <-
    [pair(
       pair(
         "edu:umn:cs:melt:exts:ableC:tensors:tensors",
         "edu:umn:cs:melt:exts:ableC:tensors:tensors"),
       \ lhs::Expr rhs::Expr loc::Location -> tensor_elem_add_a(lhs, rhs, location=loc))];
}

aspect function ovrld:getSubOpOverload
Maybe<(Expr ::= Expr Expr Location)> ::= l::Type r::Type env::Decorated Env
{
  overloads <-
    [pair(
       pair(
         "edu:umn:cs:melt:exts:ableC:tensors:tensors",
         "edu:umn:cs:melt:exts:ableC:tensors:tensors"),
       \ lhs::Expr rhs::Expr loc::Location -> tensor_elem_sub_a(lhs, rhs, location=loc))];
}


--might wish to change this to reference normal tensor multiplication instead
aspect function ovrld:getMulOpOverload
Maybe<(Expr ::= Expr Expr Location)> ::= l::Type r::Type env::Decorated Env
{
  overloads <-
    [pair(
       pair(
         "edu:umn:cs:melt:exts:ableC:tensors:tensors",
         "edu:umn:cs:melt:exts:ableC:tensors:tensors"),
       \ lhs::Expr rhs::Expr loc::Location -> tensor_elem_mul_a(lhs, rhs, location=loc))];
}

aspect function ovrld:getDivOpOverload
Maybe<(Expr ::= Expr Expr Location)> ::= l::Type r::Type env::Decorated Env
{
  overloads <-
    [pair(
       pair(
         "edu:umn:cs:melt:exts:ableC:tensors:tensors",
         "edu:umn:cs:melt:exts:ableC:tensors:tensors"),
       \ lhs::Expr rhs::Expr loc::Location -> tensor_elem_div_a(lhs, rhs, location=loc))];
}


abstract production create_interval_double_bound_a
e::Expr ::= leftBound :: Expr rightBound :: Expr
{
  forwards to directCallExpr(
    name(
     "create_interval_double_bound",
     location = generate_location(e.location, module_name)
    ),
    consExpr(leftBound,
      consExpr(rightBound,
        nilExpr()
      )
    ),
    location = generate_location(e.location, module_name)
  );
}


abstract production create_interval_left_bound_a
e::Expr ::= leftBound :: Expr
{
  forwards to directCallExpr(
    name(
      "create_interval_left_bound",
      location = generate_location(e.location, module_name)
    ),
    consExpr(leftBound,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}

abstract production create_interval_right_bound_a
e::Expr ::= rightBound :: Expr
{
  forwards to directCallExpr(
    name(
      "create_interval_right_bound",
      location = generate_location(e.location, module_name)
    ),
    consExpr(rightBound,
      nilExpr()
    ),
     location = generate_location(e.location, module_name)
  );
}

abstract production create_interval_no_bound_a
e::Expr ::=
{
  forwards to directCallExpr(
    name(
     "create_interval_no_bound",
     location = generate_location(e.location, module_name)
    ),
    nilExpr(),
    location = generate_location(e.location, module_name)
  );
}


abstract production nil_tensor_a
e::Expr ::=
{
  forwards to directCallExpr(
    name(
     "empty_tensor",
     location = generate_location(e.location, module_name)
    ),
    nilExpr(),
    location = generate_location(e.location, module_name)
  );
}

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

abstract production tensor_elem_negate_a
e::Expr ::= tensor :: Expr
{
  forwards to directCallExpr(
    name(
      "negate",
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


--working here--
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

abstract production tensor_elem_sub_a
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

abstract production tensor_elem_mul_a
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

abstract production tensor_elem_div_a
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

abstract production tensor_equals_a
e::Expr ::= tenOne :: Expr tenTwo :: Expr
{
  forwards to directCallExpr(
    name(
     "tensor_equals",
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

abstract production tensorLiteral
e::Expr ::= tensor::Tensor
{
  e.numDim = tensor.numDim;
  e.dimSize = tensor.dimSize;
  e.count = tensor.count;
  e.data = tensor.data;

  local numDim :: Expr = mkIntConst(tensor.numDim, generate_location(e.location, module_name));
  local dimSize :: Expr = mkDimSizeExpr(tensor.dimSize, generate_location(e.location, module_name));
  local count :: Expr = mkIntConst(tensor.count, generate_location(e.location, module_name));
  local data :: Expr = mkDataExpr(tensor.data, generate_location(e.location, module_name));

  forwards to
    if null(tensor.errors)
    then create_a(numDim, dimSize, count, data, location=generate_location(e.location, module_name))
    else errorExpr(tensor.errors, location=e.location);
}

nonterminal Tensor with numDim, currentDimSize, dimSize, count, data, errors, env;
synthesized attribute numDim :: Integer occurs on Expr;
synthesized attribute currentDimSize :: Integer occurs on Expr;
synthesized attribute dimSize :: [Integer] occurs on Expr;
synthesized attribute count :: Integer occurs on Expr;
synthesized attribute data :: [Expr] occurs on Expr;
synthesized attribute interList :: [Expr] occurs on Expr;

abstract production consTensor
tensor::Tensor ::= e::Expr ts::Tensor
{
  tensor.numDim = e.numDim + 1;
  tensor.currentDimSize = e.currentDimSize + ts.currentDimSize;
  tensor.dimSize = tensor.currentDimSize :: e.dimSize;
  tensor.count = e.count + ts.count;
  tensor.data = e.data ++ ts.data;

  tensor.errors := e.errors ++ ts.errors;
  tensor.errors <-
    if tensor.numDim != ts.numDim
    then [err(e.location, "tensor dimensions do not match: " ++
           toString(tensor.numDim) ++ "d and " ++ toString(ts.numDim) ++ "d")]
    else [];

  tensor.errors <-
    if length(tensor.data) != tensor.count
    then [err(e.location, "tensor data length " ++
            toString(length(tensor.data)) ++ " does not match count " ++
            toString(tensor.count))]
    else [];

  tensor.errors <-
    if length(tensor.dimSize) != tensor.numDim
    then [err(e.location, "tensor dimSize length " ++
            toString(length(tensor.dimSize)) ++ " does not match numDim " ++
            toString(tensor.numDim))]
    else [];
  {-
  tensor.errors <-
    if listEq(e.dimSize, tail(ts.dimSize), \x::Integer y::Integer -> x == y)
    then []
    else [err(e.location, "tensor dimSizes do not match: (" ++
           implode(", ", map(\n::Integer -> toString(n), e.dimSize)) ++
           ") and (" ++
           implode(", ", map(\n::Integer -> toString(n), tail(ts.dimSize))) ++
           ")")];
  -}
}

abstract production singletonTensor
tensor::Tensor ::= e::Expr
{
  tensor.numDim = e.numDim + 1;
  tensor.currentDimSize = e.currentDimSize;
  tensor.dimSize = e.currentDimSize :: e.dimSize;
  tensor.count = e.count;
  tensor.data = e.data;
  tensor.errors := e.errors;
}

aspect default production
e::Expr ::=
{
  e.numDim = 0;
  e.currentDimSize = 1;
  e.dimSize = [];
  e.count = 1;
  e.data = [e];
  e.interList = [];
}


-- e.g. ({ int *__dimsize_tmp9 = malloc(1*sizeof(int)); __dimsize_tmp9[0] = 3; __dimsize_tmp9; })
function mkDimSizeExpr
Expr ::= dimSize::[Integer] l::Location
{
  local tmpName :: Name = name("__dimsize_tmp" ++ toString(genInt()), location=l);
  return
    stmtExpr(
      foldStmt([
        declStmt(
          variableDecls(
            [],
            nilAttribute(),
            typeModifierTypeExpr(
              directTypeExpr(builtinType(nilQualifier(), signedType(intType()))),
              pointerTypeExpr(nilQualifier(), baseTypeExpr())
            ),
            foldDeclarator([
              declarator(
                tmpName, baseTypeExpr(), nilAttribute(),
                justInitializer(
                  exprInitializer(
                    directCallExpr(
                      name("malloc", location = l),
                      foldExpr([
                        binaryOpExpr(
                          mkIntConst(length(dimSize), l),
                          numOp(mulOp(location=l), location=l),
                          unaryExprOrTypeTraitExpr(
                            sizeofOp(location=l),
                            typeNameExpr(
                              typeName(
                                directTypeExpr(
                                  builtinType(nilQualifier(), signedType(intType()))
                                ),
                                baseTypeExpr()
                              )
                            ),
                            location=l
                          ),
                          location=l
                        )
                      ]),
                      location=l
                    )
                  )
                )
              )
            ])
          )
        )
      ] ++ mkDimSizeAssign(dimSize, tmpName, 0, l)),
      declRefExpr(tmpName, location=l),
      location=l
    );
}

function mkDimSizeAssign
[Stmt] ::= dimSize::[Integer] tmpName::Name count::Integer l::Location
{
  return
    if null(dimSize)
    then []
    else
      cons(
        exprStmt(
          binaryOpExpr(
            arraySubscriptExpr(
              declRefExpr(tmpName, location=l),
              mkIntConst(count, l),
              location=l
            ),
            assignOp(eqOp(location=l), location=l),
            mkIntConst(head(dimSize), l),
            location=l
          )
        ),
        mkDimSizeAssign(tail(dimSize), tmpName, count+1, l)
      );
}

function mkDataExpr
Expr ::= data::[Expr] l::Location
{
  local tmpName :: Name = name("__data_tmp" ++ toString(genInt()), location=l);
  return
    stmtExpr(
      foldStmt([
        declStmt(
          variableDecls(
            [],
            nilAttribute(),
            typeModifierTypeExpr(
              directTypeExpr(builtinType(nilQualifier(), realType(floatType()))),
              pointerTypeExpr(nilQualifier(), baseTypeExpr())
            ),
            foldDeclarator([
              declarator(
                tmpName, baseTypeExpr(), nilAttribute(),
                justInitializer(
                  exprInitializer(
                    directCallExpr(
                      name("malloc", location = l),
                      foldExpr([
                        binaryOpExpr(
                          mkIntConst(length(data), l),
                          numOp(mulOp(location=l), location=l),
                          unaryExprOrTypeTraitExpr(
                            sizeofOp(location=l),
                            typeNameExpr(
                              typeName(
                                directTypeExpr(
                                  builtinType(nilQualifier(), realType(floatType()))
                                ),
                                baseTypeExpr()
                              )
                            ),
                            location=l
                          ),
                          location=l
                        )
                      ]),
                      location=l
                    )
                  )
                )
              )
            ])
          )
        )
      ] ++ mkDataAssign(data, tmpName, 0, l)),
      declRefExpr(tmpName, location=l),
      location=l
    );
}

function mkDataAssign
[Stmt] ::= data::[Expr] tmpName::Name count::Integer l::Location
{
  return
    if null(data)
    then []
    else
      cons(
        exprStmt(
          binaryOpExpr(
            arraySubscriptExpr(
              declRefExpr(tmpName, location=l),
              mkIntConst(count, l),
              location=l
            ),
            assignOp(eqOp(location=l), location=l),
            head(data),
            location=l
          )
        ),
        mkDataAssign(tail(data), tmpName, count+1, l)
      );
}


{-
-- e.g.
-- ({ int __dimsize_tmp9[] = {3, 4};
--    int *__dimsize_tmp10 = malloc(2*sizeof(int));
--    memcpy(__dimsize_tmp10, __dimsize_tmp9, 2*sizeof(int));
-- })
function mkDimSizeExpr
Expr ::= dimSize::[Integer] l::Location
{
  local tmpName1 :: Name = name("__dimsize_tmp" ++ toString(genInt()), location=l);
  local tmpName2 :: Name = name("__dimsize_tmp" ++ toString(genInt()), location=l);

  -- e.g. int __dimsize_tmp9[] = {3, 4};
  local tmpDecl1 :: Stmt =
    declStmt(
      variableDecls(
        [],
        nilAttribute(),
        typeModifierTypeExpr(
          directTypeExpr(builtinType(nilQualifier(), signedType(intType()))),
          arrayTypeExprWithoutExpr(baseTypeExpr(), nilQualifier(), normalArraySize())
        ),
        foldDeclarator([
          declarator(
            tmpName1, baseTypeExpr(), nilAttribute(),
            justInitializer(
              objectInitializer(
                foldInit(
                  map(init,
                    map(exprInitializer,
                      map(\n::Integer -> mkIntConst(n, l), dimSize)
                    )
                  )
                )
              )
            )
          )
        ])
      )
    );

  -- e.g. 2*sizeof(int)
	local size :: Expr =
		binaryOpExpr(
			mkIntConst(length(dimSize), l),
			numOp(mulOp(location=l), location=l),
			unaryExprOrTypeTraitExpr(
				sizeofOp(location=l),
				typeNameExpr(
					typeName(
						directTypeExpr(builtinType(nilQualifier(), signedType(intType()))),
						baseTypeExpr()
					)
				),
				location=l
			),
			location=l
		);

  -- e.g. malloc(2*sizeof(int))
  local malloc :: Expr =
    directCallExpr(
      name("malloc", location = l),
      foldExpr([size]),
      location=l
    );

  -- e.g. int *__dimsize_tmp10 = malloc(2*sizeof(int));
  local tmpDecl2 :: Stmt =
    declStmt(
      variableDecls(
        [],
        nilAttribute(),
        typeModifierTypeExpr(
          directTypeExpr(builtinType(nilQualifier(), signedType(intType()))),
          pointerTypeExpr(nilQualifier(), baseTypeExpr())
        ),
        foldDeclarator([
          declarator(tmpName2, baseTypeExpr(), nilAttribute(), justInitializer(exprInitializer(malloc)))
        ])
      )
    );

  -- note: need to #include <string.h>
  -- e.g. memcpy(__dimsize_tmp10, __dimsize_tmp9, 2*sizeof(int));
  local memcpy :: Expr =
    directCallExpr(
      name("memcpy", location = l),
      foldExpr([
        declRefExpr(tmpName2, location=l),
        declRefExpr(tmpName1, location=l),
        size
      ]),
      location=l
    );

  return
    stmtExpr(
      foldStmt([
        tmpDecl2,
        tmpDecl1
      ]),
      memcpy,
      location=l
    );
}

-- e.g.
-- ({ float __data_tmp11[] = {1, 2, 3, 4, 5, 6};
--    float *__data_tmp12 = malloc(6*sizeof(int));
--    memcpy(__dimsize_tmp12, __dimsize_tmp11, 6*sizeof(float));
-- })
function mkDataExpr
Expr ::= data::[Expr] l::Location
{
  local tmpName1 :: Name = name("__data_tmp" ++ toString(genInt()), location=l);
  local tmpName2 :: Name = name("__data_tmp" ++ toString(genInt()), location=l);

  -- e.g. float __dimsize_tmp11[] = {1, 2, 3, 4, 5, 6};
  local tmpDecl1 :: Stmt =
    declStmt(
      variableDecls(
        [],
        nilAttribute(),
        typeModifierTypeExpr(
          directTypeExpr(builtinType(nilQualifier(), signedType(intType()))),
          arrayTypeExprWithoutExpr(baseTypeExpr(), nilQualifier(), normalArraySize())
        ),
        foldDeclarator([
          declarator(
            tmpName1, baseTypeExpr(), nilAttribute(),
            justInitializer(
              objectInitializer(
                foldInit(map(init, map(exprInitializer, data)))
              )
            )
          )
        ])
      )
    );

  -- e.g. 6*sizeof(float)
	local size :: Expr =
		binaryOpExpr(
			mkIntConst(length(data), l),
			numOp(mulOp(location=l), location=l),
			unaryExprOrTypeTraitExpr(
				sizeofOp(location=l),
				typeNameExpr(
					typeName(
						directTypeExpr(builtinType(nilQualifier(), realType(floatType()))),
						baseTypeExpr()
					)
				),
				location=l
			),
			location=l
		);

  -- e.g. malloc(6*sizeof(float))
  local malloc :: Expr =
    directCallExpr(
      name("malloc", location = l),
      foldExpr([size]),
      location=l
    );

  -- e.g. float *__data_tmp12 = malloc(6*sizeof(float));
  local tmpDecl2 :: Stmt =
    declStmt(
      variableDecls(
        [],
        nilAttribute(),
        typeModifierTypeExpr(
          directTypeExpr(builtinType(nilQualifier(), realType(floatType()))),
          pointerTypeExpr(nilQualifier(), baseTypeExpr())
        ),
        foldDeclarator([
          declarator(tmpName2, baseTypeExpr(), nilAttribute(), justInitializer(exprInitializer(malloc)))
        ])
      )
    );

  -- note: need to #include <string.h>
  -- e.g. memcpy(__data_tmp12, __data_tmp11, 6*sizeof(float));
  local memcpy :: Expr =
    directCallExpr(
      name("memcpy", location = l),
      foldExpr([
        declRefExpr(tmpName2, location=l),
        declRefExpr(tmpName1, location=l),
        size
      ]),
      location=l
    );

  return
    stmtExpr(
      foldStmt([
        tmpDecl1,
        tmpDecl2
      ]),
      memcpy,
      location=l
    );
}
-}

function listEq
Boolean ::= l1::[a]  l2::[a]  eq::(Boolean ::= a a)
{
  return
    case null(l1), null(l2) of
      true,  true  -> true
    | true,  false -> false
    | false, true  -> false
    | false, false -> eq(head(l1), head(l2)) && listEq(tail(l1), tail(l2), eq)
    end;
}

abstract production intervalList
e::Expr ::= inter::Interval
{
  e.interList = inter.interList;

  local interList :: Expr = mkInterListExpr(inter.interList, generate_location(e.location, module_name));

  forwards to
    if null(inter.errors)
    then interList
    else errorExpr(inter.errors, location=e.location);
}

nonterminal Interval with interList, errors, env;

abstract production consInterval
inter::Interval ::= e::Expr is::Interval
{
  inter.interList = e.interList ++ is.interList;
  inter.errors := e.errors ++ is.errors;
}

abstract production singleInterval
inter::Interval ::= e::Expr
{
  inter.interList = e.interList;
  inter.errors := e.errors;
}

function mkInterListExpr
Expr ::= inter::[Expr] l::Location
{
  local tmpName :: Name = name("__inter_tmp" ++ toString(genInt()), location=l);
  return
    stmtExpr(
      foldStmt([
        declStmt(
          variableDecls(
            [],
            nilAttribute(),
            typeModifierTypeExpr(
              directTypeExpr(builtinType(nilQualifier(), realType(floatType()))), -- need to change this to be interval?
              pointerTypeExpr(nilQualifier(), baseTypeExpr())
            ),
            foldDeclarator([
              declarator(
                tmpName, baseTypeExpr(), nilAttribute(),
                justInitializer(
                  exprInitializer(
                    directCallExpr(
                      name("malloc", location = l),
                      foldExpr([
                        binaryOpExpr(
                          mkIntConst(length(inter), l),
                          numOp(mulOp(location=l), location=l),
                          unaryExprOrTypeTraitExpr(
                            sizeofOp(location=l),
                            typeNameExpr(
                              typeName(
                                directTypeExpr(
                                  builtinType(nilQualifier(), realType(floatType())) -- need to change this to be interval?
                                ),
                                baseTypeExpr()
                              )
                            ),
                            location=l
                          ),
                          location=l
                        )
                      ]),
                      location=l
                    )
                  )
                )
              )
            ])
          )
        )
      ] ++ mkInterListAssign(inter, tmpName, 0, l)),
      declRefExpr(tmpName, location=l),
      location=l
    );
}

function mkInterListAssign
[Stmt] ::= inter::[Expr] tmpName::Name count::Integer l::Location
{
  return
    if null(inter)
    then []
    else
      cons(
        exprStmt(
          binaryOpExpr(
            arraySubscriptExpr(
              declRefExpr(tmpName, location=l),
              mkIntConst(count, l),
              location=l
            ),
            assignOp(eqOp(location=l), location=l),
            head(inter),
            location=l
          )
        ),
        mkInterListAssign(tail(inter), tmpName, count+1, l)
      );
}

{-
function mkInterListExpr
Expr ::= data::[Expr] l::Location
{
  local tmpName1 :: Name = name("__interlist_tmp" ++ toString(genInt()), location=l);
  local tmpName2 :: Name = name("__interlist_tmp" ++ toString(genInt()), location=l);

  -- e.g. float __dimsize_tmp11[] = {1, 2, 3, 4, 5, 6};
  local tmpDecl1 :: Stmt =
    declStmt(
      variableDecls(
        [],
        nilAttribute(),
        typeModifierTypeExpr(
          directTypeExpr(builtinType(nilQualifier(), signedType(intType()))),
          arrayTypeExprWithoutExpr(baseTypeExpr(), nilQualifier(), normalArraySize())
        ),
        foldDeclarator([
          declarator(
            tmpName1, baseTypeExpr(), nilAttribute(),
            justInitializer(
              objectInitializer(
                foldInit(map(init, map(exprInitializer, data)))
              )
            )
          )
        ])
      )
    );

  -- e.g. 6*sizeof(float)
	local size :: Expr =
		binaryOpExpr(
			mkIntConst(length(data), l),
			numOp(mulOp(location=l), location=l),
			unaryExprOrTypeTraitExpr(
				sizeofOp(location=l),
				typeNameExpr(
					typeName(
						directTypeExpr(builtinType(nilQualifier(), realType(floatType()))),
{-
            //needs room for Interval aka two ints, technically float might be right?
-}
						baseTypeExpr()
					)
				),
				location=l
			),
			location=l
		);

  -- e.g. malloc(6*sizeof(float))
  local malloc :: Expr =
    directCallExpr(
      name("malloc", location = l),
      foldExpr([size]),
      location=l
    );

  -- e.g. float *__data_tmp12 = malloc(6*sizeof(float));
  local tmpDecl2 :: Stmt =
    declStmt(
      variableDecls(
        [],
        nilAttribute(),
        typeModifierTypeExpr(
          directTypeExpr(builtinType(nilQualifier(), realType(floatType()))),
          pointerTypeExpr(nilQualifier(), baseTypeExpr())
        ),
        foldDeclarator([
          declarator(tmpName2, baseTypeExpr(), nilAttribute(), justInitializer(exprInitializer(malloc)))
        ])
      )
    );

  -- note: need to #include <string.h>
  -- e.g. memcpy(__data_tmp12, __data_tmp11, 6*sizeof(float));
  local memcpy :: Expr =
    directCallExpr(
      name("memcpy", location = l),
      foldExpr([
        declRefExpr(tmpName2, location=l),
        declRefExpr(tmpName1, location=l),
        size
      ]),
      location=l
    );

  return
    stmtExpr(
      foldStmt([
        tmpDecl1,
        tmpDecl2
      ]),
      memcpy,
      location=l
    );
}
-}
