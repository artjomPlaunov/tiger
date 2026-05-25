## Tests

Run all tests with:

```sh
dune runtest
```

Run a specific Cram test with:

```sh
dune runtest test/lexer/lexer.t
dune runtest test/lexer/lexer-errors.t
dune runtest test/lexer/testcases-lexer.t
dune runtest test/parser/parser.t
```

If a Cram test fails and the diff is correct, promote the corrected output:

```sh
dune promote
```

Then rerun the same Cram test to confirm it passes.

For manual inspection, run the component executable directly. This does not
create promotable Cram output.

Lexer example:

```sh
dune exec tiger-lex -- programs/lexer/scaffold.tig
```

Parser example:

```sh
dune exec tiger-parse -- programs/parser/empty.tig
```
