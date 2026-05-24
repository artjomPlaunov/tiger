## Tests

`test/<chapter>/`.

Uses dune cram tests:

```sh
dune runtest test/chap2/lexer.t
dune runtest test/chap2/lexer-errors.t
dune runtest test/chap2/course-lexer.t
```

To inspect the lexer output directly:

```sh
dune exec tiger -- programs/lexer/scaffold.tig
```

To update the expected Cram output after inspecting a cram diff:

```sh
dune promote
```

Run all tests with:

```sh
dune runtest
```

`test/chap2/lexer.t` contains focused valid lexer cases.
`test/chap2/lexer-errors.t` contains lexer diagnostic cases.
`test/chap2/course-lexer.t` contains snapshots for all imported course
programs.

To add a new focused lexer case, add a command to `test/chap2/lexer.t`, run the
Cram test, inspect Dune's diff, and promote it if the output is correct.
