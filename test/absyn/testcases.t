This runs the imported Tiger testcase corpus through AST construction. The
tree output is redirected here; focused pretty-printer snapshots live in
pretty.t.

  $ for f in ../../programs/testcases/*.tig; do
  >   base=$(basename "$f")
  >   if ../../bin/tiger_ast.exe "$f" > /tmp/tiger-absyn-corpus.out 2>&1; then
  >     echo "$base ast ok"
  >   else
  >     echo "$base ast error"
  >     cat /tmp/tiger-absyn-corpus.out
  >   fi
  > done
  merge.tig ast ok
  queens.tig ast ok
  test1.tig ast ok
  test10.tig ast ok
  test11.tig ast ok
  test12.tig ast ok
  test13.tig ast ok
  test14.tig ast ok
  test15.tig ast ok
  test16.tig ast ok
  test17.tig ast ok
  test18.tig ast ok
  test19.tig ast ok
  test2.tig ast ok
  test20.tig ast ok
  test21.tig ast ok
  test22.tig ast ok
  test23.tig ast ok
  test24.tig ast ok
  test25.tig ast ok
  test26.tig ast ok
  test27.tig ast ok
  test28.tig ast ok
  test29.tig ast ok
  test3.tig ast ok
  test30.tig ast ok
  test31.tig ast ok
  test32.tig ast ok
  test33.tig ast ok
  test34.tig ast ok
  test35.tig ast ok
  test36.tig ast ok
  test37.tig ast ok
  test38.tig ast ok
  test39.tig ast ok
  test4.tig ast ok
  test40.tig ast ok
  test41.tig ast ok
  test42.tig ast ok
  test43.tig ast ok
  test44.tig ast ok
  test45.tig ast ok
  test46.tig ast ok
  test47.tig ast ok
  test48.tig ast ok
  test49.tig ast error
  ../../programs/testcases/test49.tig:5.17:syntax error
  test5.tig ast ok
  test6.tig ast ok
  test7.tig ast ok
  test8.tig ast ok
  test9.tig ast ok
