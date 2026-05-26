  $ ../../bin/tiger_lex.exe ../../programs/lexer/illegal-character.tig 2>&1
  ../../programs/lexer/illegal-character.tig:2.0:illegal character @
  VAR   0
  INT(123)   6
  EOF   10

  $ ../../bin/tiger_lex.exe ../../programs/lexer/unmatched-close-comment.tig 2>&1
  ../../programs/lexer/unmatched-close-comment.tig:2.0:unmatched close comment
  VAR   0
  INT(123)   7
  EOF   11

  $ ../../bin/tiger_lex.exe ../../programs/lexer/unclosed-comment.tig 2>&1
  ../../programs/lexer/unclosed-comment.tig:4.0:unclosed comment
  VAR   0
  EOF   32

  $ ../../bin/tiger_lex.exe ../../programs/lexer/unclosed-string.tig 2>&1
  ../../programs/lexer/unclosed-string.tig:2.0:unclosed string
  VAR   0
  STRING(hello)     4
  INT(123)   11
  EOF   15

  $ ../../bin/tiger_lex.exe ../../programs/lexer/bad-string-escape.tig 2>&1
  ../../programs/lexer/bad-string-escape.tig:1.5:illegal string escape
  ../../programs/lexer/bad-string-escape.tig:2.2:illegal ascii escape
  STRING(bad)     0
  STRING()     8
  EOF   15
