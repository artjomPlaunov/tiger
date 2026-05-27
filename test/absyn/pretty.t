  $ ../../bin/tiger_ast.exe ../../programs/parser/arithmetic.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ OpExp MinusOp ]
       |==[ OpExp PlusOp ]
       |    |==[ IntExp 1 ]
       |    `==[ OpExp TimesOp ]
       |         |==[ IntExp 2 ]
       |         `==[ IntExp 3 ]
       `==[ OpExp DivideOp ]
            |==[ IntExp 4 ]
            `==[ IntExp 2 ]

  $ ../../bin/tiger_ast.exe ../../programs/parser/assign-lvalue.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ AssignExp ]
       |==[ var ]
       |    `==[ FieldVar x ]
       |         `==[ SubscriptVar ]
       |              |==[ var ]
       |              |    `==[ SimpleVar rows ]
       |              `==[ index ]
       |                   `==[ IntExp 0 ]
       `==[ exp ]
            `==[ VarExp ]
                 `==[ FieldVar y ]
                      `==[ SimpleVar other ]

  $ ../../bin/tiger_ast.exe ../../programs/parser/for-mixed.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ ForExp i escape=true ]
       |==[ lo ]
       |    `==[ IntExp 0 ]
       |==[ hi ]
       |    `==[ OpExp MinusOp ]
       |         |==[ VarExp ]
       |         |    `==[ SimpleVar n ]
       |         `==[ IntExp 1 ]
       `==[ body ]
            `==[ IfExp ]
                 |==[ test ]
                 |    `==[ VarExp ]
                 |         `==[ SimpleVar ready ]
                 |==[ then ]
                 |    `==[ CallExp print ]
                 |         `==[ CallExp chr ]
                 |              `==[ VarExp ]
                 |                   `==[ SimpleVar i ]
                 `==[ else ]
                      `==[ SeqExp ]

  $ ../../bin/tiger_ast.exe ../../programs/parser/let-type-record-fields.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ TypeDec ]
       |         `==[ Type point ]
       |              `==[ RecordTy ]
       |                   |==[ Field x : int escape=true ]
       |                   `==[ Field y : int escape=true ]
       `==[ body ]
            `==[ RecordExp point ]
                 |==[ Field x ]
                 |    `==[ IntExp 1 ]
                 `==[ Field y ]
                      `==[ IntExp 2 ]

  $ ../../bin/tiger_ast.exe ../../programs/parser/let-decs-mixed.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    `==[ Type count ]
       |    |         `==[ NameTy int ]
       |    |==[ VarDec start escape=true ]
       |    |    |==[ type: count ]
       |    |    `==[ init ]
       |    |         `==[ IntExp 0 ]
       |    `==[ FunctionDec ]
       |         `==[ Function inc ]
       |              |==[ params ]
       |              |    `==[ Field x : count escape=true ]
       |              |==[ result: count ]
       |              `==[ body ]
       |                   `==[ OpExp PlusOp ]
       |                        |==[ VarExp ]
       |                        |    `==[ SimpleVar x ]
       |                        `==[ IntExp 1 ]
       `==[ body ]
            `==[ CallExp inc ]
                 `==[ VarExp ]
                      `==[ SimpleVar start ]

Print the imported Tiger testcase corpus as ASTs too. test49.tig is
syntactically invalid, so it prints the parser error.

  $ ../../bin/tiger_ast.exe ../../programs/testcases/merge.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    `==[ Type any ]
       |    |         `==[ RecordTy ]
       |    |              `==[ Field any : int escape=true ]
       |    |==[ VarDec buffer escape=true ]
       |    |    |==[ type: none ]
       |    |    `==[ init ]
       |    |         `==[ CallExp getchar ]
       |    |==[ FunctionDec ]
       |    |    `==[ Function readint ]
       |    |         |==[ params ]
       |    |         |    `==[ Field any : any escape=true ]
       |    |         |==[ result: int ]
       |    |         `==[ body ]
       |    |              `==[ LetExp ]
       |    |                   |==[ decs ]
       |    |                   |    |==[ VarDec i escape=true ]
       |    |                   |    |    |==[ type: none ]
       |    |                   |    |    `==[ init ]
       |    |                   |    |         `==[ IntExp 0 ]
       |    |                   |    `==[ FunctionDec ]
       |    |                   |         |==[ Function isdigit ]
       |    |                   |         |    |==[ params ]
       |    |                   |         |    |    `==[ Field s : string escape=true ]
       |    |                   |         |    |==[ result: int ]
       |    |                   |         |    `==[ body ]
       |    |                   |         |         `==[ IfExp ]
       |    |                   |         |              |==[ test ]
       |    |                   |         |              |    `==[ OpExp GeOp ]
       |    |                   |         |              |         |==[ CallExp ord ]
       |    |                   |         |              |         |    `==[ VarExp ]
       |    |                   |         |              |         |         `==[ SimpleVar buffer ]
       |    |                   |         |              |         `==[ CallExp ord ]
       |    |                   |         |              |              `==[ StringExp "0" ]
       |    |                   |         |              |==[ then ]
       |    |                   |         |              |    `==[ OpExp LeOp ]
       |    |                   |         |              |         |==[ CallExp ord ]
       |    |                   |         |              |         |    `==[ VarExp ]
       |    |                   |         |              |         |         `==[ SimpleVar buffer ]
       |    |                   |         |              |         `==[ CallExp ord ]
       |    |                   |         |              |              `==[ StringExp "9" ]
       |    |                   |         |              `==[ else ]
       |    |                   |         |                   `==[ IntExp 0 ]
       |    |                   |         `==[ Function skipto ]
       |    |                   |              |==[ params ]
       |    |                   |              |==[ result: none ]
       |    |                   |              `==[ body ]
       |    |                   |                   `==[ WhileExp ]
       |    |                   |                        |==[ test ]
       |    |                   |                        |    `==[ IfExp ]
       |    |                   |                        |         |==[ test ]
       |    |                   |                        |         |    `==[ OpExp EqOp ]
       |    |                   |                        |         |         |==[ VarExp ]
       |    |                   |                        |         |         |    `==[ SimpleVar buffer ]
       |    |                   |                        |         |         `==[ StringExp " " ]
       |    |                   |                        |         |==[ then ]
       |    |                   |                        |         |    `==[ IntExp 1 ]
       |    |                   |                        |         `==[ else ]
       |    |                   |                        |              `==[ OpExp EqOp ]
       |    |                   |                        |                   |==[ VarExp ]
       |    |                   |                        |                   |    `==[ SimpleVar buffer ]
       |    |                   |                        |                   `==[ StringExp "\n" ]
       |    |                   |                        `==[ body ]
       |    |                   |                             `==[ AssignExp ]
       |    |                   |                                  |==[ var ]
       |    |                   |                                  |    `==[ SimpleVar buffer ]
       |    |                   |                                  `==[ exp ]
       |    |                   |                                       `==[ CallExp getchar ]
       |    |                   `==[ body ]
       |    |                        `==[ SeqExp ]
       |    |                             |==[ CallExp skipto ]
       |    |                             |==[ AssignExp ]
       |    |                             |    |==[ var ]
       |    |                             |    |    `==[ FieldVar any ]
       |    |                             |    |         `==[ SimpleVar any ]
       |    |                             |    `==[ exp ]
       |    |                             |         `==[ CallExp isdigit ]
       |    |                             |              `==[ VarExp ]
       |    |                             |                   `==[ SimpleVar buffer ]
       |    |                             |==[ WhileExp ]
       |    |                             |    |==[ test ]
       |    |                             |    |    `==[ CallExp isdigit ]
       |    |                             |    |         `==[ VarExp ]
       |    |                             |    |              `==[ SimpleVar buffer ]
       |    |                             |    `==[ body ]
       |    |                             |         `==[ SeqExp ]
       |    |                             |              |==[ AssignExp ]
       |    |                             |              |    |==[ var ]
       |    |                             |              |    |    `==[ SimpleVar i ]
       |    |                             |              |    `==[ exp ]
       |    |                             |              |         `==[ OpExp MinusOp ]
       |    |                             |              |              |==[ OpExp PlusOp ]
       |    |                             |              |              |    |==[ OpExp TimesOp ]
       |    |                             |              |              |    |    |==[ VarExp ]
       |    |                             |              |              |    |    |    `==[ SimpleVar i ]
       |    |                             |              |              |    |    `==[ IntExp 10 ]
       |    |                             |              |              |    `==[ CallExp ord ]
       |    |                             |              |              |         `==[ VarExp ]
       |    |                             |              |              |              `==[ SimpleVar buffer ]
       |    |                             |              |              `==[ CallExp ord ]
       |    |                             |              |                   `==[ StringExp "0" ]
       |    |                             |              `==[ AssignExp ]
       |    |                             |                   |==[ var ]
       |    |                             |                   |    `==[ SimpleVar buffer ]
       |    |                             |                   `==[ exp ]
       |    |                             |                        `==[ CallExp getchar ]
       |    |                             `==[ VarExp ]
       |    |                                  `==[ SimpleVar i ]
       |    |==[ TypeDec ]
       |    |    `==[ Type list ]
       |    |         `==[ RecordTy ]
       |    |              |==[ Field first : int escape=true ]
       |    |              `==[ Field rest : list escape=true ]
       |    |==[ FunctionDec ]
       |    |    |==[ Function readlist ]
       |    |    |    |==[ params ]
       |    |    |    |==[ result: list ]
       |    |    |    `==[ body ]
       |    |    |         `==[ LetExp ]
       |    |    |              |==[ decs ]
       |    |    |              |    |==[ VarDec any escape=true ]
       |    |    |              |    |    |==[ type: none ]
       |    |    |              |    |    `==[ init ]
       |    |    |              |    |         `==[ RecordExp any ]
       |    |    |              |    |              `==[ Field any ]
       |    |    |              |    |                   `==[ IntExp 0 ]
       |    |    |              |    `==[ VarDec i escape=true ]
       |    |    |              |         |==[ type: none ]
       |    |    |              |         `==[ init ]
       |    |    |              |              `==[ CallExp readint ]
       |    |    |              |                   `==[ VarExp ]
       |    |    |              |                        `==[ SimpleVar any ]
       |    |    |              `==[ body ]
       |    |    |                   `==[ IfExp ]
       |    |    |                        |==[ test ]
       |    |    |                        |    `==[ VarExp ]
       |    |    |                        |         `==[ FieldVar any ]
       |    |    |                        |              `==[ SimpleVar any ]
       |    |    |                        |==[ then ]
       |    |    |                        |    `==[ RecordExp list ]
       |    |    |                        |         |==[ Field first ]
       |    |    |                        |         |    `==[ VarExp ]
       |    |    |                        |         |         `==[ SimpleVar i ]
       |    |    |                        |         `==[ Field rest ]
       |    |    |                        |              `==[ CallExp readlist ]
       |    |    |                        `==[ else ]
       |    |    |                             `==[ NilExp ]
       |    |    |==[ Function merge ]
       |    |    |    |==[ params ]
       |    |    |    |    |==[ Field a : list escape=true ]
       |    |    |    |    `==[ Field b : list escape=true ]
       |    |    |    |==[ result: list ]
       |    |    |    `==[ body ]
       |    |    |         `==[ IfExp ]
       |    |    |              |==[ test ]
       |    |    |              |    `==[ OpExp EqOp ]
       |    |    |              |         |==[ VarExp ]
       |    |    |              |         |    `==[ SimpleVar a ]
       |    |    |              |         `==[ NilExp ]
       |    |    |              |==[ then ]
       |    |    |              |    `==[ VarExp ]
       |    |    |              |         `==[ SimpleVar b ]
       |    |    |              `==[ else ]
       |    |    |                   `==[ IfExp ]
       |    |    |                        |==[ test ]
       |    |    |                        |    `==[ OpExp EqOp ]
       |    |    |                        |         |==[ VarExp ]
       |    |    |                        |         |    `==[ SimpleVar b ]
       |    |    |                        |         `==[ NilExp ]
       |    |    |                        |==[ then ]
       |    |    |                        |    `==[ VarExp ]
       |    |    |                        |         `==[ SimpleVar a ]
       |    |    |                        `==[ else ]
       |    |    |                             `==[ IfExp ]
       |    |    |                                  |==[ test ]
       |    |    |                                  |    `==[ OpExp LtOp ]
       |    |    |                                  |         |==[ VarExp ]
       |    |    |                                  |         |    `==[ FieldVar first ]
       |    |    |                                  |         |         `==[ SimpleVar a ]
       |    |    |                                  |         `==[ VarExp ]
       |    |    |                                  |              `==[ FieldVar first ]
       |    |    |                                  |                   `==[ SimpleVar b ]
       |    |    |                                  |==[ then ]
       |    |    |                                  |    `==[ RecordExp list ]
       |    |    |                                  |         |==[ Field first ]
       |    |    |                                  |         |    `==[ VarExp ]
       |    |    |                                  |         |         `==[ FieldVar first ]
       |    |    |                                  |         |              `==[ SimpleVar a ]
       |    |    |                                  |         `==[ Field rest ]
       |    |    |                                  |              `==[ CallExp merge ]
       |    |    |                                  |                   |==[ VarExp ]
       |    |    |                                  |                   |    `==[ FieldVar rest ]
       |    |    |                                  |                   |         `==[ SimpleVar a ]
       |    |    |                                  |                   `==[ VarExp ]
       |    |    |                                  |                        `==[ SimpleVar b ]
       |    |    |                                  `==[ else ]
       |    |    |                                       `==[ RecordExp list ]
       |    |    |                                            |==[ Field first ]
       |    |    |                                            |    `==[ VarExp ]
       |    |    |                                            |         `==[ FieldVar first ]
       |    |    |                                            |              `==[ SimpleVar b ]
       |    |    |                                            `==[ Field rest ]
       |    |    |                                                 `==[ CallExp merge ]
       |    |    |                                                      |==[ VarExp ]
       |    |    |                                                      |    `==[ SimpleVar a ]
       |    |    |                                                      `==[ VarExp ]
       |    |    |                                                           `==[ FieldVar rest ]
       |    |    |                                                                `==[ SimpleVar b ]
       |    |    |==[ Function printint ]
       |    |    |    |==[ params ]
       |    |    |    |    `==[ Field i : int escape=true ]
       |    |    |    |==[ result: none ]
       |    |    |    `==[ body ]
       |    |    |         `==[ LetExp ]
       |    |    |              |==[ decs ]
       |    |    |              |    `==[ FunctionDec ]
       |    |    |              |         `==[ Function f ]
       |    |    |              |              |==[ params ]
       |    |    |              |              |    `==[ Field i : int escape=true ]
       |    |    |              |              |==[ result: none ]
       |    |    |              |              `==[ body ]
       |    |    |              |                   `==[ IfExp ]
       |    |    |              |                        |==[ test ]
       |    |    |              |                        |    `==[ OpExp GtOp ]
       |    |    |              |                        |         |==[ VarExp ]
       |    |    |              |                        |         |    `==[ SimpleVar i ]
       |    |    |              |                        |         `==[ IntExp 0 ]
       |    |    |              |                        |==[ then ]
       |    |    |              |                        |    `==[ SeqExp ]
       |    |    |              |                        |         |==[ CallExp f ]
       |    |    |              |                        |         |    `==[ OpExp DivideOp ]
       |    |    |              |                        |         |         |==[ VarExp ]
       |    |    |              |                        |         |         |    `==[ SimpleVar i ]
       |    |    |              |                        |         |         `==[ IntExp 10 ]
       |    |    |              |                        |         `==[ CallExp print ]
       |    |    |              |                        |              `==[ CallExp chr ]
       |    |    |              |                        |                   `==[ OpExp PlusOp ]
       |    |    |              |                        |                        |==[ OpExp MinusOp ]
       |    |    |              |                        |                        |    |==[ VarExp ]
       |    |    |              |                        |                        |    |    `==[ SimpleVar i ]
       |    |    |              |                        |                        |    `==[ OpExp TimesOp ]
       |    |    |              |                        |                        |         |==[ OpExp DivideOp ]
       |    |    |              |                        |                        |         |    |==[ VarExp ]
       |    |    |              |                        |                        |         |    |    `==[ SimpleVar i ]
       |    |    |              |                        |                        |         |    `==[ IntExp 10 ]
       |    |    |              |                        |                        |         `==[ IntExp 10 ]
       |    |    |              |                        |                        `==[ CallExp ord ]
       |    |    |              |                        |                             `==[ StringExp "0" ]
       |    |    |              |                        `==[ else: none ]
       |    |    |              `==[ body ]
       |    |    |                   `==[ IfExp ]
       |    |    |                        |==[ test ]
       |    |    |                        |    `==[ OpExp LtOp ]
       |    |    |                        |         |==[ VarExp ]
       |    |    |                        |         |    `==[ SimpleVar i ]
       |    |    |                        |         `==[ IntExp 0 ]
       |    |    |                        |==[ then ]
       |    |    |                        |    `==[ SeqExp ]
       |    |    |                        |         |==[ CallExp print ]
       |    |    |                        |         |    `==[ StringExp "-" ]
       |    |    |                        |         `==[ CallExp f ]
       |    |    |                        |              `==[ OpExp MinusOp ]
       |    |    |                        |                   |==[ IntExp 0 ]
       |    |    |                        |                   `==[ VarExp ]
       |    |    |                        |                        `==[ SimpleVar i ]
       |    |    |                        `==[ else ]
       |    |    |                             `==[ IfExp ]
       |    |    |                                  |==[ test ]
       |    |    |                                  |    `==[ OpExp GtOp ]
       |    |    |                                  |         |==[ VarExp ]
       |    |    |                                  |         |    `==[ SimpleVar i ]
       |    |    |                                  |         `==[ IntExp 0 ]
       |    |    |                                  |==[ then ]
       |    |    |                                  |    `==[ CallExp f ]
       |    |    |                                  |         `==[ VarExp ]
       |    |    |                                  |              `==[ SimpleVar i ]
       |    |    |                                  `==[ else ]
       |    |    |                                       `==[ CallExp print ]
       |    |    |                                            `==[ StringExp "0" ]
       |    |    `==[ Function printlist ]
       |    |         |==[ params ]
       |    |         |    `==[ Field l : list escape=true ]
       |    |         |==[ result: none ]
       |    |         `==[ body ]
       |    |              `==[ IfExp ]
       |    |                   |==[ test ]
       |    |                   |    `==[ OpExp EqOp ]
       |    |                   |         |==[ VarExp ]
       |    |                   |         |    `==[ SimpleVar l ]
       |    |                   |         `==[ NilExp ]
       |    |                   |==[ then ]
       |    |                   |    `==[ CallExp print ]
       |    |                   |         `==[ StringExp "\n" ]
       |    |                   `==[ else ]
       |    |                        `==[ SeqExp ]
       |    |                             |==[ CallExp printint ]
       |    |                             |    `==[ VarExp ]
       |    |                             |         `==[ FieldVar first ]
       |    |                             |              `==[ SimpleVar l ]
       |    |                             |==[ CallExp print ]
       |    |                             |    `==[ StringExp " " ]
       |    |                             `==[ CallExp printlist ]
       |    |                                  `==[ VarExp ]
       |    |                                       `==[ FieldVar rest ]
       |    |                                            `==[ SimpleVar l ]
       |    |==[ VarDec list1 escape=true ]
       |    |    |==[ type: none ]
       |    |    `==[ init ]
       |    |         `==[ CallExp readlist ]
       |    `==[ VarDec list2 escape=true ]
       |         |==[ type: none ]
       |         `==[ init ]
       |              `==[ SeqExp ]
       |                   |==[ AssignExp ]
       |                   |    |==[ var ]
       |                   |    |    `==[ SimpleVar buffer ]
       |                   |    `==[ exp ]
       |                   |         `==[ CallExp getchar ]
       |                   `==[ CallExp readlist ]
       `==[ body ]
            `==[ CallExp printlist ]
                 `==[ CallExp merge ]
                      |==[ VarExp ]
                      |    `==[ SimpleVar list1 ]
                      `==[ VarExp ]
                           `==[ SimpleVar list2 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/queens.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ VarDec N escape=true ]
       |    |    |==[ type: none ]
       |    |    `==[ init ]
       |    |         `==[ IntExp 8 ]
       |    |==[ TypeDec ]
       |    |    `==[ Type intArray ]
       |    |         `==[ ArrayTy int ]
       |    |==[ VarDec row escape=true ]
       |    |    |==[ type: none ]
       |    |    `==[ init ]
       |    |         `==[ ArrayExp intArray ]
       |    |              |==[ size ]
       |    |              |    `==[ VarExp ]
       |    |              |         `==[ SimpleVar N ]
       |    |              `==[ init ]
       |    |                   `==[ IntExp 0 ]
       |    |==[ VarDec col escape=true ]
       |    |    |==[ type: none ]
       |    |    `==[ init ]
       |    |         `==[ ArrayExp intArray ]
       |    |              |==[ size ]
       |    |              |    `==[ VarExp ]
       |    |              |         `==[ SimpleVar N ]
       |    |              `==[ init ]
       |    |                   `==[ IntExp 0 ]
       |    |==[ VarDec diag1 escape=true ]
       |    |    |==[ type: none ]
       |    |    `==[ init ]
       |    |         `==[ ArrayExp intArray ]
       |    |              |==[ size ]
       |    |              |    `==[ OpExp MinusOp ]
       |    |              |         |==[ OpExp PlusOp ]
       |    |              |         |    |==[ VarExp ]
       |    |              |         |    |    `==[ SimpleVar N ]
       |    |              |         |    `==[ VarExp ]
       |    |              |         |         `==[ SimpleVar N ]
       |    |              |         `==[ IntExp 1 ]
       |    |              `==[ init ]
       |    |                   `==[ IntExp 0 ]
       |    |==[ VarDec diag2 escape=true ]
       |    |    |==[ type: none ]
       |    |    `==[ init ]
       |    |         `==[ ArrayExp intArray ]
       |    |              |==[ size ]
       |    |              |    `==[ OpExp MinusOp ]
       |    |              |         |==[ OpExp PlusOp ]
       |    |              |         |    |==[ VarExp ]
       |    |              |         |    |    `==[ SimpleVar N ]
       |    |              |         |    `==[ VarExp ]
       |    |              |         |         `==[ SimpleVar N ]
       |    |              |         `==[ IntExp 1 ]
       |    |              `==[ init ]
       |    |                   `==[ IntExp 0 ]
       |    `==[ FunctionDec ]
       |         |==[ Function printboard ]
       |         |    |==[ params ]
       |         |    |==[ result: none ]
       |         |    `==[ body ]
       |         |         `==[ SeqExp ]
       |         |              |==[ ForExp i escape=true ]
       |         |              |    |==[ lo ]
       |         |              |    |    `==[ IntExp 0 ]
       |         |              |    |==[ hi ]
       |         |              |    |    `==[ OpExp MinusOp ]
       |         |              |    |         |==[ VarExp ]
       |         |              |    |         |    `==[ SimpleVar N ]
       |         |              |    |         `==[ IntExp 1 ]
       |         |              |    `==[ body ]
       |         |              |         `==[ SeqExp ]
       |         |              |              |==[ ForExp j escape=true ]
       |         |              |              |    |==[ lo ]
       |         |              |              |    |    `==[ IntExp 0 ]
       |         |              |              |    |==[ hi ]
       |         |              |              |    |    `==[ OpExp MinusOp ]
       |         |              |              |    |         |==[ VarExp ]
       |         |              |              |    |         |    `==[ SimpleVar N ]
       |         |              |              |    |         `==[ IntExp 1 ]
       |         |              |              |    `==[ body ]
       |         |              |              |         `==[ CallExp print ]
       |         |              |              |              `==[ IfExp ]
       |         |              |              |                   |==[ test ]
       |         |              |              |                   |    `==[ OpExp EqOp ]
       |         |              |              |                   |         |==[ VarExp ]
       |         |              |              |                   |         |    `==[ SubscriptVar ]
       |         |              |              |                   |         |         |==[ var ]
       |         |              |              |                   |         |         |    `==[ SimpleVar col ]
       |         |              |              |                   |         |         `==[ index ]
       |         |              |              |                   |         |              `==[ VarExp ]
       |         |              |              |                   |         |                   `==[ SimpleVar i ]
       |         |              |              |                   |         `==[ VarExp ]
       |         |              |              |                   |              `==[ SimpleVar j ]
       |         |              |              |                   |==[ then ]
       |         |              |              |                   |    `==[ StringExp " O" ]
       |         |              |              |                   `==[ else ]
       |         |              |              |                        `==[ StringExp " ." ]
       |         |              |              `==[ CallExp print ]
       |         |              |                   `==[ StringExp "\n" ]
       |         |              `==[ CallExp print ]
       |         |                   `==[ StringExp "\n" ]
       |         `==[ Function try ]
       |              |==[ params ]
       |              |    `==[ Field c : int escape=true ]
       |              |==[ result: none ]
       |              `==[ body ]
       |                   `==[ IfExp ]
       |                        |==[ test ]
       |                        |    `==[ OpExp EqOp ]
       |                        |         |==[ VarExp ]
       |                        |         |    `==[ SimpleVar c ]
       |                        |         `==[ VarExp ]
       |                        |              `==[ SimpleVar N ]
       |                        |==[ then ]
       |                        |    `==[ CallExp printboard ]
       |                        `==[ else ]
       |                             `==[ ForExp r escape=true ]
       |                                  |==[ lo ]
       |                                  |    `==[ IntExp 0 ]
       |                                  |==[ hi ]
       |                                  |    `==[ OpExp MinusOp ]
       |                                  |         |==[ VarExp ]
       |                                  |         |    `==[ SimpleVar N ]
       |                                  |         `==[ IntExp 1 ]
       |                                  `==[ body ]
       |                                       `==[ IfExp ]
       |                                            |==[ test ]
       |                                            |    `==[ IfExp ]
       |                                            |         |==[ test ]
       |                                            |         |    `==[ IfExp ]
       |                                            |         |         |==[ test ]
       |                                            |         |         |    `==[ OpExp EqOp ]
       |                                            |         |         |         |==[ VarExp ]
       |                                            |         |         |         |    `==[ SubscriptVar ]
       |                                            |         |         |         |         |==[ var ]
       |                                            |         |         |         |         |    `==[ SimpleVar row ]
       |                                            |         |         |         |         `==[ index ]
       |                                            |         |         |         |              `==[ VarExp ]
       |                                            |         |         |         |                   `==[ SimpleVar r ]
       |                                            |         |         |         `==[ IntExp 0 ]
       |                                            |         |         |==[ then ]
       |                                            |         |         |    `==[ OpExp EqOp ]
       |                                            |         |         |         |==[ VarExp ]
       |                                            |         |         |         |    `==[ SubscriptVar ]
       |                                            |         |         |         |         |==[ var ]
       |                                            |         |         |         |         |    `==[ SimpleVar diag1 ]
       |                                            |         |         |         |         `==[ index ]
       |                                            |         |         |         |              `==[ OpExp PlusOp ]
       |                                            |         |         |         |                   |==[ VarExp ]
       |                                            |         |         |         |                   |    `==[ SimpleVar r ]
       |                                            |         |         |         |                   `==[ VarExp ]
       |                                            |         |         |         |                        `==[ SimpleVar c ]
       |                                            |         |         |         `==[ IntExp 0 ]
       |                                            |         |         `==[ else ]
       |                                            |         |              `==[ IntExp 0 ]
       |                                            |         |==[ then ]
       |                                            |         |    `==[ OpExp EqOp ]
       |                                            |         |         |==[ VarExp ]
       |                                            |         |         |    `==[ SubscriptVar ]
       |                                            |         |         |         |==[ var ]
       |                                            |         |         |         |    `==[ SimpleVar diag2 ]
       |                                            |         |         |         `==[ index ]
       |                                            |         |         |              `==[ OpExp MinusOp ]
       |                                            |         |         |                   |==[ OpExp PlusOp ]
       |                                            |         |         |                   |    |==[ VarExp ]
       |                                            |         |         |                   |    |    `==[ SimpleVar r ]
       |                                            |         |         |                   |    `==[ IntExp 7 ]
       |                                            |         |         |                   `==[ VarExp ]
       |                                            |         |         |                        `==[ SimpleVar c ]
       |                                            |         |         `==[ IntExp 0 ]
       |                                            |         `==[ else ]
       |                                            |              `==[ IntExp 0 ]
       |                                            |==[ then ]
       |                                            |    `==[ SeqExp ]
       |                                            |         |==[ AssignExp ]
       |                                            |         |    |==[ var ]
       |                                            |         |    |    `==[ SubscriptVar ]
       |                                            |         |    |         |==[ var ]
       |                                            |         |    |         |    `==[ SimpleVar row ]
       |                                            |         |    |         `==[ index ]
       |                                            |         |    |              `==[ VarExp ]
       |                                            |         |    |                   `==[ SimpleVar r ]
       |                                            |         |    `==[ exp ]
       |                                            |         |         `==[ IntExp 1 ]
       |                                            |         |==[ AssignExp ]
       |                                            |         |    |==[ var ]
       |                                            |         |    |    `==[ SubscriptVar ]
       |                                            |         |    |         |==[ var ]
       |                                            |         |    |         |    `==[ SimpleVar diag1 ]
       |                                            |         |    |         `==[ index ]
       |                                            |         |    |              `==[ OpExp PlusOp ]
       |                                            |         |    |                   |==[ VarExp ]
       |                                            |         |    |                   |    `==[ SimpleVar r ]
       |                                            |         |    |                   `==[ VarExp ]
       |                                            |         |    |                        `==[ SimpleVar c ]
       |                                            |         |    `==[ exp ]
       |                                            |         |         `==[ IntExp 1 ]
       |                                            |         |==[ AssignExp ]
       |                                            |         |    |==[ var ]
       |                                            |         |    |    `==[ SubscriptVar ]
       |                                            |         |    |         |==[ var ]
       |                                            |         |    |         |    `==[ SimpleVar diag2 ]
       |                                            |         |    |         `==[ index ]
       |                                            |         |    |              `==[ OpExp MinusOp ]
       |                                            |         |    |                   |==[ OpExp PlusOp ]
       |                                            |         |    |                   |    |==[ VarExp ]
       |                                            |         |    |                   |    |    `==[ SimpleVar r ]
       |                                            |         |    |                   |    `==[ IntExp 7 ]
       |                                            |         |    |                   `==[ VarExp ]
       |                                            |         |    |                        `==[ SimpleVar c ]
       |                                            |         |    `==[ exp ]
       |                                            |         |         `==[ IntExp 1 ]
       |                                            |         |==[ AssignExp ]
       |                                            |         |    |==[ var ]
       |                                            |         |    |    `==[ SubscriptVar ]
       |                                            |         |    |         |==[ var ]
       |                                            |         |    |         |    `==[ SimpleVar col ]
       |                                            |         |    |         `==[ index ]
       |                                            |         |    |              `==[ VarExp ]
       |                                            |         |    |                   `==[ SimpleVar c ]
       |                                            |         |    `==[ exp ]
       |                                            |         |         `==[ VarExp ]
       |                                            |         |              `==[ SimpleVar r ]
       |                                            |         |==[ CallExp try ]
       |                                            |         |    `==[ OpExp PlusOp ]
       |                                            |         |         |==[ VarExp ]
       |                                            |         |         |    `==[ SimpleVar c ]
       |                                            |         |         `==[ IntExp 1 ]
       |                                            |         |==[ AssignExp ]
       |                                            |         |    |==[ var ]
       |                                            |         |    |    `==[ SubscriptVar ]
       |                                            |         |    |         |==[ var ]
       |                                            |         |    |         |    `==[ SimpleVar row ]
       |                                            |         |    |         `==[ index ]
       |                                            |         |    |              `==[ VarExp ]
       |                                            |         |    |                   `==[ SimpleVar r ]
       |                                            |         |    `==[ exp ]
       |                                            |         |         `==[ IntExp 0 ]
       |                                            |         |==[ AssignExp ]
       |                                            |         |    |==[ var ]
       |                                            |         |    |    `==[ SubscriptVar ]
       |                                            |         |    |         |==[ var ]
       |                                            |         |    |         |    `==[ SimpleVar diag1 ]
       |                                            |         |    |         `==[ index ]
       |                                            |         |    |              `==[ OpExp PlusOp ]
       |                                            |         |    |                   |==[ VarExp ]
       |                                            |         |    |                   |    `==[ SimpleVar r ]
       |                                            |         |    |                   `==[ VarExp ]
       |                                            |         |    |                        `==[ SimpleVar c ]
       |                                            |         |    `==[ exp ]
       |                                            |         |         `==[ IntExp 0 ]
       |                                            |         `==[ AssignExp ]
       |                                            |              |==[ var ]
       |                                            |              |    `==[ SubscriptVar ]
       |                                            |              |         |==[ var ]
       |                                            |              |         |    `==[ SimpleVar diag2 ]
       |                                            |              |         `==[ index ]
       |                                            |              |              `==[ OpExp MinusOp ]
       |                                            |              |                   |==[ OpExp PlusOp ]
       |                                            |              |                   |    |==[ VarExp ]
       |                                            |              |                   |    |    `==[ SimpleVar r ]
       |                                            |              |                   |    `==[ IntExp 7 ]
       |                                            |              |                   `==[ VarExp ]
       |                                            |              |                        `==[ SimpleVar c ]
       |                                            |              `==[ exp ]
       |                                            |                   `==[ IntExp 0 ]
       |                                            `==[ else: none ]
       `==[ body ]
            `==[ CallExp try ]
                 `==[ IntExp 0 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test1.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    `==[ Type arrtype ]
       |    |         `==[ ArrayTy int ]
       |    `==[ VarDec arr1 escape=true ]
       |         |==[ type: arrtype ]
       |         `==[ init ]
       |              `==[ ArrayExp arrtype ]
       |                   |==[ size ]
       |                   |    `==[ IntExp 10 ]
       |                   `==[ init ]
       |                        `==[ IntExp 0 ]
       `==[ body ]
            `==[ VarExp ]
                 `==[ SimpleVar arr1 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test10.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ WhileExp ]
       |==[ test ]
       |    `==[ OpExp GtOp ]
       |         |==[ IntExp 10 ]
       |         `==[ IntExp 5 ]
       `==[ body ]
            `==[ OpExp PlusOp ]
                 |==[ IntExp 5 ]
                 `==[ IntExp 6 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test11.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ ForExp i escape=true ]
       |==[ lo ]
       |    `==[ IntExp 10 ]
       |==[ hi ]
       |    `==[ StringExp " " ]
       `==[ body ]
            `==[ AssignExp ]
                 |==[ var ]
                 |    `==[ SimpleVar i ]
                 `==[ exp ]
                      `==[ OpExp MinusOp ]
                           |==[ VarExp ]
                           |    `==[ SimpleVar i ]
                           `==[ IntExp 1 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test12.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ VarDec a escape=true ]
       |         |==[ type: none ]
       |         `==[ init ]
       |              `==[ IntExp 0 ]
       `==[ body ]
            `==[ ForExp i escape=true ]
                 |==[ lo ]
                 |    `==[ IntExp 0 ]
                 |==[ hi ]
                 |    `==[ IntExp 100 ]
                 `==[ body ]
                      `==[ SeqExp ]
                           |==[ AssignExp ]
                           |    |==[ var ]
                           |    |    `==[ SimpleVar a ]
                           |    `==[ exp ]
                           |         `==[ OpExp PlusOp ]
                           |              |==[ VarExp ]
                           |              |    `==[ SimpleVar a ]
                           |              `==[ IntExp 1 ]
                           `==[ SeqExp ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test13.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ OpExp GtOp ]
       |==[ IntExp 3 ]
       `==[ StringExp "df" ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test14.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    |==[ Type arrtype ]
       |    |    |    `==[ ArrayTy int ]
       |    |    `==[ Type rectype ]
       |    |         `==[ RecordTy ]
       |    |              |==[ Field name : string escape=true ]
       |    |              `==[ Field id : int escape=true ]
       |    |==[ VarDec rec escape=true ]
       |    |    |==[ type: none ]
       |    |    `==[ init ]
       |    |         `==[ RecordExp rectype ]
       |    |              |==[ Field name ]
       |    |              |    `==[ StringExp "aname" ]
       |    |              `==[ Field id ]
       |    |                   `==[ IntExp 0 ]
       |    `==[ VarDec arr escape=true ]
       |         |==[ type: none ]
       |         `==[ init ]
       |              `==[ ArrayExp arrtype ]
       |                   |==[ size ]
       |                   |    `==[ IntExp 3 ]
       |                   `==[ init ]
       |                        `==[ IntExp 0 ]
       `==[ body ]
            `==[ IfExp ]
                 |==[ test ]
                 |    `==[ OpExp NeqOp ]
                 |         |==[ VarExp ]
                 |         |    `==[ SimpleVar rec ]
                 |         `==[ VarExp ]
                 |              `==[ SimpleVar arr ]
                 |==[ then ]
                 |    `==[ IntExp 3 ]
                 `==[ else ]
                      `==[ IntExp 4 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test15.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ IfExp ]
       |==[ test ]
       |    `==[ IntExp 20 ]
       |==[ then ]
       |    `==[ IntExp 3 ]
       `==[ else: none ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test16.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ TypeDec ]
       |         |==[ Type a ]
       |         |    `==[ NameTy c ]
       |         |==[ Type b ]
       |         |    `==[ NameTy a ]
       |         |==[ Type c ]
       |         |    `==[ NameTy d ]
       |         `==[ Type d ]
       |              `==[ NameTy a ]
       `==[ body ]
            `==[ StringExp "" ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test17.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    `==[ Type tree ]
       |    |         `==[ RecordTy ]
       |    |              |==[ Field key : int escape=true ]
       |    |              `==[ Field children : treelist escape=true ]
       |    |==[ VarDec d escape=true ]
       |    |    |==[ type: int ]
       |    |    `==[ init ]
       |    |         `==[ IntExp 0 ]
       |    `==[ TypeDec ]
       |         `==[ Type treelist ]
       |              `==[ RecordTy ]
       |                   |==[ Field hd : tree escape=true ]
       |                   `==[ Field tl : treelist escape=true ]
       `==[ body ]
            `==[ VarExp ]
                 `==[ SimpleVar d ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test18.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ FunctionDec ]
       |    |    `==[ Function do_nothing1 ]
       |    |         |==[ params ]
       |    |         |    |==[ Field a : int escape=true ]
       |    |         |    `==[ Field b : string escape=true ]
       |    |         |==[ result: int ]
       |    |         `==[ body ]
       |    |              `==[ SeqExp ]
       |    |                   |==[ CallExp do_nothing2 ]
       |    |                   |    `==[ OpExp PlusOp ]
       |    |                   |         |==[ VarExp ]
       |    |                   |         |    `==[ SimpleVar a ]
       |    |                   |         `==[ IntExp 1 ]
       |    |                   `==[ IntExp 0 ]
       |    |==[ VarDec d escape=true ]
       |    |    |==[ type: none ]
       |    |    `==[ init ]
       |    |         `==[ IntExp 0 ]
       |    `==[ FunctionDec ]
       |         `==[ Function do_nothing2 ]
       |              |==[ params ]
       |              |    `==[ Field d : int escape=true ]
       |              |==[ result: string ]
       |              `==[ body ]
       |                   `==[ SeqExp ]
       |                        |==[ CallExp do_nothing1 ]
       |                        |    |==[ VarExp ]
       |                        |    |    `==[ SimpleVar d ]
       |                        |    `==[ StringExp "str" ]
       |                        `==[ StringExp " " ]
       `==[ body ]
            `==[ CallExp do_nothing1 ]
                 |==[ IntExp 0 ]
                 `==[ StringExp "str2" ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test19.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ FunctionDec ]
       |         |==[ Function do_nothing1 ]
       |         |    |==[ params ]
       |         |    |    |==[ Field a : int escape=true ]
       |         |    |    `==[ Field b : string escape=true ]
       |         |    |==[ result: int ]
       |         |    `==[ body ]
       |         |         `==[ SeqExp ]
       |         |              |==[ CallExp do_nothing2 ]
       |         |              |    `==[ OpExp PlusOp ]
       |         |              |         |==[ VarExp ]
       |         |              |         |    `==[ SimpleVar a ]
       |         |              |         `==[ IntExp 1 ]
       |         |              `==[ IntExp 0 ]
       |         `==[ Function do_nothing2 ]
       |              |==[ params ]
       |              |    `==[ Field d : int escape=true ]
       |              |==[ result: string ]
       |              `==[ body ]
       |                   `==[ SeqExp ]
       |                        |==[ CallExp do_nothing1 ]
       |                        |    |==[ VarExp ]
       |                        |    |    `==[ SimpleVar a ]
       |                        |    `==[ StringExp "str" ]
       |                        `==[ StringExp " " ]
       `==[ body ]
            `==[ CallExp do_nothing1 ]
                 |==[ IntExp 0 ]
                 `==[ StringExp "str2" ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test2.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    |==[ Type myint ]
       |    |    |    `==[ NameTy int ]
       |    |    `==[ Type arrtype ]
       |    |         `==[ ArrayTy myint ]
       |    `==[ VarDec arr1 escape=true ]
       |         |==[ type: arrtype ]
       |         `==[ init ]
       |              `==[ ArrayExp arrtype ]
       |                   |==[ size ]
       |                   |    `==[ IntExp 10 ]
       |                   `==[ init ]
       |                        `==[ IntExp 0 ]
       `==[ body ]
            `==[ VarExp ]
                 `==[ SimpleVar arr1 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test20.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ WhileExp ]
       |==[ test ]
       |    `==[ OpExp GtOp ]
       |         |==[ IntExp 10 ]
       |         `==[ IntExp 5 ]
       `==[ body ]
            `==[ SeqExp ]
                 |==[ OpExp PlusOp ]
                 |    |==[ VarExp ]
                 |    |    `==[ SimpleVar i ]
                 |    `==[ IntExp 1 ]
                 `==[ SeqExp ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test21.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ FunctionDec ]
       |         `==[ Function nfactor ]
       |              |==[ params ]
       |              |    `==[ Field n : int escape=true ]
       |              |==[ result: none ]
       |              `==[ body ]
       |                   `==[ IfExp ]
       |                        |==[ test ]
       |                        |    `==[ OpExp EqOp ]
       |                        |         |==[ VarExp ]
       |                        |         |    `==[ SimpleVar n ]
       |                        |         `==[ IntExp 0 ]
       |                        |==[ then ]
       |                        |    `==[ IntExp 1 ]
       |                        `==[ else ]
       |                             `==[ OpExp TimesOp ]
       |                                  |==[ VarExp ]
       |                                  |    `==[ SimpleVar n ]
       |                                  `==[ CallExp nfactor ]
       |                                       `==[ OpExp MinusOp ]
       |                                            |==[ VarExp ]
       |                                            |    `==[ SimpleVar n ]
       |                                            `==[ IntExp 1 ]
       `==[ body ]
            `==[ CallExp nfactor ]
                 `==[ IntExp 10 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test22.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    `==[ Type rectype ]
       |    |         `==[ RecordTy ]
       |    |              |==[ Field name : string escape=true ]
       |    |              `==[ Field id : int escape=true ]
       |    `==[ VarDec rec1 escape=true ]
       |         |==[ type: none ]
       |         `==[ init ]
       |              `==[ RecordExp rectype ]
       |                   |==[ Field name ]
       |                   |    `==[ StringExp "Name" ]
       |                   `==[ Field id ]
       |                        `==[ IntExp 0 ]
       `==[ body ]
            `==[ AssignExp ]
                 |==[ var ]
                 |    `==[ FieldVar nam ]
                 |         `==[ SimpleVar rec1 ]
                 `==[ exp ]
                      `==[ StringExp "asd" ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test23.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    `==[ Type rectype ]
       |    |         `==[ RecordTy ]
       |    |              |==[ Field name : string escape=true ]
       |    |              `==[ Field id : int escape=true ]
       |    `==[ VarDec rec1 escape=true ]
       |         |==[ type: none ]
       |         `==[ init ]
       |              `==[ RecordExp rectype ]
       |                   |==[ Field name ]
       |                   |    `==[ StringExp "aname" ]
       |                   `==[ Field id ]
       |                        `==[ IntExp 0 ]
       `==[ body ]
            `==[ SeqExp ]
                 |==[ AssignExp ]
                 |    |==[ var ]
                 |    |    `==[ FieldVar name ]
                 |    |         `==[ SimpleVar rec1 ]
                 |    `==[ exp ]
                 |         `==[ IntExp 3 ]
                 `==[ AssignExp ]
                      |==[ var ]
                      |    `==[ FieldVar id ]
                      |         `==[ SimpleVar rec1 ]
                      `==[ exp ]
                           `==[ StringExp "" ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test24.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ VarDec d escape=true ]
       |         |==[ type: none ]
       |         `==[ init ]
       |              `==[ IntExp 0 ]
       `==[ body ]
            `==[ VarExp ]
                 `==[ SubscriptVar ]
                      |==[ var ]
                      |    `==[ SimpleVar d ]
                      `==[ index ]
                           `==[ IntExp 3 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test25.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ VarDec d escape=true ]
       |         |==[ type: none ]
       |         `==[ init ]
       |              `==[ IntExp 0 ]
       `==[ body ]
            `==[ VarExp ]
                 `==[ FieldVar f ]
                      `==[ SimpleVar d ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test26.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ OpExp PlusOp ]
       |==[ IntExp 3 ]
       `==[ StringExp "var" ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test27.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ VarDec a escape=true ]
       |    |    |==[ type: none ]
       |    |    `==[ init ]
       |    |         `==[ IntExp 0 ]
       |    `==[ FunctionDec ]
       |         `==[ Function g ]
       |              |==[ params ]
       |              |    `==[ Field a : int escape=true ]
       |              |==[ result: int ]
       |              `==[ body ]
       |                   `==[ VarExp ]
       |                        `==[ SimpleVar a ]
       `==[ body ]
            `==[ CallExp g ]
                 `==[ IntExp 2 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test28.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    |==[ Type rectype1 ]
       |    |    |    `==[ RecordTy ]
       |    |    |         |==[ Field name : string escape=true ]
       |    |    |         `==[ Field id : int escape=true ]
       |    |    `==[ Type rectype2 ]
       |    |         `==[ RecordTy ]
       |    |              |==[ Field name : string escape=true ]
       |    |              `==[ Field id : int escape=true ]
       |    `==[ VarDec rec1 escape=true ]
       |         |==[ type: rectype1 ]
       |         `==[ init ]
       |              `==[ RecordExp rectype2 ]
       |                   |==[ Field name ]
       |                   |    `==[ StringExp "Name" ]
       |                   `==[ Field id ]
       |                        `==[ IntExp 0 ]
       `==[ body ]
            `==[ VarExp ]
                 `==[ SimpleVar rec1 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test29.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    |==[ Type arrtype1 ]
       |    |    |    `==[ ArrayTy int ]
       |    |    `==[ Type arrtype2 ]
       |    |         `==[ ArrayTy int ]
       |    `==[ VarDec arr1 escape=true ]
       |         |==[ type: arrtype1 ]
       |         `==[ init ]
       |              `==[ ArrayExp arrtype2 ]
       |                   |==[ size ]
       |                   |    `==[ IntExp 10 ]
       |                   `==[ init ]
       |                        `==[ IntExp 0 ]
       `==[ body ]
            `==[ VarExp ]
                 `==[ SimpleVar arr1 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test3.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    `==[ Type rectype ]
       |    |         `==[ RecordTy ]
       |    |              |==[ Field name : string escape=true ]
       |    |              `==[ Field age : int escape=true ]
       |    `==[ VarDec rec1 escape=true ]
       |         |==[ type: rectype ]
       |         `==[ init ]
       |              `==[ RecordExp rectype ]
       |                   |==[ Field name ]
       |                   |    `==[ StringExp "Nobody" ]
       |                   `==[ Field age ]
       |                        `==[ IntExp 1000 ]
       `==[ body ]
            `==[ SeqExp ]
                 |==[ AssignExp ]
                 |    |==[ var ]
                 |    |    `==[ FieldVar name ]
                 |    |         `==[ SimpleVar rec1 ]
                 |    `==[ exp ]
                 |         `==[ StringExp "Somebody" ]
                 `==[ VarExp ]
                      `==[ SimpleVar rec1 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test30.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    |==[ Type a ]
       |    |    |    `==[ ArrayTy int ]
       |    |    `==[ Type b ]
       |    |         `==[ NameTy a ]
       |    `==[ VarDec arr1 escape=true ]
       |         |==[ type: a ]
       |         `==[ init ]
       |              `==[ ArrayExp b ]
       |                   |==[ size ]
       |                   |    `==[ IntExp 10 ]
       |                   `==[ init ]
       |                        `==[ IntExp 0 ]
       `==[ body ]
            `==[ VarExp ]
                 `==[ SubscriptVar ]
                      |==[ var ]
                      |    `==[ SimpleVar arr1 ]
                      `==[ index ]
                           `==[ IntExp 2 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test31.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ VarDec a escape=true ]
       |         |==[ type: int ]
       |         `==[ init ]
       |              `==[ StringExp " " ]
       `==[ body ]
            `==[ VarExp ]
                 `==[ SimpleVar a ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test32.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    `==[ Type arrayty ]
       |    |         `==[ ArrayTy int ]
       |    `==[ VarDec a escape=true ]
       |         |==[ type: none ]
       |         `==[ init ]
       |              `==[ ArrayExp arrayty ]
       |                   |==[ size ]
       |                   |    `==[ IntExp 10 ]
       |                   `==[ init ]
       |                        `==[ StringExp " " ]
       `==[ body ]
            `==[ IntExp 0 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test33.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ VarDec a escape=true ]
       |         |==[ type: none ]
       |         `==[ init ]
       |              `==[ RecordExp rectype ]
       `==[ body ]
            `==[ IntExp 0 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test34.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ FunctionDec ]
       |         `==[ Function g ]
       |              |==[ params ]
       |              |    |==[ Field a : int escape=true ]
       |              |    `==[ Field b : string escape=true ]
       |              |==[ result: int ]
       |              `==[ body ]
       |                   `==[ VarExp ]
       |                        `==[ SimpleVar a ]
       `==[ body ]
            `==[ CallExp g ]
                 |==[ StringExp "one" ]
                 `==[ StringExp "two" ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test35.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ FunctionDec ]
       |         `==[ Function g ]
       |              |==[ params ]
       |              |    |==[ Field a : int escape=true ]
       |              |    `==[ Field b : string escape=true ]
       |              |==[ result: int ]
       |              `==[ body ]
       |                   `==[ VarExp ]
       |                        `==[ SimpleVar a ]
       `==[ body ]
            `==[ CallExp g ]
                 `==[ StringExp "one" ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test36.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ FunctionDec ]
       |         `==[ Function g ]
       |              |==[ params ]
       |              |    |==[ Field a : int escape=true ]
       |              |    `==[ Field b : string escape=true ]
       |              |==[ result: int ]
       |              `==[ body ]
       |                   `==[ VarExp ]
       |                        `==[ SimpleVar a ]
       `==[ body ]
            `==[ CallExp g ]
                 |==[ IntExp 3 ]
                 |==[ StringExp "one" ]
                 `==[ IntExp 5 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test37.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ VarDec a escape=true ]
       |    |    |==[ type: none ]
       |    |    `==[ init ]
       |    |         `==[ IntExp 0 ]
       |    `==[ VarDec a escape=true ]
       |         |==[ type: none ]
       |         `==[ init ]
       |              `==[ StringExp " " ]
       `==[ body ]
            `==[ IntExp 0 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test38.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ TypeDec ]
       |         |==[ Type a ]
       |         |    `==[ NameTy int ]
       |         `==[ Type a ]
       |              `==[ NameTy string ]
       `==[ body ]
            `==[ IntExp 0 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test39.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ FunctionDec ]
       |         |==[ Function g ]
       |         |    |==[ params ]
       |         |    |    `==[ Field a : int escape=true ]
       |         |    |==[ result: int ]
       |         |    `==[ body ]
       |         |         `==[ VarExp ]
       |         |              `==[ SimpleVar a ]
       |         `==[ Function g ]
       |              |==[ params ]
       |              |    `==[ Field a : int escape=true ]
       |              |==[ result: int ]
       |              `==[ body ]
       |                   `==[ VarExp ]
       |                        `==[ SimpleVar a ]
       `==[ body ]
            `==[ IntExp 0 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test4.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ FunctionDec ]
       |         `==[ Function nfactor ]
       |              |==[ params ]
       |              |    `==[ Field n : int escape=true ]
       |              |==[ result: int ]
       |              `==[ body ]
       |                   `==[ IfExp ]
       |                        |==[ test ]
       |                        |    `==[ OpExp EqOp ]
       |                        |         |==[ VarExp ]
       |                        |         |    `==[ SimpleVar n ]
       |                        |         `==[ IntExp 0 ]
       |                        |==[ then ]
       |                        |    `==[ IntExp 1 ]
       |                        `==[ else ]
       |                             `==[ OpExp TimesOp ]
       |                                  |==[ VarExp ]
       |                                  |    `==[ SimpleVar n ]
       |                                  `==[ CallExp nfactor ]
       |                                       `==[ OpExp MinusOp ]
       |                                            |==[ VarExp ]
       |                                            |    `==[ SimpleVar n ]
       |                                            `==[ IntExp 1 ]
       `==[ body ]
            `==[ CallExp nfactor ]
                 `==[ IntExp 10 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test40.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ FunctionDec ]
       |         `==[ Function g ]
       |              |==[ params ]
       |              |    `==[ Field a : int escape=true ]
       |              |==[ result: none ]
       |              `==[ body ]
       |                   `==[ VarExp ]
       |                        `==[ SimpleVar a ]
       `==[ body ]
            `==[ CallExp g ]
                 `==[ IntExp 2 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test41.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ TypeDec ]
       |         `==[ Type a ]
       |              `==[ NameTy int ]
       `==[ body ]
            `==[ LetExp ]
                 |==[ decs ]
                 |    `==[ TypeDec ]
                 |         `==[ Type a ]
                 |              `==[ NameTy string ]
                 `==[ body ]
                      `==[ IntExp 0 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test42.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    |==[ Type arrtype1 ]
       |    |    |    `==[ ArrayTy int ]
       |    |    |==[ Type rectype1 ]
       |    |    |    `==[ RecordTy ]
       |    |    |         |==[ Field name : string escape=true ]
       |    |    |         |==[ Field address : string escape=true ]
       |    |    |         |==[ Field id : int escape=true ]
       |    |    |         `==[ Field age : int escape=true ]
       |    |    |==[ Type arrtype2 ]
       |    |    |    `==[ ArrayTy rectype1 ]
       |    |    |==[ Type rectype2 ]
       |    |    |    `==[ RecordTy ]
       |    |    |         |==[ Field name : string escape=true ]
       |    |    |         `==[ Field dates : arrtype1 escape=true ]
       |    |    `==[ Type arrtype3 ]
       |    |         `==[ ArrayTy string ]
       |    |==[ VarDec arr1 escape=true ]
       |    |    |==[ type: none ]
       |    |    `==[ init ]
       |    |         `==[ ArrayExp arrtype1 ]
       |    |              |==[ size ]
       |    |              |    `==[ IntExp 10 ]
       |    |              `==[ init ]
       |    |                   `==[ IntExp 0 ]
       |    |==[ VarDec arr2 escape=true ]
       |    |    |==[ type: none ]
       |    |    `==[ init ]
       |    |         `==[ ArrayExp arrtype2 ]
       |    |              |==[ size ]
       |    |              |    `==[ IntExp 5 ]
       |    |              `==[ init ]
       |    |                   `==[ RecordExp rectype1 ]
       |    |                        |==[ Field name ]
       |    |                        |    `==[ StringExp "aname" ]
       |    |                        |==[ Field address ]
       |    |                        |    `==[ StringExp "somewhere" ]
       |    |                        |==[ Field id ]
       |    |                        |    `==[ IntExp 0 ]
       |    |                        `==[ Field age ]
       |    |                             `==[ IntExp 0 ]
       |    |==[ VarDec arr3 escape=true ]
       |    |    |==[ type: arrtype3 ]
       |    |    `==[ init ]
       |    |         `==[ ArrayExp arrtype3 ]
       |    |              |==[ size ]
       |    |              |    `==[ IntExp 100 ]
       |    |              `==[ init ]
       |    |                   `==[ StringExp "" ]
       |    |==[ VarDec rec1 escape=true ]
       |    |    |==[ type: none ]
       |    |    `==[ init ]
       |    |         `==[ RecordExp rectype1 ]
       |    |              |==[ Field name ]
       |    |              |    `==[ StringExp "Kapoios" ]
       |    |              |==[ Field address ]
       |    |              |    `==[ StringExp "Kapou" ]
       |    |              |==[ Field id ]
       |    |              |    `==[ IntExp 2432 ]
       |    |              `==[ Field age ]
       |    |                   `==[ IntExp 44 ]
       |    `==[ VarDec rec2 escape=true ]
       |         |==[ type: none ]
       |         `==[ init ]
       |              `==[ RecordExp rectype2 ]
       |                   |==[ Field name ]
       |                   |    `==[ StringExp "Allos" ]
       |                   `==[ Field dates ]
       |                        `==[ ArrayExp arrtype1 ]
       |                             |==[ size ]
       |                             |    `==[ IntExp 3 ]
       |                             `==[ init ]
       |                                  `==[ IntExp 1900 ]
       `==[ body ]
            `==[ SeqExp ]
                 |==[ AssignExp ]
                 |    |==[ var ]
                 |    |    `==[ SubscriptVar ]
                 |    |         |==[ var ]
                 |    |         |    `==[ SimpleVar arr1 ]
                 |    |         `==[ index ]
                 |    |              `==[ IntExp 0 ]
                 |    `==[ exp ]
                 |         `==[ IntExp 1 ]
                 |==[ AssignExp ]
                 |    |==[ var ]
                 |    |    `==[ SubscriptVar ]
                 |    |         |==[ var ]
                 |    |         |    `==[ SimpleVar arr1 ]
                 |    |         `==[ index ]
                 |    |              `==[ IntExp 9 ]
                 |    `==[ exp ]
                 |         `==[ IntExp 3 ]
                 |==[ AssignExp ]
                 |    |==[ var ]
                 |    |    `==[ FieldVar name ]
                 |    |         `==[ SubscriptVar ]
                 |    |              |==[ var ]
                 |    |              |    `==[ SimpleVar arr2 ]
                 |    |              `==[ index ]
                 |    |                   `==[ IntExp 3 ]
                 |    `==[ exp ]
                 |         `==[ StringExp "kati" ]
                 |==[ AssignExp ]
                 |    |==[ var ]
                 |    |    `==[ FieldVar age ]
                 |    |         `==[ SubscriptVar ]
                 |    |              |==[ var ]
                 |    |              |    `==[ SimpleVar arr2 ]
                 |    |              `==[ index ]
                 |    |                   `==[ IntExp 1 ]
                 |    `==[ exp ]
                 |         `==[ IntExp 23 ]
                 |==[ AssignExp ]
                 |    |==[ var ]
                 |    |    `==[ SubscriptVar ]
                 |    |         |==[ var ]
                 |    |         |    `==[ SimpleVar arr3 ]
                 |    |         `==[ index ]
                 |    |              `==[ IntExp 34 ]
                 |    `==[ exp ]
                 |         `==[ StringExp "sfd" ]
                 |==[ AssignExp ]
                 |    |==[ var ]
                 |    |    `==[ FieldVar name ]
                 |    |         `==[ SimpleVar rec1 ]
                 |    `==[ exp ]
                 |         `==[ StringExp "sdf" ]
                 |==[ AssignExp ]
                 |    |==[ var ]
                 |    |    `==[ SubscriptVar ]
                 |    |         |==[ var ]
                 |    |         |    `==[ FieldVar dates ]
                 |    |         |         `==[ SimpleVar rec2 ]
                 |    |         `==[ index ]
                 |    |              `==[ IntExp 0 ]
                 |    `==[ exp ]
                 |         `==[ IntExp 2323 ]
                 `==[ AssignExp ]
                      |==[ var ]
                      |    `==[ SubscriptVar ]
                      |         |==[ var ]
                      |         |    `==[ FieldVar dates ]
                      |         |         `==[ SimpleVar rec2 ]
                      |         `==[ index ]
                      |              `==[ IntExp 2 ]
                      `==[ exp ]
                           `==[ IntExp 2323 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test43.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ VarDec a escape=true ]
       |         |==[ type: none ]
       |         `==[ init ]
       |              `==[ SeqExp ]
       `==[ body ]
            `==[ OpExp PlusOp ]
                 |==[ VarExp ]
                 |    `==[ SimpleVar a ]
                 `==[ IntExp 3 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test44.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    `==[ Type rectype ]
       |    |         `==[ RecordTy ]
       |    |              |==[ Field name : string escape=true ]
       |    |              `==[ Field id : int escape=true ]
       |    `==[ VarDec b escape=true ]
       |         |==[ type: rectype ]
       |         `==[ init ]
       |              `==[ NilExp ]
       `==[ body ]
            `==[ AssignExp ]
                 |==[ var ]
                 |    `==[ SimpleVar b ]
                 `==[ exp ]
                      `==[ NilExp ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test45.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    `==[ Type rectype ]
       |    |         `==[ RecordTy ]
       |    |              |==[ Field name : string escape=true ]
       |    |              `==[ Field id : int escape=true ]
       |    `==[ VarDec a escape=true ]
       |         |==[ type: none ]
       |         `==[ init ]
       |              `==[ NilExp ]
       `==[ body ]
            `==[ VarExp ]
                 `==[ SimpleVar a ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test46.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    `==[ Type rectype ]
       |    |         `==[ RecordTy ]
       |    |              |==[ Field name : string escape=true ]
       |    |              `==[ Field id : int escape=true ]
       |    `==[ VarDec b escape=true ]
       |         |==[ type: rectype ]
       |         `==[ init ]
       |              `==[ NilExp ]
       `==[ body ]
            `==[ SeqExp ]
                 |==[ OpExp EqOp ]
                 |    |==[ VarExp ]
                 |    |    `==[ SimpleVar b ]
                 |    `==[ NilExp ]
                 `==[ OpExp NeqOp ]
                      |==[ VarExp ]
                      |    `==[ SimpleVar b ]
                      `==[ NilExp ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test47.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    `==[ Type a ]
       |    |         `==[ NameTy int ]
       |    |==[ VarDec b escape=true ]
       |    |    |==[ type: none ]
       |    |    `==[ init ]
       |    |         `==[ IntExp 4 ]
       |    `==[ TypeDec ]
       |         `==[ Type a ]
       |              `==[ NameTy string ]
       `==[ body ]
            `==[ IntExp 0 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test48.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ FunctionDec ]
       |    |    `==[ Function g ]
       |    |         |==[ params ]
       |    |         |    `==[ Field a : int escape=true ]
       |    |         |==[ result: int ]
       |    |         `==[ body ]
       |    |              `==[ VarExp ]
       |    |                   `==[ SimpleVar a ]
       |    |==[ TypeDec ]
       |    |    `==[ Type t ]
       |    |         `==[ NameTy int ]
       |    `==[ FunctionDec ]
       |         `==[ Function g ]
       |              |==[ params ]
       |              |    `==[ Field a : int escape=true ]
       |              |==[ result: int ]
       |              `==[ body ]
       |                   `==[ VarExp ]
       |                        `==[ SimpleVar a ]
       `==[ body ]
            `==[ IntExp 0 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test49.tig
  ../../programs/testcases/test49.tig:5.17:syntax error
  [2]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test5.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    |==[ TypeDec ]
       |    |    |==[ Type intlist ]
       |    |    |    `==[ RecordTy ]
       |    |    |         |==[ Field hd : int escape=true ]
       |    |    |         `==[ Field tl : intlist escape=true ]
       |    |    |==[ Type tree ]
       |    |    |    `==[ RecordTy ]
       |    |    |         |==[ Field key : int escape=true ]
       |    |    |         `==[ Field children : treelist escape=true ]
       |    |    `==[ Type treelist ]
       |    |         `==[ RecordTy ]
       |    |              |==[ Field hd : tree escape=true ]
       |    |              `==[ Field tl : treelist escape=true ]
       |    `==[ VarDec lis escape=true ]
       |         |==[ type: intlist ]
       |         `==[ init ]
       |              `==[ RecordExp intlist ]
       |                   |==[ Field hd ]
       |                   |    `==[ IntExp 0 ]
       |                   `==[ Field tl ]
       |                        `==[ NilExp ]
       `==[ body ]
            `==[ VarExp ]
                 `==[ SimpleVar lis ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test6.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ FunctionDec ]
       |         |==[ Function do_nothing1 ]
       |         |    |==[ params ]
       |         |    |    |==[ Field a : int escape=true ]
       |         |    |    `==[ Field b : string escape=true ]
       |         |    |==[ result: none ]
       |         |    `==[ body ]
       |         |         `==[ CallExp do_nothing2 ]
       |         |              `==[ OpExp PlusOp ]
       |         |                   |==[ VarExp ]
       |         |                   |    `==[ SimpleVar a ]
       |         |                   `==[ IntExp 1 ]
       |         `==[ Function do_nothing2 ]
       |              |==[ params ]
       |              |    `==[ Field d : int escape=true ]
       |              |==[ result: none ]
       |              `==[ body ]
       |                   `==[ CallExp do_nothing1 ]
       |                        |==[ VarExp ]
       |                        |    `==[ SimpleVar d ]
       |                        `==[ StringExp "str" ]
       `==[ body ]
            `==[ CallExp do_nothing1 ]
                 |==[ IntExp 0 ]
                 `==[ StringExp "str2" ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test7.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ LetExp ]
       |==[ decs ]
       |    `==[ FunctionDec ]
       |         |==[ Function do_nothing1 ]
       |         |    |==[ params ]
       |         |    |    |==[ Field a : int escape=true ]
       |         |    |    `==[ Field b : string escape=true ]
       |         |    |==[ result: int ]
       |         |    `==[ body ]
       |         |         `==[ SeqExp ]
       |         |              |==[ CallExp do_nothing2 ]
       |         |              |    `==[ OpExp PlusOp ]
       |         |              |         |==[ VarExp ]
       |         |              |         |    `==[ SimpleVar a ]
       |         |              |         `==[ IntExp 1 ]
       |         |              `==[ IntExp 0 ]
       |         `==[ Function do_nothing2 ]
       |              |==[ params ]
       |              |    `==[ Field d : int escape=true ]
       |              |==[ result: string ]
       |              `==[ body ]
       |                   `==[ SeqExp ]
       |                        |==[ CallExp do_nothing1 ]
       |                        |    |==[ VarExp ]
       |                        |    |    `==[ SimpleVar d ]
       |                        |    `==[ StringExp "str" ]
       |                        `==[ StringExp " " ]
       `==[ body ]
            `==[ CallExp do_nothing1 ]
                 |==[ IntExp 0 ]
                 `==[ StringExp "str2" ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test8.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ IfExp ]
       |==[ test ]
       |    `==[ OpExp GtOp ]
       |         |==[ IntExp 10 ]
       |         `==[ IntExp 20 ]
       |==[ then ]
       |    `==[ IntExp 30 ]
       `==[ else ]
            `==[ IntExp 40 ]
  $ ../../bin/tiger_ast.exe ../../programs/testcases/test9.tig
  /*==========================================================================*\
  ||  _______ ___ ____ _____ ____                                             ||
  || |_   _|_ _/ ___| ____|  _ \                                              ||
  ||   | |  | | |  _|  _| | |_) |                                             ||
  ||   | |  | | |_| | |___|  _ <                                              ||
  ||   |_| |___\____|_____|_| \_\                                             ||
  \*==========================================================================*/
  
  ast
  `==[ IfExp ]
       |==[ test ]
       |    `==[ OpExp GtOp ]
       |         |==[ IntExp 5 ]
       |         `==[ IntExp 4 ]
       |==[ then ]
       |    `==[ IntExp 13 ]
       `==[ else ]
            `==[ StringExp " " ]
