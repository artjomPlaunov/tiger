## Tests

Run all tests with:

```sh
dune runtest
```

Run a specific Cram test with:

```sh
dune runtest test/chap2/lexer.t
dune runtest test/chap2/lexer-errors.t
dune runtest test/chap2/programs-lexer.t
dune runtest test/chap3/parser.t
```

If a Cram test fails and the diff is correct, promote the corrected output:

```sh
dune promote
```

Then it will save that output and future runs will diff against it.

Each Cram test runs an executable for that compiler component, i.e. lexer tests:

```sh
dune exec tiger-lex -- programs/lexer/scaffold.tig
```

parser tests:

```sh
dune exec tiger-parse -- programs/parser/empty.tig
```
