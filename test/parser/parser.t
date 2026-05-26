  $ ../../bin/tiger_parse.exe ../../programs/parser/nil.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/int.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/string.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/unit.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/sequence.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/nested-sequence.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/trailing-semicolon.tig
  ../../programs/parser/trailing-semicolon.tig:1.3:syntax error
  [2]

  $ ../../bin/tiger_parse.exe ../../programs/parser/lvalue-id.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/lvalue-field.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/lvalue-subscript.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/lvalue-nested.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/sequence-lvalues.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/sequence-subscript-sequence.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/negation.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/sequence-negation.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/negation-missing-expression.tig
  ../../programs/parser/negation-missing-expression.tig:2.0:syntax error
  [2]

  $ ../../bin/tiger_parse.exe ../../programs/parser/arithmetic.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/comparison.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/string-comparisons.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/logical.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/operator-mixed.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/parenthesized-comparison.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/nonassoc-comparison.tig
  ../../programs/parser/nonassoc-comparison.tig:1.6:syntax error
  [2]

  $ ../../bin/tiger_parse.exe ../../programs/parser/call-empty.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/call-args.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/call-nested.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/sequence-calls.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/call-trailing-comma.tig
  ../../programs/parser/call-trailing-comma.tig:1.13:syntax error
  [2]

  $ ../../bin/tiger_parse.exe ../../programs/parser/record-empty.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/record-fields.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/record-mixed.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/record-trailing-comma.tig
  ../../programs/parser/record-trailing-comma.tig:1.13:syntax error
  [2]

  $ ../../bin/tiger_parse.exe ../../programs/parser/array-create.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/array-create-mixed.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/array-missing-of.tig
  ../../programs/parser/array-missing-of.tig:1.13:syntax error
  [2]

  $ ../../bin/tiger_parse.exe ../../programs/parser/assign-simple.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/assign-lvalue.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/assign-logical.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/assign-non-lvalue.tig
  ../../programs/parser/assign-non-lvalue.tig:1.2:syntax error
  [2]

  $ ../../bin/tiger_parse.exe ../../programs/parser/assign-chained.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/if-then.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/if-then-else.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/if-dangling-else.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/if-branch-operators.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/if-missing-then.tig
  ../../programs/parser/if-missing-then.tig:1.9:syntax error
  [2]

  $ ../../bin/tiger_parse.exe ../../programs/parser/while.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/while-sequence.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/while-missing-do.tig
  ../../programs/parser/while-missing-do.tig:1.12:syntax error
  [2]

  $ ../../bin/tiger_parse.exe ../../programs/parser/empty.tig
  ../../programs/parser/empty.tig:2.0:syntax error
  [2]

  $ ../../bin/tiger_parse.exe ../../programs/testcases/test1.tig
  ../../programs/testcases/test1.tig:2.0:syntax error
  [2]
