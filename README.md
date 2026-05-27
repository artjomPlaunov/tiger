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