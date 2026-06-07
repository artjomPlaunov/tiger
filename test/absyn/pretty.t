  $ ../../bin/tiger_ast.exe ../../programs/parser/arithmetic.tig
  ╭─ Tiger AST
  ╰─ OpExpr MinusOp
     ├─ OpExpr PlusOp
     │  ├─ IntExpr 1
     │  ╰─ OpExpr TimesOp
     │     ├─ IntExpr 2
     │     ╰─ IntExpr 3
     ╰─ OpExpr DivideOp
        ├─ IntExpr 4
        ╰─ IntExpr 2

  $ ../../bin/tiger_ast.exe ../../programs/parser/assign-lvalue.tig
  ╭─ Tiger AST
  ╰─ AssignExpr
     ├─ var
     │  ╰─ FieldVar x
     │     ╰─ SubscriptVar
     │        ├─ var
     │        │  ╰─ SimpleVar rows
     │        ╰─ index
     │           ╰─ IntExpr 0
     ╰─ expr
        ╰─ VarExpr
           ╰─ FieldVar y
              ╰─ SimpleVar other

  $ ../../bin/tiger_ast.exe ../../programs/parser/for-mixed.tig
  ╭─ Tiger AST
  ╰─ ForExpr i escape=true
     ├─ lo
     │  ╰─ IntExpr 0
     ├─ hi
     │  ╰─ OpExpr MinusOp
     │     ├─ VarExpr
     │     │  ╰─ SimpleVar n
     │     ╰─ IntExpr 1
     ╰─ body
        ╰─ IfExpr
           ├─ test
           │  ╰─ VarExpr
           │     ╰─ SimpleVar ready
           ├─ then
           │  ╰─ CallExpr print
           │     ╰─ CallExpr chr
           │        ╰─ VarExpr
           │           ╰─ SimpleVar i
           ╰─ else
              ╰─ SeqExpr

  $ ../../bin/tiger_ast.exe ../../programs/parser/let-type-record-fields.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ TypeDec
     │     ╰─ Type point
     │        ╰─ RecordTy
     │           ├─ Field x : int escape=true
     │           ╰─ Field y : int escape=true
     ╰─ body
        ╰─ RecordExpr point
           ├─ Field x
           │  ╰─ IntExpr 1
           ╰─ Field y
              ╰─ IntExpr 2

  $ ../../bin/tiger_ast.exe ../../programs/parser/let-decs-mixed.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ╰─ Type count
     │  │     ╰─ NameTy int
     │  ├─ VarDec start escape=true
     │  │  ├─ type: count
     │  │  ╰─ init
     │  │     ╰─ IntExpr 0
     │  ╰─ FunctionDec
     │     ╰─ Function inc
     │        ├─ params
     │        │  ╰─ Field x : count escape=true
     │        ├─ result: count
     │        ╰─ body
     │           ╰─ OpExpr PlusOp
     │              ├─ VarExpr
     │              │  ╰─ SimpleVar x
     │              ╰─ IntExpr 1
     ╰─ body
        ╰─ CallExpr inc
           ╰─ VarExpr
              ╰─ SimpleVar start

Print the imported Tiger testcase corpus as ASTs too. test49.tig is
syntactically invalid, so it prints the parser error.

  $ ../../bin/tiger_ast.exe ../../programs/testcases/merge.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ╰─ Type any
     │  │     ╰─ RecordTy
     │  │        ╰─ Field any : int escape=true
     │  ├─ VarDec buffer escape=true
     │  │  ├─ type: none
     │  │  ╰─ init
     │  │     ╰─ CallExpr getchar
     │  ├─ FunctionDec
     │  │  ╰─ Function readint
     │  │     ├─ params
     │  │     │  ╰─ Field any : any escape=true
     │  │     ├─ result: int
     │  │     ╰─ body
     │  │        ╰─ LetExpr
     │  │           ├─ decs
     │  │           │  ├─ VarDec i escape=true
     │  │           │  │  ├─ type: none
     │  │           │  │  ╰─ init
     │  │           │  │     ╰─ IntExpr 0
     │  │           │  ╰─ FunctionDec
     │  │           │     ├─ Function isdigit
     │  │           │     │  ├─ params
     │  │           │     │  │  ╰─ Field s : string escape=true
     │  │           │     │  ├─ result: int
     │  │           │     │  ╰─ body
     │  │           │     │     ╰─ IfExpr
     │  │           │     │        ├─ test
     │  │           │     │        │  ╰─ OpExpr GeOp
     │  │           │     │        │     ├─ CallExpr ord
     │  │           │     │        │     │  ╰─ VarExpr
     │  │           │     │        │     │     ╰─ SimpleVar buffer
     │  │           │     │        │     ╰─ CallExpr ord
     │  │           │     │        │        ╰─ StringExpr "0"
     │  │           │     │        ├─ then
     │  │           │     │        │  ╰─ OpExpr LeOp
     │  │           │     │        │     ├─ CallExpr ord
     │  │           │     │        │     │  ╰─ VarExpr
     │  │           │     │        │     │     ╰─ SimpleVar buffer
     │  │           │     │        │     ╰─ CallExpr ord
     │  │           │     │        │        ╰─ StringExpr "9"
     │  │           │     │        ╰─ else
     │  │           │     │           ╰─ IntExpr 0
     │  │           │     ╰─ Function skipto
     │  │           │        ├─ params
     │  │           │        ├─ result: none
     │  │           │        ╰─ body
     │  │           │           ╰─ WhileExpr
     │  │           │              ├─ test
     │  │           │              │  ╰─ IfExpr
     │  │           │              │     ├─ test
     │  │           │              │     │  ╰─ OpExpr EqOp
     │  │           │              │     │     ├─ VarExpr
     │  │           │              │     │     │  ╰─ SimpleVar buffer
     │  │           │              │     │     ╰─ StringExpr " "
     │  │           │              │     ├─ then
     │  │           │              │     │  ╰─ IntExpr 1
     │  │           │              │     ╰─ else
     │  │           │              │        ╰─ OpExpr EqOp
     │  │           │              │           ├─ VarExpr
     │  │           │              │           │  ╰─ SimpleVar buffer
     │  │           │              │           ╰─ StringExpr "\n"
     │  │           │              ╰─ body
     │  │           │                 ╰─ AssignExpr
     │  │           │                    ├─ var
     │  │           │                    │  ╰─ SimpleVar buffer
     │  │           │                    ╰─ expr
     │  │           │                       ╰─ CallExpr getchar
     │  │           ╰─ body
     │  │              ╰─ SeqExpr
     │  │                 ├─ CallExpr skipto
     │  │                 ├─ AssignExpr
     │  │                 │  ├─ var
     │  │                 │  │  ╰─ FieldVar any
     │  │                 │  │     ╰─ SimpleVar any
     │  │                 │  ╰─ expr
     │  │                 │     ╰─ CallExpr isdigit
     │  │                 │        ╰─ VarExpr
     │  │                 │           ╰─ SimpleVar buffer
     │  │                 ├─ WhileExpr
     │  │                 │  ├─ test
     │  │                 │  │  ╰─ CallExpr isdigit
     │  │                 │  │     ╰─ VarExpr
     │  │                 │  │        ╰─ SimpleVar buffer
     │  │                 │  ╰─ body
     │  │                 │     ╰─ SeqExpr
     │  │                 │        ├─ AssignExpr
     │  │                 │        │  ├─ var
     │  │                 │        │  │  ╰─ SimpleVar i
     │  │                 │        │  ╰─ expr
     │  │                 │        │     ╰─ OpExpr MinusOp
     │  │                 │        │        ├─ OpExpr PlusOp
     │  │                 │        │        │  ├─ OpExpr TimesOp
     │  │                 │        │        │  │  ├─ VarExpr
     │  │                 │        │        │  │  │  ╰─ SimpleVar i
     │  │                 │        │        │  │  ╰─ IntExpr 10
     │  │                 │        │        │  ╰─ CallExpr ord
     │  │                 │        │        │     ╰─ VarExpr
     │  │                 │        │        │        ╰─ SimpleVar buffer
     │  │                 │        │        ╰─ CallExpr ord
     │  │                 │        │           ╰─ StringExpr "0"
     │  │                 │        ╰─ AssignExpr
     │  │                 │           ├─ var
     │  │                 │           │  ╰─ SimpleVar buffer
     │  │                 │           ╰─ expr
     │  │                 │              ╰─ CallExpr getchar
     │  │                 ╰─ VarExpr
     │  │                    ╰─ SimpleVar i
     │  ├─ TypeDec
     │  │  ╰─ Type list
     │  │     ╰─ RecordTy
     │  │        ├─ Field first : int escape=true
     │  │        ╰─ Field rest : list escape=true
     │  ├─ FunctionDec
     │  │  ├─ Function readlist
     │  │  │  ├─ params
     │  │  │  ├─ result: list
     │  │  │  ╰─ body
     │  │  │     ╰─ LetExpr
     │  │  │        ├─ decs
     │  │  │        │  ├─ VarDec any escape=true
     │  │  │        │  │  ├─ type: none
     │  │  │        │  │  ╰─ init
     │  │  │        │  │     ╰─ RecordExpr any
     │  │  │        │  │        ╰─ Field any
     │  │  │        │  │           ╰─ IntExpr 0
     │  │  │        │  ╰─ VarDec i escape=true
     │  │  │        │     ├─ type: none
     │  │  │        │     ╰─ init
     │  │  │        │        ╰─ CallExpr readint
     │  │  │        │           ╰─ VarExpr
     │  │  │        │              ╰─ SimpleVar any
     │  │  │        ╰─ body
     │  │  │           ╰─ IfExpr
     │  │  │              ├─ test
     │  │  │              │  ╰─ VarExpr
     │  │  │              │     ╰─ FieldVar any
     │  │  │              │        ╰─ SimpleVar any
     │  │  │              ├─ then
     │  │  │              │  ╰─ RecordExpr list
     │  │  │              │     ├─ Field first
     │  │  │              │     │  ╰─ VarExpr
     │  │  │              │     │     ╰─ SimpleVar i
     │  │  │              │     ╰─ Field rest
     │  │  │              │        ╰─ CallExpr readlist
     │  │  │              ╰─ else
     │  │  │                 ╰─ NilExpr
     │  │  ├─ Function merge
     │  │  │  ├─ params
     │  │  │  │  ├─ Field a : list escape=true
     │  │  │  │  ╰─ Field b : list escape=true
     │  │  │  ├─ result: list
     │  │  │  ╰─ body
     │  │  │     ╰─ IfExpr
     │  │  │        ├─ test
     │  │  │        │  ╰─ OpExpr EqOp
     │  │  │        │     ├─ VarExpr
     │  │  │        │     │  ╰─ SimpleVar a
     │  │  │        │     ╰─ NilExpr
     │  │  │        ├─ then
     │  │  │        │  ╰─ VarExpr
     │  │  │        │     ╰─ SimpleVar b
     │  │  │        ╰─ else
     │  │  │           ╰─ IfExpr
     │  │  │              ├─ test
     │  │  │              │  ╰─ OpExpr EqOp
     │  │  │              │     ├─ VarExpr
     │  │  │              │     │  ╰─ SimpleVar b
     │  │  │              │     ╰─ NilExpr
     │  │  │              ├─ then
     │  │  │              │  ╰─ VarExpr
     │  │  │              │     ╰─ SimpleVar a
     │  │  │              ╰─ else
     │  │  │                 ╰─ IfExpr
     │  │  │                    ├─ test
     │  │  │                    │  ╰─ OpExpr LtOp
     │  │  │                    │     ├─ VarExpr
     │  │  │                    │     │  ╰─ FieldVar first
     │  │  │                    │     │     ╰─ SimpleVar a
     │  │  │                    │     ╰─ VarExpr
     │  │  │                    │        ╰─ FieldVar first
     │  │  │                    │           ╰─ SimpleVar b
     │  │  │                    ├─ then
     │  │  │                    │  ╰─ RecordExpr list
     │  │  │                    │     ├─ Field first
     │  │  │                    │     │  ╰─ VarExpr
     │  │  │                    │     │     ╰─ FieldVar first
     │  │  │                    │     │        ╰─ SimpleVar a
     │  │  │                    │     ╰─ Field rest
     │  │  │                    │        ╰─ CallExpr merge
     │  │  │                    │           ├─ VarExpr
     │  │  │                    │           │  ╰─ FieldVar rest
     │  │  │                    │           │     ╰─ SimpleVar a
     │  │  │                    │           ╰─ VarExpr
     │  │  │                    │              ╰─ SimpleVar b
     │  │  │                    ╰─ else
     │  │  │                       ╰─ RecordExpr list
     │  │  │                          ├─ Field first
     │  │  │                          │  ╰─ VarExpr
     │  │  │                          │     ╰─ FieldVar first
     │  │  │                          │        ╰─ SimpleVar b
     │  │  │                          ╰─ Field rest
     │  │  │                             ╰─ CallExpr merge
     │  │  │                                ├─ VarExpr
     │  │  │                                │  ╰─ SimpleVar a
     │  │  │                                ╰─ VarExpr
     │  │  │                                   ╰─ FieldVar rest
     │  │  │                                      ╰─ SimpleVar b
     │  │  ├─ Function printint
     │  │  │  ├─ params
     │  │  │  │  ╰─ Field i : int escape=true
     │  │  │  ├─ result: none
     │  │  │  ╰─ body
     │  │  │     ╰─ LetExpr
     │  │  │        ├─ decs
     │  │  │        │  ╰─ FunctionDec
     │  │  │        │     ╰─ Function f
     │  │  │        │        ├─ params
     │  │  │        │        │  ╰─ Field i : int escape=true
     │  │  │        │        ├─ result: none
     │  │  │        │        ╰─ body
     │  │  │        │           ╰─ IfExpr
     │  │  │        │              ├─ test
     │  │  │        │              │  ╰─ OpExpr GtOp
     │  │  │        │              │     ├─ VarExpr
     │  │  │        │              │     │  ╰─ SimpleVar i
     │  │  │        │              │     ╰─ IntExpr 0
     │  │  │        │              ├─ then
     │  │  │        │              │  ╰─ SeqExpr
     │  │  │        │              │     ├─ CallExpr f
     │  │  │        │              │     │  ╰─ OpExpr DivideOp
     │  │  │        │              │     │     ├─ VarExpr
     │  │  │        │              │     │     │  ╰─ SimpleVar i
     │  │  │        │              │     │     ╰─ IntExpr 10
     │  │  │        │              │     ╰─ CallExpr print
     │  │  │        │              │        ╰─ CallExpr chr
     │  │  │        │              │           ╰─ OpExpr PlusOp
     │  │  │        │              │              ├─ OpExpr MinusOp
     │  │  │        │              │              │  ├─ VarExpr
     │  │  │        │              │              │  │  ╰─ SimpleVar i
     │  │  │        │              │              │  ╰─ OpExpr TimesOp
     │  │  │        │              │              │     ├─ OpExpr DivideOp
     │  │  │        │              │              │     │  ├─ VarExpr
     │  │  │        │              │              │     │  │  ╰─ SimpleVar i
     │  │  │        │              │              │     │  ╰─ IntExpr 10
     │  │  │        │              │              │     ╰─ IntExpr 10
     │  │  │        │              │              ╰─ CallExpr ord
     │  │  │        │              │                 ╰─ StringExpr "0"
     │  │  │        │              ╰─ else: none
     │  │  │        ╰─ body
     │  │  │           ╰─ IfExpr
     │  │  │              ├─ test
     │  │  │              │  ╰─ OpExpr LtOp
     │  │  │              │     ├─ VarExpr
     │  │  │              │     │  ╰─ SimpleVar i
     │  │  │              │     ╰─ IntExpr 0
     │  │  │              ├─ then
     │  │  │              │  ╰─ SeqExpr
     │  │  │              │     ├─ CallExpr print
     │  │  │              │     │  ╰─ StringExpr "-"
     │  │  │              │     ╰─ CallExpr f
     │  │  │              │        ╰─ OpExpr MinusOp
     │  │  │              │           ├─ IntExpr 0
     │  │  │              │           ╰─ VarExpr
     │  │  │              │              ╰─ SimpleVar i
     │  │  │              ╰─ else
     │  │  │                 ╰─ IfExpr
     │  │  │                    ├─ test
     │  │  │                    │  ╰─ OpExpr GtOp
     │  │  │                    │     ├─ VarExpr
     │  │  │                    │     │  ╰─ SimpleVar i
     │  │  │                    │     ╰─ IntExpr 0
     │  │  │                    ├─ then
     │  │  │                    │  ╰─ CallExpr f
     │  │  │                    │     ╰─ VarExpr
     │  │  │                    │        ╰─ SimpleVar i
     │  │  │                    ╰─ else
     │  │  │                       ╰─ CallExpr print
     │  │  │                          ╰─ StringExpr "0"
     │  │  ╰─ Function printlist
     │  │     ├─ params
     │  │     │  ╰─ Field l : list escape=true
     │  │     ├─ result: none
     │  │     ╰─ body
     │  │        ╰─ IfExpr
     │  │           ├─ test
     │  │           │  ╰─ OpExpr EqOp
     │  │           │     ├─ VarExpr
     │  │           │     │  ╰─ SimpleVar l
     │  │           │     ╰─ NilExpr
     │  │           ├─ then
     │  │           │  ╰─ CallExpr print
     │  │           │     ╰─ StringExpr "\n"
     │  │           ╰─ else
     │  │              ╰─ SeqExpr
     │  │                 ├─ CallExpr printint
     │  │                 │  ╰─ VarExpr
     │  │                 │     ╰─ FieldVar first
     │  │                 │        ╰─ SimpleVar l
     │  │                 ├─ CallExpr print
     │  │                 │  ╰─ StringExpr " "
     │  │                 ╰─ CallExpr printlist
     │  │                    ╰─ VarExpr
     │  │                       ╰─ FieldVar rest
     │  │                          ╰─ SimpleVar l
     │  ├─ VarDec list1 escape=true
     │  │  ├─ type: none
     │  │  ╰─ init
     │  │     ╰─ CallExpr readlist
     │  ╰─ VarDec list2 escape=true
     │     ├─ type: none
     │     ╰─ init
     │        ╰─ SeqExpr
     │           ├─ AssignExpr
     │           │  ├─ var
     │           │  │  ╰─ SimpleVar buffer
     │           │  ╰─ expr
     │           │     ╰─ CallExpr getchar
     │           ╰─ CallExpr readlist
     ╰─ body
        ╰─ CallExpr printlist
           ╰─ CallExpr merge
              ├─ VarExpr
              │  ╰─ SimpleVar list1
              ╰─ VarExpr
                 ╰─ SimpleVar list2
  $ ../../bin/tiger_ast.exe ../../programs/testcases/queens.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ VarDec N escape=true
     │  │  ├─ type: none
     │  │  ╰─ init
     │  │     ╰─ IntExpr 8
     │  ├─ TypeDec
     │  │  ╰─ Type intArray
     │  │     ╰─ ArrayTy int
     │  ├─ VarDec row escape=true
     │  │  ├─ type: none
     │  │  ╰─ init
     │  │     ╰─ ArrayExpr intArray
     │  │        ├─ size
     │  │        │  ╰─ VarExpr
     │  │        │     ╰─ SimpleVar N
     │  │        ╰─ init
     │  │           ╰─ IntExpr 0
     │  ├─ VarDec col escape=true
     │  │  ├─ type: none
     │  │  ╰─ init
     │  │     ╰─ ArrayExpr intArray
     │  │        ├─ size
     │  │        │  ╰─ VarExpr
     │  │        │     ╰─ SimpleVar N
     │  │        ╰─ init
     │  │           ╰─ IntExpr 0
     │  ├─ VarDec diag1 escape=true
     │  │  ├─ type: none
     │  │  ╰─ init
     │  │     ╰─ ArrayExpr intArray
     │  │        ├─ size
     │  │        │  ╰─ OpExpr MinusOp
     │  │        │     ├─ OpExpr PlusOp
     │  │        │     │  ├─ VarExpr
     │  │        │     │  │  ╰─ SimpleVar N
     │  │        │     │  ╰─ VarExpr
     │  │        │     │     ╰─ SimpleVar N
     │  │        │     ╰─ IntExpr 1
     │  │        ╰─ init
     │  │           ╰─ IntExpr 0
     │  ├─ VarDec diag2 escape=true
     │  │  ├─ type: none
     │  │  ╰─ init
     │  │     ╰─ ArrayExpr intArray
     │  │        ├─ size
     │  │        │  ╰─ OpExpr MinusOp
     │  │        │     ├─ OpExpr PlusOp
     │  │        │     │  ├─ VarExpr
     │  │        │     │  │  ╰─ SimpleVar N
     │  │        │     │  ╰─ VarExpr
     │  │        │     │     ╰─ SimpleVar N
     │  │        │     ╰─ IntExpr 1
     │  │        ╰─ init
     │  │           ╰─ IntExpr 0
     │  ╰─ FunctionDec
     │     ├─ Function printboard
     │     │  ├─ params
     │     │  ├─ result: none
     │     │  ╰─ body
     │     │     ╰─ SeqExpr
     │     │        ├─ ForExpr i escape=true
     │     │        │  ├─ lo
     │     │        │  │  ╰─ IntExpr 0
     │     │        │  ├─ hi
     │     │        │  │  ╰─ OpExpr MinusOp
     │     │        │  │     ├─ VarExpr
     │     │        │  │     │  ╰─ SimpleVar N
     │     │        │  │     ╰─ IntExpr 1
     │     │        │  ╰─ body
     │     │        │     ╰─ SeqExpr
     │     │        │        ├─ ForExpr j escape=true
     │     │        │        │  ├─ lo
     │     │        │        │  │  ╰─ IntExpr 0
     │     │        │        │  ├─ hi
     │     │        │        │  │  ╰─ OpExpr MinusOp
     │     │        │        │  │     ├─ VarExpr
     │     │        │        │  │     │  ╰─ SimpleVar N
     │     │        │        │  │     ╰─ IntExpr 1
     │     │        │        │  ╰─ body
     │     │        │        │     ╰─ CallExpr print
     │     │        │        │        ╰─ IfExpr
     │     │        │        │           ├─ test
     │     │        │        │           │  ╰─ OpExpr EqOp
     │     │        │        │           │     ├─ VarExpr
     │     │        │        │           │     │  ╰─ SubscriptVar
     │     │        │        │           │     │     ├─ var
     │     │        │        │           │     │     │  ╰─ SimpleVar col
     │     │        │        │           │     │     ╰─ index
     │     │        │        │           │     │        ╰─ VarExpr
     │     │        │        │           │     │           ╰─ SimpleVar i
     │     │        │        │           │     ╰─ VarExpr
     │     │        │        │           │        ╰─ SimpleVar j
     │     │        │        │           ├─ then
     │     │        │        │           │  ╰─ StringExpr " O"
     │     │        │        │           ╰─ else
     │     │        │        │              ╰─ StringExpr " ."
     │     │        │        ╰─ CallExpr print
     │     │        │           ╰─ StringExpr "\n"
     │     │        ╰─ CallExpr print
     │     │           ╰─ StringExpr "\n"
     │     ╰─ Function try
     │        ├─ params
     │        │  ╰─ Field c : int escape=true
     │        ├─ result: none
     │        ╰─ body
     │           ╰─ IfExpr
     │              ├─ test
     │              │  ╰─ OpExpr EqOp
     │              │     ├─ VarExpr
     │              │     │  ╰─ SimpleVar c
     │              │     ╰─ VarExpr
     │              │        ╰─ SimpleVar N
     │              ├─ then
     │              │  ╰─ CallExpr printboard
     │              ╰─ else
     │                 ╰─ ForExpr r escape=true
     │                    ├─ lo
     │                    │  ╰─ IntExpr 0
     │                    ├─ hi
     │                    │  ╰─ OpExpr MinusOp
     │                    │     ├─ VarExpr
     │                    │     │  ╰─ SimpleVar N
     │                    │     ╰─ IntExpr 1
     │                    ╰─ body
     │                       ╰─ IfExpr
     │                          ├─ test
     │                          │  ╰─ IfExpr
     │                          │     ├─ test
     │                          │     │  ╰─ IfExpr
     │                          │     │     ├─ test
     │                          │     │     │  ╰─ OpExpr EqOp
     │                          │     │     │     ├─ VarExpr
     │                          │     │     │     │  ╰─ SubscriptVar
     │                          │     │     │     │     ├─ var
     │                          │     │     │     │     │  ╰─ SimpleVar row
     │                          │     │     │     │     ╰─ index
     │                          │     │     │     │        ╰─ VarExpr
     │                          │     │     │     │           ╰─ SimpleVar r
     │                          │     │     │     ╰─ IntExpr 0
     │                          │     │     ├─ then
     │                          │     │     │  ╰─ OpExpr EqOp
     │                          │     │     │     ├─ VarExpr
     │                          │     │     │     │  ╰─ SubscriptVar
     │                          │     │     │     │     ├─ var
     │                          │     │     │     │     │  ╰─ SimpleVar diag1
     │                          │     │     │     │     ╰─ index
     │                          │     │     │     │        ╰─ OpExpr PlusOp
     │                          │     │     │     │           ├─ VarExpr
     │                          │     │     │     │           │  ╰─ SimpleVar r
     │                          │     │     │     │           ╰─ VarExpr
     │                          │     │     │     │              ╰─ SimpleVar c
     │                          │     │     │     ╰─ IntExpr 0
     │                          │     │     ╰─ else
     │                          │     │        ╰─ IntExpr 0
     │                          │     ├─ then
     │                          │     │  ╰─ OpExpr EqOp
     │                          │     │     ├─ VarExpr
     │                          │     │     │  ╰─ SubscriptVar
     │                          │     │     │     ├─ var
     │                          │     │     │     │  ╰─ SimpleVar diag2
     │                          │     │     │     ╰─ index
     │                          │     │     │        ╰─ OpExpr MinusOp
     │                          │     │     │           ├─ OpExpr PlusOp
     │                          │     │     │           │  ├─ VarExpr
     │                          │     │     │           │  │  ╰─ SimpleVar r
     │                          │     │     │           │  ╰─ IntExpr 7
     │                          │     │     │           ╰─ VarExpr
     │                          │     │     │              ╰─ SimpleVar c
     │                          │     │     ╰─ IntExpr 0
     │                          │     ╰─ else
     │                          │        ╰─ IntExpr 0
     │                          ├─ then
     │                          │  ╰─ SeqExpr
     │                          │     ├─ AssignExpr
     │                          │     │  ├─ var
     │                          │     │  │  ╰─ SubscriptVar
     │                          │     │  │     ├─ var
     │                          │     │  │     │  ╰─ SimpleVar row
     │                          │     │  │     ╰─ index
     │                          │     │  │        ╰─ VarExpr
     │                          │     │  │           ╰─ SimpleVar r
     │                          │     │  ╰─ expr
     │                          │     │     ╰─ IntExpr 1
     │                          │     ├─ AssignExpr
     │                          │     │  ├─ var
     │                          │     │  │  ╰─ SubscriptVar
     │                          │     │  │     ├─ var
     │                          │     │  │     │  ╰─ SimpleVar diag1
     │                          │     │  │     ╰─ index
     │                          │     │  │        ╰─ OpExpr PlusOp
     │                          │     │  │           ├─ VarExpr
     │                          │     │  │           │  ╰─ SimpleVar r
     │                          │     │  │           ╰─ VarExpr
     │                          │     │  │              ╰─ SimpleVar c
     │                          │     │  ╰─ expr
     │                          │     │     ╰─ IntExpr 1
     │                          │     ├─ AssignExpr
     │                          │     │  ├─ var
     │                          │     │  │  ╰─ SubscriptVar
     │                          │     │  │     ├─ var
     │                          │     │  │     │  ╰─ SimpleVar diag2
     │                          │     │  │     ╰─ index
     │                          │     │  │        ╰─ OpExpr MinusOp
     │                          │     │  │           ├─ OpExpr PlusOp
     │                          │     │  │           │  ├─ VarExpr
     │                          │     │  │           │  │  ╰─ SimpleVar r
     │                          │     │  │           │  ╰─ IntExpr 7
     │                          │     │  │           ╰─ VarExpr
     │                          │     │  │              ╰─ SimpleVar c
     │                          │     │  ╰─ expr
     │                          │     │     ╰─ IntExpr 1
     │                          │     ├─ AssignExpr
     │                          │     │  ├─ var
     │                          │     │  │  ╰─ SubscriptVar
     │                          │     │  │     ├─ var
     │                          │     │  │     │  ╰─ SimpleVar col
     │                          │     │  │     ╰─ index
     │                          │     │  │        ╰─ VarExpr
     │                          │     │  │           ╰─ SimpleVar c
     │                          │     │  ╰─ expr
     │                          │     │     ╰─ VarExpr
     │                          │     │        ╰─ SimpleVar r
     │                          │     ├─ CallExpr try
     │                          │     │  ╰─ OpExpr PlusOp
     │                          │     │     ├─ VarExpr
     │                          │     │     │  ╰─ SimpleVar c
     │                          │     │     ╰─ IntExpr 1
     │                          │     ├─ AssignExpr
     │                          │     │  ├─ var
     │                          │     │  │  ╰─ SubscriptVar
     │                          │     │  │     ├─ var
     │                          │     │  │     │  ╰─ SimpleVar row
     │                          │     │  │     ╰─ index
     │                          │     │  │        ╰─ VarExpr
     │                          │     │  │           ╰─ SimpleVar r
     │                          │     │  ╰─ expr
     │                          │     │     ╰─ IntExpr 0
     │                          │     ├─ AssignExpr
     │                          │     │  ├─ var
     │                          │     │  │  ╰─ SubscriptVar
     │                          │     │  │     ├─ var
     │                          │     │  │     │  ╰─ SimpleVar diag1
     │                          │     │  │     ╰─ index
     │                          │     │  │        ╰─ OpExpr PlusOp
     │                          │     │  │           ├─ VarExpr
     │                          │     │  │           │  ╰─ SimpleVar r
     │                          │     │  │           ╰─ VarExpr
     │                          │     │  │              ╰─ SimpleVar c
     │                          │     │  ╰─ expr
     │                          │     │     ╰─ IntExpr 0
     │                          │     ╰─ AssignExpr
     │                          │        ├─ var
     │                          │        │  ╰─ SubscriptVar
     │                          │        │     ├─ var
     │                          │        │     │  ╰─ SimpleVar diag2
     │                          │        │     ╰─ index
     │                          │        │        ╰─ OpExpr MinusOp
     │                          │        │           ├─ OpExpr PlusOp
     │                          │        │           │  ├─ VarExpr
     │                          │        │           │  │  ╰─ SimpleVar r
     │                          │        │           │  ╰─ IntExpr 7
     │                          │        │           ╰─ VarExpr
     │                          │        │              ╰─ SimpleVar c
     │                          │        ╰─ expr
     │                          │           ╰─ IntExpr 0
     │                          ╰─ else: none
     ╰─ body
        ╰─ CallExpr try
           ╰─ IntExpr 0
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test1.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ╰─ Type arrtype
     │  │     ╰─ ArrayTy int
     │  ╰─ VarDec arr1 escape=true
     │     ├─ type: arrtype
     │     ╰─ init
     │        ╰─ ArrayExpr arrtype
     │           ├─ size
     │           │  ╰─ IntExpr 10
     │           ╰─ init
     │              ╰─ IntExpr 0
     ╰─ body
        ╰─ VarExpr
           ╰─ SimpleVar arr1
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test10.tig
  ╭─ Tiger AST
  ╰─ WhileExpr
     ├─ test
     │  ╰─ OpExpr GtOp
     │     ├─ IntExpr 10
     │     ╰─ IntExpr 5
     ╰─ body
        ╰─ OpExpr PlusOp
           ├─ IntExpr 5
           ╰─ IntExpr 6
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test11.tig
  ╭─ Tiger AST
  ╰─ ForExpr i escape=true
     ├─ lo
     │  ╰─ IntExpr 10
     ├─ hi
     │  ╰─ StringExpr " "
     ╰─ body
        ╰─ AssignExpr
           ├─ var
           │  ╰─ SimpleVar i
           ╰─ expr
              ╰─ OpExpr MinusOp
                 ├─ VarExpr
                 │  ╰─ SimpleVar i
                 ╰─ IntExpr 1
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test12.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ VarDec a escape=true
     │     ├─ type: none
     │     ╰─ init
     │        ╰─ IntExpr 0
     ╰─ body
        ╰─ ForExpr i escape=true
           ├─ lo
           │  ╰─ IntExpr 0
           ├─ hi
           │  ╰─ IntExpr 100
           ╰─ body
              ╰─ SeqExpr
                 ├─ AssignExpr
                 │  ├─ var
                 │  │  ╰─ SimpleVar a
                 │  ╰─ expr
                 │     ╰─ OpExpr PlusOp
                 │        ├─ VarExpr
                 │        │  ╰─ SimpleVar a
                 │        ╰─ IntExpr 1
                 ╰─ SeqExpr
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test13.tig
  ╭─ Tiger AST
  ╰─ OpExpr GtOp
     ├─ IntExpr 3
     ╰─ StringExpr "df"
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test14.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ├─ Type arrtype
     │  │  │  ╰─ ArrayTy int
     │  │  ╰─ Type rectype
     │  │     ╰─ RecordTy
     │  │        ├─ Field name : string escape=true
     │  │        ╰─ Field id : int escape=true
     │  ├─ VarDec rec escape=true
     │  │  ├─ type: none
     │  │  ╰─ init
     │  │     ╰─ RecordExpr rectype
     │  │        ├─ Field name
     │  │        │  ╰─ StringExpr "aname"
     │  │        ╰─ Field id
     │  │           ╰─ IntExpr 0
     │  ╰─ VarDec arr escape=true
     │     ├─ type: none
     │     ╰─ init
     │        ╰─ ArrayExpr arrtype
     │           ├─ size
     │           │  ╰─ IntExpr 3
     │           ╰─ init
     │              ╰─ IntExpr 0
     ╰─ body
        ╰─ IfExpr
           ├─ test
           │  ╰─ OpExpr NeqOp
           │     ├─ VarExpr
           │     │  ╰─ SimpleVar rec
           │     ╰─ VarExpr
           │        ╰─ SimpleVar arr
           ├─ then
           │  ╰─ IntExpr 3
           ╰─ else
              ╰─ IntExpr 4
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test15.tig
  ╭─ Tiger AST
  ╰─ IfExpr
     ├─ test
     │  ╰─ IntExpr 20
     ├─ then
     │  ╰─ IntExpr 3
     ╰─ else: none
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test16.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ TypeDec
     │     ├─ Type a
     │     │  ╰─ NameTy c
     │     ├─ Type b
     │     │  ╰─ NameTy a
     │     ├─ Type c
     │     │  ╰─ NameTy d
     │     ╰─ Type d
     │        ╰─ NameTy a
     ╰─ body
        ╰─ StringExpr ""
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test17.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ╰─ Type tree
     │  │     ╰─ RecordTy
     │  │        ├─ Field key : int escape=true
     │  │        ╰─ Field children : treelist escape=true
     │  ├─ VarDec d escape=true
     │  │  ├─ type: int
     │  │  ╰─ init
     │  │     ╰─ IntExpr 0
     │  ╰─ TypeDec
     │     ╰─ Type treelist
     │        ╰─ RecordTy
     │           ├─ Field hd : tree escape=true
     │           ╰─ Field tl : treelist escape=true
     ╰─ body
        ╰─ VarExpr
           ╰─ SimpleVar d
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test18.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ FunctionDec
     │  │  ╰─ Function do_nothing1
     │  │     ├─ params
     │  │     │  ├─ Field a : int escape=true
     │  │     │  ╰─ Field b : string escape=true
     │  │     ├─ result: int
     │  │     ╰─ body
     │  │        ╰─ SeqExpr
     │  │           ├─ CallExpr do_nothing2
     │  │           │  ╰─ OpExpr PlusOp
     │  │           │     ├─ VarExpr
     │  │           │     │  ╰─ SimpleVar a
     │  │           │     ╰─ IntExpr 1
     │  │           ╰─ IntExpr 0
     │  ├─ VarDec d escape=true
     │  │  ├─ type: none
     │  │  ╰─ init
     │  │     ╰─ IntExpr 0
     │  ╰─ FunctionDec
     │     ╰─ Function do_nothing2
     │        ├─ params
     │        │  ╰─ Field d : int escape=true
     │        ├─ result: string
     │        ╰─ body
     │           ╰─ SeqExpr
     │              ├─ CallExpr do_nothing1
     │              │  ├─ VarExpr
     │              │  │  ╰─ SimpleVar d
     │              │  ╰─ StringExpr "str"
     │              ╰─ StringExpr " "
     ╰─ body
        ╰─ CallExpr do_nothing1
           ├─ IntExpr 0
           ╰─ StringExpr "str2"
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test19.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ FunctionDec
     │     ├─ Function do_nothing1
     │     │  ├─ params
     │     │  │  ├─ Field a : int escape=true
     │     │  │  ╰─ Field b : string escape=true
     │     │  ├─ result: int
     │     │  ╰─ body
     │     │     ╰─ SeqExpr
     │     │        ├─ CallExpr do_nothing2
     │     │        │  ╰─ OpExpr PlusOp
     │     │        │     ├─ VarExpr
     │     │        │     │  ╰─ SimpleVar a
     │     │        │     ╰─ IntExpr 1
     │     │        ╰─ IntExpr 0
     │     ╰─ Function do_nothing2
     │        ├─ params
     │        │  ╰─ Field d : int escape=true
     │        ├─ result: string
     │        ╰─ body
     │           ╰─ SeqExpr
     │              ├─ CallExpr do_nothing1
     │              │  ├─ VarExpr
     │              │  │  ╰─ SimpleVar a
     │              │  ╰─ StringExpr "str"
     │              ╰─ StringExpr " "
     ╰─ body
        ╰─ CallExpr do_nothing1
           ├─ IntExpr 0
           ╰─ StringExpr "str2"
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test2.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ├─ Type myint
     │  │  │  ╰─ NameTy int
     │  │  ╰─ Type arrtype
     │  │     ╰─ ArrayTy myint
     │  ╰─ VarDec arr1 escape=true
     │     ├─ type: arrtype
     │     ╰─ init
     │        ╰─ ArrayExpr arrtype
     │           ├─ size
     │           │  ╰─ IntExpr 10
     │           ╰─ init
     │              ╰─ IntExpr 0
     ╰─ body
        ╰─ VarExpr
           ╰─ SimpleVar arr1
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test20.tig
  ╭─ Tiger AST
  ╰─ WhileExpr
     ├─ test
     │  ╰─ OpExpr GtOp
     │     ├─ IntExpr 10
     │     ╰─ IntExpr 5
     ╰─ body
        ╰─ SeqExpr
           ├─ OpExpr PlusOp
           │  ├─ VarExpr
           │  │  ╰─ SimpleVar i
           │  ╰─ IntExpr 1
           ╰─ SeqExpr
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test21.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ FunctionDec
     │     ╰─ Function nfactor
     │        ├─ params
     │        │  ╰─ Field n : int escape=true
     │        ├─ result: none
     │        ╰─ body
     │           ╰─ IfExpr
     │              ├─ test
     │              │  ╰─ OpExpr EqOp
     │              │     ├─ VarExpr
     │              │     │  ╰─ SimpleVar n
     │              │     ╰─ IntExpr 0
     │              ├─ then
     │              │  ╰─ IntExpr 1
     │              ╰─ else
     │                 ╰─ OpExpr TimesOp
     │                    ├─ VarExpr
     │                    │  ╰─ SimpleVar n
     │                    ╰─ CallExpr nfactor
     │                       ╰─ OpExpr MinusOp
     │                          ├─ VarExpr
     │                          │  ╰─ SimpleVar n
     │                          ╰─ IntExpr 1
     ╰─ body
        ╰─ CallExpr nfactor
           ╰─ IntExpr 10
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test22.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ╰─ Type rectype
     │  │     ╰─ RecordTy
     │  │        ├─ Field name : string escape=true
     │  │        ╰─ Field id : int escape=true
     │  ╰─ VarDec rec1 escape=true
     │     ├─ type: none
     │     ╰─ init
     │        ╰─ RecordExpr rectype
     │           ├─ Field name
     │           │  ╰─ StringExpr "Name"
     │           ╰─ Field id
     │              ╰─ IntExpr 0
     ╰─ body
        ╰─ AssignExpr
           ├─ var
           │  ╰─ FieldVar nam
           │     ╰─ SimpleVar rec1
           ╰─ expr
              ╰─ StringExpr "asd"
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test23.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ╰─ Type rectype
     │  │     ╰─ RecordTy
     │  │        ├─ Field name : string escape=true
     │  │        ╰─ Field id : int escape=true
     │  ╰─ VarDec rec1 escape=true
     │     ├─ type: none
     │     ╰─ init
     │        ╰─ RecordExpr rectype
     │           ├─ Field name
     │           │  ╰─ StringExpr "aname"
     │           ╰─ Field id
     │              ╰─ IntExpr 0
     ╰─ body
        ╰─ SeqExpr
           ├─ AssignExpr
           │  ├─ var
           │  │  ╰─ FieldVar name
           │  │     ╰─ SimpleVar rec1
           │  ╰─ expr
           │     ╰─ IntExpr 3
           ╰─ AssignExpr
              ├─ var
              │  ╰─ FieldVar id
              │     ╰─ SimpleVar rec1
              ╰─ expr
                 ╰─ StringExpr ""
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test24.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ VarDec d escape=true
     │     ├─ type: none
     │     ╰─ init
     │        ╰─ IntExpr 0
     ╰─ body
        ╰─ VarExpr
           ╰─ SubscriptVar
              ├─ var
              │  ╰─ SimpleVar d
              ╰─ index
                 ╰─ IntExpr 3
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test25.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ VarDec d escape=true
     │     ├─ type: none
     │     ╰─ init
     │        ╰─ IntExpr 0
     ╰─ body
        ╰─ VarExpr
           ╰─ FieldVar f
              ╰─ SimpleVar d
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test26.tig
  ╭─ Tiger AST
  ╰─ OpExpr PlusOp
     ├─ IntExpr 3
     ╰─ StringExpr "var"
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test27.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ VarDec a escape=true
     │  │  ├─ type: none
     │  │  ╰─ init
     │  │     ╰─ IntExpr 0
     │  ╰─ FunctionDec
     │     ╰─ Function g
     │        ├─ params
     │        │  ╰─ Field a : int escape=true
     │        ├─ result: int
     │        ╰─ body
     │           ╰─ VarExpr
     │              ╰─ SimpleVar a
     ╰─ body
        ╰─ CallExpr g
           ╰─ IntExpr 2
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test28.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ├─ Type rectype1
     │  │  │  ╰─ RecordTy
     │  │  │     ├─ Field name : string escape=true
     │  │  │     ╰─ Field id : int escape=true
     │  │  ╰─ Type rectype2
     │  │     ╰─ RecordTy
     │  │        ├─ Field name : string escape=true
     │  │        ╰─ Field id : int escape=true
     │  ╰─ VarDec rec1 escape=true
     │     ├─ type: rectype1
     │     ╰─ init
     │        ╰─ RecordExpr rectype2
     │           ├─ Field name
     │           │  ╰─ StringExpr "Name"
     │           ╰─ Field id
     │              ╰─ IntExpr 0
     ╰─ body
        ╰─ VarExpr
           ╰─ SimpleVar rec1
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test29.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ├─ Type arrtype1
     │  │  │  ╰─ ArrayTy int
     │  │  ╰─ Type arrtype2
     │  │     ╰─ ArrayTy int
     │  ╰─ VarDec arr1 escape=true
     │     ├─ type: arrtype1
     │     ╰─ init
     │        ╰─ ArrayExpr arrtype2
     │           ├─ size
     │           │  ╰─ IntExpr 10
     │           ╰─ init
     │              ╰─ IntExpr 0
     ╰─ body
        ╰─ VarExpr
           ╰─ SimpleVar arr1
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test3.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ╰─ Type rectype
     │  │     ╰─ RecordTy
     │  │        ├─ Field name : string escape=true
     │  │        ╰─ Field age : int escape=true
     │  ╰─ VarDec rec1 escape=true
     │     ├─ type: rectype
     │     ╰─ init
     │        ╰─ RecordExpr rectype
     │           ├─ Field name
     │           │  ╰─ StringExpr "Nobody"
     │           ╰─ Field age
     │              ╰─ IntExpr 1000
     ╰─ body
        ╰─ SeqExpr
           ├─ AssignExpr
           │  ├─ var
           │  │  ╰─ FieldVar name
           │  │     ╰─ SimpleVar rec1
           │  ╰─ expr
           │     ╰─ StringExpr "Somebody"
           ╰─ VarExpr
              ╰─ SimpleVar rec1
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test30.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ├─ Type a
     │  │  │  ╰─ ArrayTy int
     │  │  ╰─ Type b
     │  │     ╰─ NameTy a
     │  ╰─ VarDec arr1 escape=true
     │     ├─ type: a
     │     ╰─ init
     │        ╰─ ArrayExpr b
     │           ├─ size
     │           │  ╰─ IntExpr 10
     │           ╰─ init
     │              ╰─ IntExpr 0
     ╰─ body
        ╰─ VarExpr
           ╰─ SubscriptVar
              ├─ var
              │  ╰─ SimpleVar arr1
              ╰─ index
                 ╰─ IntExpr 2
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test31.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ VarDec a escape=true
     │     ├─ type: int
     │     ╰─ init
     │        ╰─ StringExpr " "
     ╰─ body
        ╰─ VarExpr
           ╰─ SimpleVar a
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test32.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ╰─ Type arrayty
     │  │     ╰─ ArrayTy int
     │  ╰─ VarDec a escape=true
     │     ├─ type: none
     │     ╰─ init
     │        ╰─ ArrayExpr arrayty
     │           ├─ size
     │           │  ╰─ IntExpr 10
     │           ╰─ init
     │              ╰─ StringExpr " "
     ╰─ body
        ╰─ IntExpr 0
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test33.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ VarDec a escape=true
     │     ├─ type: none
     │     ╰─ init
     │        ╰─ RecordExpr rectype
     ╰─ body
        ╰─ IntExpr 0
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test34.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ FunctionDec
     │     ╰─ Function g
     │        ├─ params
     │        │  ├─ Field a : int escape=true
     │        │  ╰─ Field b : string escape=true
     │        ├─ result: int
     │        ╰─ body
     │           ╰─ VarExpr
     │              ╰─ SimpleVar a
     ╰─ body
        ╰─ CallExpr g
           ├─ StringExpr "one"
           ╰─ StringExpr "two"
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test35.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ FunctionDec
     │     ╰─ Function g
     │        ├─ params
     │        │  ├─ Field a : int escape=true
     │        │  ╰─ Field b : string escape=true
     │        ├─ result: int
     │        ╰─ body
     │           ╰─ VarExpr
     │              ╰─ SimpleVar a
     ╰─ body
        ╰─ CallExpr g
           ╰─ StringExpr "one"
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test36.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ FunctionDec
     │     ╰─ Function g
     │        ├─ params
     │        │  ├─ Field a : int escape=true
     │        │  ╰─ Field b : string escape=true
     │        ├─ result: int
     │        ╰─ body
     │           ╰─ VarExpr
     │              ╰─ SimpleVar a
     ╰─ body
        ╰─ CallExpr g
           ├─ IntExpr 3
           ├─ StringExpr "one"
           ╰─ IntExpr 5
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test37.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ VarDec a escape=true
     │  │  ├─ type: none
     │  │  ╰─ init
     │  │     ╰─ IntExpr 0
     │  ╰─ VarDec a escape=true
     │     ├─ type: none
     │     ╰─ init
     │        ╰─ StringExpr " "
     ╰─ body
        ╰─ IntExpr 0
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test38.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ TypeDec
     │     ├─ Type a
     │     │  ╰─ NameTy int
     │     ╰─ Type a
     │        ╰─ NameTy string
     ╰─ body
        ╰─ IntExpr 0
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test39.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ FunctionDec
     │     ├─ Function g
     │     │  ├─ params
     │     │  │  ╰─ Field a : int escape=true
     │     │  ├─ result: int
     │     │  ╰─ body
     │     │     ╰─ VarExpr
     │     │        ╰─ SimpleVar a
     │     ╰─ Function g
     │        ├─ params
     │        │  ╰─ Field a : int escape=true
     │        ├─ result: int
     │        ╰─ body
     │           ╰─ VarExpr
     │              ╰─ SimpleVar a
     ╰─ body
        ╰─ IntExpr 0
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test4.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ FunctionDec
     │     ╰─ Function nfactor
     │        ├─ params
     │        │  ╰─ Field n : int escape=true
     │        ├─ result: int
     │        ╰─ body
     │           ╰─ IfExpr
     │              ├─ test
     │              │  ╰─ OpExpr EqOp
     │              │     ├─ VarExpr
     │              │     │  ╰─ SimpleVar n
     │              │     ╰─ IntExpr 0
     │              ├─ then
     │              │  ╰─ IntExpr 1
     │              ╰─ else
     │                 ╰─ OpExpr TimesOp
     │                    ├─ VarExpr
     │                    │  ╰─ SimpleVar n
     │                    ╰─ CallExpr nfactor
     │                       ╰─ OpExpr MinusOp
     │                          ├─ VarExpr
     │                          │  ╰─ SimpleVar n
     │                          ╰─ IntExpr 1
     ╰─ body
        ╰─ CallExpr nfactor
           ╰─ IntExpr 10
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test40.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ FunctionDec
     │     ╰─ Function g
     │        ├─ params
     │        │  ╰─ Field a : int escape=true
     │        ├─ result: none
     │        ╰─ body
     │           ╰─ VarExpr
     │              ╰─ SimpleVar a
     ╰─ body
        ╰─ CallExpr g
           ╰─ IntExpr 2
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test41.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ TypeDec
     │     ╰─ Type a
     │        ╰─ NameTy int
     ╰─ body
        ╰─ LetExpr
           ├─ decs
           │  ╰─ TypeDec
           │     ╰─ Type a
           │        ╰─ NameTy string
           ╰─ body
              ╰─ IntExpr 0
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test42.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ├─ Type arrtype1
     │  │  │  ╰─ ArrayTy int
     │  │  ├─ Type rectype1
     │  │  │  ╰─ RecordTy
     │  │  │     ├─ Field name : string escape=true
     │  │  │     ├─ Field address : string escape=true
     │  │  │     ├─ Field id : int escape=true
     │  │  │     ╰─ Field age : int escape=true
     │  │  ├─ Type arrtype2
     │  │  │  ╰─ ArrayTy rectype1
     │  │  ├─ Type rectype2
     │  │  │  ╰─ RecordTy
     │  │  │     ├─ Field name : string escape=true
     │  │  │     ╰─ Field dates : arrtype1 escape=true
     │  │  ╰─ Type arrtype3
     │  │     ╰─ ArrayTy string
     │  ├─ VarDec arr1 escape=true
     │  │  ├─ type: none
     │  │  ╰─ init
     │  │     ╰─ ArrayExpr arrtype1
     │  │        ├─ size
     │  │        │  ╰─ IntExpr 10
     │  │        ╰─ init
     │  │           ╰─ IntExpr 0
     │  ├─ VarDec arr2 escape=true
     │  │  ├─ type: none
     │  │  ╰─ init
     │  │     ╰─ ArrayExpr arrtype2
     │  │        ├─ size
     │  │        │  ╰─ IntExpr 5
     │  │        ╰─ init
     │  │           ╰─ RecordExpr rectype1
     │  │              ├─ Field name
     │  │              │  ╰─ StringExpr "aname"
     │  │              ├─ Field address
     │  │              │  ╰─ StringExpr "somewhere"
     │  │              ├─ Field id
     │  │              │  ╰─ IntExpr 0
     │  │              ╰─ Field age
     │  │                 ╰─ IntExpr 0
     │  ├─ VarDec arr3 escape=true
     │  │  ├─ type: arrtype3
     │  │  ╰─ init
     │  │     ╰─ ArrayExpr arrtype3
     │  │        ├─ size
     │  │        │  ╰─ IntExpr 100
     │  │        ╰─ init
     │  │           ╰─ StringExpr ""
     │  ├─ VarDec rec1 escape=true
     │  │  ├─ type: none
     │  │  ╰─ init
     │  │     ╰─ RecordExpr rectype1
     │  │        ├─ Field name
     │  │        │  ╰─ StringExpr "Kapoios"
     │  │        ├─ Field address
     │  │        │  ╰─ StringExpr "Kapou"
     │  │        ├─ Field id
     │  │        │  ╰─ IntExpr 2432
     │  │        ╰─ Field age
     │  │           ╰─ IntExpr 44
     │  ╰─ VarDec rec2 escape=true
     │     ├─ type: none
     │     ╰─ init
     │        ╰─ RecordExpr rectype2
     │           ├─ Field name
     │           │  ╰─ StringExpr "Allos"
     │           ╰─ Field dates
     │              ╰─ ArrayExpr arrtype1
     │                 ├─ size
     │                 │  ╰─ IntExpr 3
     │                 ╰─ init
     │                    ╰─ IntExpr 1900
     ╰─ body
        ╰─ SeqExpr
           ├─ AssignExpr
           │  ├─ var
           │  │  ╰─ SubscriptVar
           │  │     ├─ var
           │  │     │  ╰─ SimpleVar arr1
           │  │     ╰─ index
           │  │        ╰─ IntExpr 0
           │  ╰─ expr
           │     ╰─ IntExpr 1
           ├─ AssignExpr
           │  ├─ var
           │  │  ╰─ SubscriptVar
           │  │     ├─ var
           │  │     │  ╰─ SimpleVar arr1
           │  │     ╰─ index
           │  │        ╰─ IntExpr 9
           │  ╰─ expr
           │     ╰─ IntExpr 3
           ├─ AssignExpr
           │  ├─ var
           │  │  ╰─ FieldVar name
           │  │     ╰─ SubscriptVar
           │  │        ├─ var
           │  │        │  ╰─ SimpleVar arr2
           │  │        ╰─ index
           │  │           ╰─ IntExpr 3
           │  ╰─ expr
           │     ╰─ StringExpr "kati"
           ├─ AssignExpr
           │  ├─ var
           │  │  ╰─ FieldVar age
           │  │     ╰─ SubscriptVar
           │  │        ├─ var
           │  │        │  ╰─ SimpleVar arr2
           │  │        ╰─ index
           │  │           ╰─ IntExpr 1
           │  ╰─ expr
           │     ╰─ IntExpr 23
           ├─ AssignExpr
           │  ├─ var
           │  │  ╰─ SubscriptVar
           │  │     ├─ var
           │  │     │  ╰─ SimpleVar arr3
           │  │     ╰─ index
           │  │        ╰─ IntExpr 34
           │  ╰─ expr
           │     ╰─ StringExpr "sfd"
           ├─ AssignExpr
           │  ├─ var
           │  │  ╰─ FieldVar name
           │  │     ╰─ SimpleVar rec1
           │  ╰─ expr
           │     ╰─ StringExpr "sdf"
           ├─ AssignExpr
           │  ├─ var
           │  │  ╰─ SubscriptVar
           │  │     ├─ var
           │  │     │  ╰─ FieldVar dates
           │  │     │     ╰─ SimpleVar rec2
           │  │     ╰─ index
           │  │        ╰─ IntExpr 0
           │  ╰─ expr
           │     ╰─ IntExpr 2323
           ╰─ AssignExpr
              ├─ var
              │  ╰─ SubscriptVar
              │     ├─ var
              │     │  ╰─ FieldVar dates
              │     │     ╰─ SimpleVar rec2
              │     ╰─ index
              │        ╰─ IntExpr 2
              ╰─ expr
                 ╰─ IntExpr 2323
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test43.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ VarDec a escape=true
     │     ├─ type: none
     │     ╰─ init
     │        ╰─ SeqExpr
     ╰─ body
        ╰─ OpExpr PlusOp
           ├─ VarExpr
           │  ╰─ SimpleVar a
           ╰─ IntExpr 3
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test44.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ╰─ Type rectype
     │  │     ╰─ RecordTy
     │  │        ├─ Field name : string escape=true
     │  │        ╰─ Field id : int escape=true
     │  ╰─ VarDec b escape=true
     │     ├─ type: rectype
     │     ╰─ init
     │        ╰─ NilExpr
     ╰─ body
        ╰─ AssignExpr
           ├─ var
           │  ╰─ SimpleVar b
           ╰─ expr
              ╰─ NilExpr
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test45.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ╰─ Type rectype
     │  │     ╰─ RecordTy
     │  │        ├─ Field name : string escape=true
     │  │        ╰─ Field id : int escape=true
     │  ╰─ VarDec a escape=true
     │     ├─ type: none
     │     ╰─ init
     │        ╰─ NilExpr
     ╰─ body
        ╰─ VarExpr
           ╰─ SimpleVar a
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test46.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ╰─ Type rectype
     │  │     ╰─ RecordTy
     │  │        ├─ Field name : string escape=true
     │  │        ╰─ Field id : int escape=true
     │  ╰─ VarDec b escape=true
     │     ├─ type: rectype
     │     ╰─ init
     │        ╰─ NilExpr
     ╰─ body
        ╰─ SeqExpr
           ├─ OpExpr EqOp
           │  ├─ VarExpr
           │  │  ╰─ SimpleVar b
           │  ╰─ NilExpr
           ╰─ OpExpr NeqOp
              ├─ VarExpr
              │  ╰─ SimpleVar b
              ╰─ NilExpr
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test47.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ╰─ Type a
     │  │     ╰─ NameTy int
     │  ├─ VarDec b escape=true
     │  │  ├─ type: none
     │  │  ╰─ init
     │  │     ╰─ IntExpr 4
     │  ╰─ TypeDec
     │     ╰─ Type a
     │        ╰─ NameTy string
     ╰─ body
        ╰─ IntExpr 0
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test48.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ FunctionDec
     │  │  ╰─ Function g
     │  │     ├─ params
     │  │     │  ╰─ Field a : int escape=true
     │  │     ├─ result: int
     │  │     ╰─ body
     │  │        ╰─ VarExpr
     │  │           ╰─ SimpleVar a
     │  ├─ TypeDec
     │  │  ╰─ Type t
     │  │     ╰─ NameTy int
     │  ╰─ FunctionDec
     │     ╰─ Function g
     │        ├─ params
     │        │  ╰─ Field a : int escape=true
     │        ├─ result: int
     │        ╰─ body
     │           ╰─ VarExpr
     │              ╰─ SimpleVar a
     ╰─ body
        ╰─ IntExpr 0
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test49.tig
  ../../programs/testcases/test49.tig:5.17:syntax error
  [2]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test5.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ├─ TypeDec
     │  │  ├─ Type intlist
     │  │  │  ╰─ RecordTy
     │  │  │     ├─ Field hd : int escape=true
     │  │  │     ╰─ Field tl : intlist escape=true
     │  │  ├─ Type tree
     │  │  │  ╰─ RecordTy
     │  │  │     ├─ Field key : int escape=true
     │  │  │     ╰─ Field children : treelist escape=true
     │  │  ╰─ Type treelist
     │  │     ╰─ RecordTy
     │  │        ├─ Field hd : tree escape=true
     │  │        ╰─ Field tl : treelist escape=true
     │  ╰─ VarDec lis escape=true
     │     ├─ type: intlist
     │     ╰─ init
     │        ╰─ RecordExpr intlist
     │           ├─ Field hd
     │           │  ╰─ IntExpr 0
     │           ╰─ Field tl
     │              ╰─ NilExpr
     ╰─ body
        ╰─ VarExpr
           ╰─ SimpleVar lis
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test6.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ FunctionDec
     │     ├─ Function do_nothing1
     │     │  ├─ params
     │     │  │  ├─ Field a : int escape=true
     │     │  │  ╰─ Field b : string escape=true
     │     │  ├─ result: none
     │     │  ╰─ body
     │     │     ╰─ CallExpr do_nothing2
     │     │        ╰─ OpExpr PlusOp
     │     │           ├─ VarExpr
     │     │           │  ╰─ SimpleVar a
     │     │           ╰─ IntExpr 1
     │     ╰─ Function do_nothing2
     │        ├─ params
     │        │  ╰─ Field d : int escape=true
     │        ├─ result: none
     │        ╰─ body
     │           ╰─ CallExpr do_nothing1
     │              ├─ VarExpr
     │              │  ╰─ SimpleVar d
     │              ╰─ StringExpr "str"
     ╰─ body
        ╰─ CallExpr do_nothing1
           ├─ IntExpr 0
           ╰─ StringExpr "str2"
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test7.tig
  ╭─ Tiger AST
  ╰─ LetExpr
     ├─ decs
     │  ╰─ FunctionDec
     │     ├─ Function do_nothing1
     │     │  ├─ params
     │     │  │  ├─ Field a : int escape=true
     │     │  │  ╰─ Field b : string escape=true
     │     │  ├─ result: int
     │     │  ╰─ body
     │     │     ╰─ SeqExpr
     │     │        ├─ CallExpr do_nothing2
     │     │        │  ╰─ OpExpr PlusOp
     │     │        │     ├─ VarExpr
     │     │        │     │  ╰─ SimpleVar a
     │     │        │     ╰─ IntExpr 1
     │     │        ╰─ IntExpr 0
     │     ╰─ Function do_nothing2
     │        ├─ params
     │        │  ╰─ Field d : int escape=true
     │        ├─ result: string
     │        ╰─ body
     │           ╰─ SeqExpr
     │              ├─ CallExpr do_nothing1
     │              │  ├─ VarExpr
     │              │  │  ╰─ SimpleVar d
     │              │  ╰─ StringExpr "str"
     │              ╰─ StringExpr " "
     ╰─ body
        ╰─ CallExpr do_nothing1
           ├─ IntExpr 0
           ╰─ StringExpr "str2"
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test8.tig
  ╭─ Tiger AST
  ╰─ IfExpr
     ├─ test
     │  ╰─ OpExpr GtOp
     │     ├─ IntExpr 10
     │     ╰─ IntExpr 20
     ├─ then
     │  ╰─ IntExpr 30
     ╰─ else
        ╰─ IntExpr 40
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test9.tig
  ╭─ Tiger AST
  ╰─ IfExpr
     ├─ test
     │  ╰─ OpExpr GtOp
     │     ├─ IntExpr 5
     │     ╰─ IntExpr 4
     ├─ then
     │  ╰─ IntExpr 13
     ╰─ else
        ╰─ StringExpr " "
