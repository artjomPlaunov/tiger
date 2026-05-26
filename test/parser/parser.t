Chapter 3 parser.

Literal expressions and the empty sequence expression.

  $ ../../bin/tiger_parse.exe ../../programs/parser/nil.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/int.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/string.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/unit.tig
  parse ok

Sequences of two or more expressions.

  $ ../../bin/tiger_parse.exe ../../programs/parser/sequence.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/nested-sequence.tig
  parse ok

Semicolons separate expressions; they are not terminators. Use `()` when the
final expression should produce no value.

  $ ../../bin/tiger_parse.exe ../../programs/parser/trailing-semicolon.tig
  ../../programs/parser/trailing-semicolon.tig:1.3:syntax error
  [2]

L-values are expressions. Dot syntax selects a record field; bracket syntax
subscripts an l-value. Typechecking later decides whether the l-value actually
has that field or supports indexing.

  $ ../../bin/tiger_parse.exe ../../programs/parser/lvalue-id.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/lvalue-field.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/lvalue-subscript.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/lvalue-nested.tig
  parse ok

L-values compose with existing expression forms.

  $ ../../bin/tiger_parse.exe ../../programs/parser/sequence-lvalues.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/sequence-subscript-sequence.tig
  parse ok

Negation prefixes an expression. Whether the expression has integer type is
checked later.

  $ ../../bin/tiger_parse.exe ../../programs/parser/negation.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/sequence-negation.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/negation-missing-expression.tig
  ../../programs/parser/negation-missing-expression.tig:2.0:syntax error
  [2]

Binary operators parse with precedence from high to low: unary minus, `*` and
`/`, `+` and `-`, comparisons, then `&` and `|`.

  $ ../../bin/tiger_parse.exe ../../programs/parser/arithmetic.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/comparison.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/logical.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/operator-mixed.tig
  parse ok

Comparisons do not associate. Parenthesize a nested comparison if that is what
the source intends.

  $ ../../bin/tiger_parse.exe ../../programs/parser/parenthesized-comparison.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/nonassoc-comparison.tig
  ../../programs/parser/nonassoc-comparison.tig:1.6:syntax error
  [2]

Empty input is not a Tiger expression.

  $ ../../bin/tiger_parse.exe ../../programs/parser/empty.tig
  ../../programs/parser/empty.tig:2.0:syntax error
  [2]

Real Tiger programs still fail until the rest of the grammar is implemented.

  $ ../../bin/tiger_parse.exe ../../programs/testcases/test1.tig
  ../../programs/testcases/test1.tig:2.0:syntax error
  [2]
