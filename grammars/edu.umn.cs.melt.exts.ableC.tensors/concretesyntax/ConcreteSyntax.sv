grammar edu:umn:cs:melt:exts:ableC:tensors:concretesyntax;

imports edu:umn:cs:melt:ableC:concretesyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;

imports edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

imports silver:langutil only ast;

marking terminal ArrayEnvOpen_t '[.';
terminal ArrayEnvClose_t '.]';

marking terminal leftParen '(';
terminal rightParen ')';

marking terminal tensorPrint 'print';

marking terminal freeDynamic 'free_dynamic';

marking terminal free 'free';

concrete production free_dynamic
e::Expr ::= 'free' '(' Tensor ')'

