{- taken from edu.umn.cs.melt.exts.ableC.matlab and edited to add
   more functionality; changed Matrix type to Array type -}


--start of what was written from edu.umn.cs.melt.exts.ableC.matlab

grammar edu:umn:cs:melt:exts:ableC:tensors:concretesyntax;

-- as cnc?
imports edu:umn:cs:melt:ableC:concretesyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;

imports edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

imports silver:langutil only ast;

marking terminal Cat_t 'cat' lexer classes {Ckeyword};

marking terminal ArrayEnvOpen_t '[[';
marking terminal ArrayEnvClose_t ']]';

concrete production singleton_element_array_c
e::PrimaryExpr_c ::= left :: ArrayEnvOpen_t
                     value :: AssignExpr_c
                     right :: ArrayEnvClose_t
{
  e.ast = int_to_array (value.ast, location = left.location);
}

concrete production con_first
e::PrimaryExpr_c ::= left :: ArrayEnvOpen_t x :: AssignExpr_c
                     ',' y :: AssignExpr_c right :: ArrayEnvClose_t
{
  e.ast = concat_first (x.ast, y.ast, location = left.location);
}

concrete production con_second
e::PrimaryExpr_c ::= left :: ArrayEnvOpen_t x :: AssignExpr_c
                     ';' y :: AssignExpr_c right :: ArrayEnvClose_t
{
  e.ast = concat_second (x.ast, y.ast, location = left.location);
}

concrete production cat_c
e::PostfixExpr_c ::= fn :: Cat_t '(' on_dimension :: AssignExpr_c ','
                                     x :: AssignExpr_c ','
                                     y :: AssignExpr_c ')'
{
  e.ast = cat (on_dimension.ast,
               x.ast,
               y.ast,
               location = fn.location);
}

--end of what was written from edu.umn.cs.melt.exts.ableC.matlab
