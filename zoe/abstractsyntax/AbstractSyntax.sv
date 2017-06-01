{- taken from edu.umn.cs.melt.exts.ableC.matlab and edited to add
   more functionality; changed Matrix type to Array type -}

--start of what was written from edu.umn.cs.melt.exts.ableC.matlab

grammar ableC-arrays:zoe:abstractsyntax;

imports edu:umn:cs:melt:ableC:abstractsyntax;
-- for mkIntConst, for mkOneByOneArray:
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;

abstract production int_to_array
e::Expr ::= value::Expr
{
  forwards to mkOneByOneArray (value, e.location);
}

abstract production concat_first
e::Expr ::= x::Expr y::Expr
{
  forwards to mkConFirst(x, y, e.location);
}

abstract production concat_second
e::Expr ::= x::Expr y::Expr
{
  forwards to mkConSecond(x, y, e.location);
}

abstract production cat
e::Expr ::= on_dimension::Expr x::Expr y::Expr
{
  forwards to mkCat (on_dimension, x, y, e.location);
}

function mkOneByOneArray
Expr ::= value::Expr l::Location
{
  return
    directCallExpr (
      name ("int_to_array", location=l),
      consExpr (value,
        nilExpr ()),
      location=l
    );
}

function mkConFirst
Expr ::= array_one::Expr array_two::Expr l::Location
{
  local dimension::Expr = mkIntConst(1,l);

  return
    directCallExpr (
      name ("cat_array", location=l),
      consExpr (dimension,
        consExpr (array_one,
          consExpr (array_two,
            nilExpr ()))),
      location=l
    );
}

function mkConSecond
Expr ::= array_one::Expr array_two::Expr l::Location
{
  local dimension::Expr = mkIntConst(2,l);

  return
    directCallExpr (
      name ("cat_array", location=l),
      consExpr (dimension,
        consExpr (array_one,
          consExpr (array_two,
            nilExpr ()))),
      location=l
    );
}

function mkCat
Expr ::= on_dimension::Expr array_one::Expr array_two::Expr l::Location
{
  return
    directCallExpr (
      name ("cat_array", location=l),
      consExpr (on_dimension,
        consExpr (array_one,
          consExpr (array_two,
            nilExpr ()))),
      location=l
    );
}

--end of what was written from edu.umn.cs.melt.exts.ableC.matlab
