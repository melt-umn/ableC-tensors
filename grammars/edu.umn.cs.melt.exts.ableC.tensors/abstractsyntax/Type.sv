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
  --top.module = "edu:umn:cs:melt:exts:ableC:tensors:tensors"
  top.lpp = pp"interval";
  top.rpp = pp"";
  forwards to
  tagType(
    q,
    refIdTagType(structSEU(), "_tensors_s", s"edu:umn:cs:melt:exts:ableC:tensors:tensors"));
}
