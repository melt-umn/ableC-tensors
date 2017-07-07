grammar edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

abstract production tensorTypeExpr
top::BaseTypeExpr ::= q::Qualifiers
{
  propagate substituted;
  forwards to directTypeExpr(tensorType(q));
}

abstract production tensorType
top::Type ::= q::Qualifiers
{
  top.module = "edu:umn:cs:melt:exts:ableC:tensors:tensors";
}
