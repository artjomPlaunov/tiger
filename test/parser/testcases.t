This runs the imported Tiger testcase corpus through the parser. Most files in
this directory are semantic-analysis examples and should still parse. test49.tig
is intentionally syntactically invalid.

  $ for f in ../../programs/testcases/*.tig; do
  >   base=$(basename "$f")
  >   if ../../bin/tiger_parse.exe "$f" > /tmp/tiger-parse-corpus.out 2>&1; then
  >     echo "$base parse ok"
  >   else
  >     echo "$base parse error"
  >     cat /tmp/tiger-parse-corpus.out
  >   fi
  > done
  merge.tig parse ok
  queens.tig parse ok
  test1.tig parse ok
  test10.tig parse ok
  test11.tig parse ok
  test12.tig parse ok
  test13.tig parse ok
  test14.tig parse ok
  test15.tig parse ok
  test16.tig parse ok
  test17.tig parse ok
  test18.tig parse ok
  test19.tig parse ok
  test2.tig parse ok
  test20.tig parse ok
  test21.tig parse ok
  test22.tig parse ok
  test23.tig parse ok
  test24.tig parse ok
  test25.tig parse ok
  test26.tig parse ok
  test27.tig parse ok
  test28.tig parse ok
  test29.tig parse ok
  test3.tig parse ok
  test30.tig parse ok
  test31.tig parse ok
  test32.tig parse ok
  test33.tig parse ok
  test34.tig parse ok
  test35.tig parse ok
  test36.tig parse ok
  test37.tig parse ok
  test38.tig parse ok
  test39.tig parse ok
  test4.tig parse ok
  test40.tig parse ok
  test41.tig parse ok
  test42.tig parse ok
  test43.tig parse ok
  test44.tig parse ok
  test45.tig parse ok
  test46.tig parse ok
  test47.tig parse ok
  test48.tig parse ok
  test49.tig parse error
  ../../programs/testcases/test49.tig:5.17:syntax error
  test5.tig parse ok
  test6.tig parse ok
  test7.tig parse ok
  test8.tig parse ok
  test9.tig parse ok
