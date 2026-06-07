  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/int-plus.tig
  typecheck ok

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/int-arithmetic.tig
  typecheck ok

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/seq-basic.tig
  typecheck ok

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/seq-nested.tig
  typecheck ok

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/seq-arg-error.tig
  ../../programs/typecheck/seq-arg-error.tig:1.8:integer required
  [2]

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/string-plus.tig
  ../../programs/typecheck/string-plus.tig:1.8:integer required
  [2]

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/int-string-eq.tig
  ../../programs/typecheck/int-string-eq.tig:1.2:same type required
  [2]

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/int-string-lt.tig
  ../../programs/typecheck/int-string-lt.tig:1.2:integer or string required
  [2]

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/undefined-variable.tig
  ../../programs/typecheck/undefined-variable.tig:1.0:undefined variable
  [2]

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/function-as-variable.tig
  ../../programs/typecheck/function-as-variable.tig:1.0:function used as variable
  [2]

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/print-string.tig
  typecheck ok

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/size-plus.tig
  typecheck ok

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/print-int.tig
  ../../programs/typecheck/print-int.tig:1.0:argument type mismatch
  [2]

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/unknown-call.tig
  ../../programs/typecheck/unknown-call.tig:1.0:undefined function
  [2]

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/too-many-args.tig
  ../../programs/typecheck/too-many-args.tig:1.0:too many arguments
  [2]

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/too-few-args.tig
  ../../programs/typecheck/too-few-args.tig:1.0:too few arguments
  [2]

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/print-plus.tig
  ../../programs/typecheck/print-plus.tig:1.15:integer required
  [2]

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/let-var-int.tig
  typecheck ok

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/let-var-typed-int.tig
  typecheck ok

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/let-var-string-call.tig
  typecheck ok

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/let-var-declaration-order.tig
  typecheck ok

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/let-var-shadowing.tig
  typecheck ok

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/let-var-scope-error.tig
  ../../programs/typecheck/let-var-scope-error.tig:7.0:undefined variable
  [2]

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/let-var-body-type-error.tig
  ../../programs/typecheck/let-var-body-type-error.tig:4.4:integer required
  [2]

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/let-var-init-uses-previous-error.tig
  ../../programs/typecheck/let-var-init-uses-previous-error.tig:3.13:integer required
  [2]

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/let-var-type-mismatch.tig
  ../../programs/typecheck/let-var-type-mismatch.tig:2.10:init type and declaration type incompatible in variable declaration
  [2]

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/let-var-unknown-type.tig
  ../../programs/typecheck/let-var-unknown-type.tig:2.10:type constraint in variable declaration does not exist
  [2]

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/let-var-nil-unconstrained.tig
  ../../programs/typecheck/let-var-nil-unconstrained.tig:2.2:Nil initializer in expression must be constrained by record type
  [2]

  $ ../../bin/tiger_typecheck.exe ../../programs/typecheck/let-var-nil-int.tig
  ../../programs/typecheck/let-var-nil-int.tig:2.10:init type and declaration type incompatible in variable declaration
  [2]
