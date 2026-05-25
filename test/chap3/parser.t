Chapter 3 parser scaffold.

The initial parser skeleton mirrors the SML chapter 3 assignment skeleton: it
builds and accepts the empty placeholder expression, but real Tiger programs
still fail until the grammar is implemented.

  $ ../../bin/tiger_parse.exe ../../programs/parser/empty.tig
  parse ok

  $ ../../bin/tiger_parse.exe ../../programs/test1.tig
  ../../programs/test1.tig:2.0:syntax error
  [2]
