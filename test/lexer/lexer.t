  $ ../../bin/tiger_lex.exe ../../programs/lexer/scaffold.tig
  VAR   0
  COMMA   3
  INT(123)   4
  EOF   8

  $ ../../bin/tiger_lex.exe ../../programs/lexer/comments.tig
  VAR   0
  VAR   28
  EOF   32

  $ ../../bin/tiger_lex.exe ../../programs/lexer/tokens.tig
  TYPE   0
  VAR   5
  FUNCTION   9
  BREAK   18
  OF   24
  END   27
  IN   31
  NIL   34
  LET   38
  DO   42
  TO   45
  FOR   48
  WHILE   52
  ELSE   58
  THEN   63
  IF   68
  ARRAY   71
  ASSIGN   77
  OR   80
  AND   82
  GE   84
  GT   87
  LE   89
  LT   92
  NEQ   94
  EQ   97
  DIVIDE   99
  TIMES   101
  MINUS   103
  PLUS   105
  DOT   107
  RBRACE   109
  LBRACE   111
  RBRACK   113
  LBRACK   115
  RPAREN   117
  LPAREN   119
  SEMICOLON   121
  COLON   123
  COMMA   125
  ID(abc)     127
  ID(abc123)     131
  ID(abc_123)     138
  INT(0)   146
  INT(123)   148
  EOF   152

  $ ../../bin/tiger_lex.exe ../../programs/lexer/strings.tig
  STRING(hello)     0
  STRING(")     8
  STRING(\)     13
  STRING(A)     18
  STRING(ab)     25
  EOF   35
