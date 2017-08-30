grammar edu:umn:cs:melt:exts:ableC:tensors:concretesyntax;

imports edu:umn:cs:melt:ableC:concretesyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;

imports edu:umn:cs:melt:exts:ableC:tensors:abstractsyntax;

imports silver:langutil:pp;
imports silver:langutil;

marking terminal IntervalEnvOpen_t '<(';
--terminal IntervalEnvClose_t '.>';
terminal Between '-,';
marking terminal IndexSign '<.>'; --currently here b/c ableC needs to be modified

marking terminal TensorEnvOpen_t '[[';
--terminal TensorEnvClose_t ']]';


marking terminal Tensor_multiply '**' lexer classes {Ckeyword};

marking terminal Dot_product '.*' lexer classes {Csymbol};
marking terminal Float_dot_product 'f.*' lexer classes {Ckeyword};

marking terminal Cross_product 'x*' lexer classes {Csymbol};

concrete productions top::AdditiveOp_c
| '.*'
  { top.ast = dot_product_a(top.leftExpr, top.rightExpr,
    location = top.location); }
| 'f.*'
  { top.ast = float_dot_product_a(top.leftExpr, top.rightExpr,
    location = top.location); }

concrete productions top::AddMulNoneOp_c
| 'x*'
  { top.ast = cross_product_a(top.leftExpr, top.rightExpr,
    location = top.location); }
| '**'
  { top.ast = tensor_multiply_a(top.leftExpr,top.rightExpr,
    location = top.location); }

-- tensor literal creation
concrete production tensor_literal_c
e::AssignExpr_c ::= '[[' tSeq :: TensorSeq_c ']' ']'
{
  e.ast = tensorLiteral(tSeq.ast, location=e.location);
}

nonterminal TensorSeq_c with location, ast<Tensor>;

concrete productions tSeq::TensorSeq_c
| e::AssignExpr_c
  {
    tSeq.ast = singletonTensor(e.ast);
  }
| e::AssignExpr_c ',' anotherTSeq::TensorSeq_c
  {
    tSeq.ast = consTensor(e.ast, anotherTSeq.ast);
  }


-- interval list creation
concrete production interval_list_c
e::PostfixExpr_c ::= '<.>' tensor::PostfixExpr_c '<' '(' iSeq :: IntervalSeq_c ')' '>'
{
  e.ast = access_a(tensor.ast,intervalList(iSeq.ast, location=e.location),location=e.location);
}

nonterminal IntervalSeq_c with location, ast<Interval>;

concrete productions iSeq::IntervalSeq_c
| e::AssignExpr_c
  {
    iSeq.ast = singleInterval(e.ast);
  }
| e::AssignExpr_c ',' anotherISeq::IntervalSeq_c
  {
    iSeq.ast = consInterval(e.ast, anotherISeq.ast);
  }

concrete productions top::PrimaryExpr_c
| '<(' oneDim :: AssignExpr_c ')' '>'
  { top.ast = create_interval_double_bound_a(oneDim.ast, oneDim.ast,
    location = top.location); }
| '<(' leftDim :: AssignExpr_c ',' '-,' rightDim :: AssignExpr_c ')' '>'
  { top.ast = create_interval_double_bound_a(leftDim.ast, rightDim.ast,
    location = top.location); }
| '<(' leftDim :: AssignExpr_c ',' '-,' '*' ')' '>'
  { top.ast = create_interval_left_bound_a(leftDim.ast,
    location = top.location); }
| '<(' '*' ')' '>'
  { top.ast = create_interval_no_bound_a(location = top.location); }

--rest of these are technically useless but will add for consistency
| '<(' '*' ',' '-,' rightDim :: AssignExpr_c ')' '>'
  { top.ast = create_interval_right_bound_a(rightDim.ast, location = top.location); }
| '<(' '*' ',' '-,' '*' ')' '>'
  { top.ast = create_interval_no_bound_a(location = top.location); }
