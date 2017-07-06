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
  forwards to
  tagType(
    q,
    refIdTagType(structSEU(), "_interval_s", s"edu:umn:cs:melt:exts:ableC:interval:interval"));
}
