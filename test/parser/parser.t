Chapter 3 parser.

Step 1: literal expressions and the empty sequence expression.

  $ ../../bin/tiger_parse.exe ../../programs/parser/nil.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/int.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/string.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/parser/unit.tig
  parse ok

Empty input is not a Tiger expression.

  $ ../../bin/tiger_parse.exe ../../programs/parser/empty.tig
  ../../programs/parser/empty.tig:2.0:syntax error
  [2]

Real Tiger programs still fail until the rest of the grammar is implemented.

  $ ../../bin/tiger_parse.exe ../../programs/testcases/test1.tig
  ../../programs/testcases/test1.tig:2.0:syntax error
  [2]
