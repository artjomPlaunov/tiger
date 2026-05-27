```txt
 $ ../../bin/tiger_ast.exe ../../programs/testcases/test46.tig
  ╭─ Tiger AST
  ╰─ LetExp
     ├─ decs
     │  ├─ TypeDec
     │  │  ╰─ Type rectype
     │  │     ╰─ RecordTy
     │  │        ├─ Field name : string escape=true
     │  │        ╰─ Field id : int escape=true
     │  ╰─ VarDec b escape=true
     │     ├─ type: rectype
     │     ╰─ init
     │        ╰─ NilExp
     ╰─ body
        ╰─ SeqExp
           ├─ OpExp EqOp
           │  ├─ VarExp
           │  │  ╰─ SimpleVar b
           │  ╰─ NilExp
           ╰─ OpExp NeqOp
              ├─ VarExp
              │  ╰─ SimpleVar b
              ╰─ NilExp
```