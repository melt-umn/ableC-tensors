grammar zoe:artifact;

import edu:umn:cs:melt:ableC:concretesyntax as cst;
import edu:umn:cs:melt:ableC:drivers:compile;

parser extendedParser :: cst:Root {
  edu:umn:cs:melt:ableC:concretesyntax;
  zoe;
}

function main
IOVal<Integer> ::= args::[String] io_in::IO
{
  return driver(args, io_in, extendedParser);
}
