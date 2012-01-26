#!/usr/bin/env bash
#
# Demos diffing classfiles via git.

set -e

dir=$(mktemp -d ${TMPDIR:-/tmp}/git-java-demo.XXXXXXXXXX)
cd "$dir" || exit 1;

cat >a.scala <<EOM
final class A {
  @inline def foo[T](cond: => Boolean, result: => T) = if (cond) Some(result) else None
  def f(x: Int) = foo(x > 5, x)
}
EOM

scalac=scalac
[[ -x "$scalac" ]] || scalac="$SCALA_HOME/bin/scalac"
[[ -x "$scalac" ]] || {
  echo "No scalac in your path, and none at SCALA_HOME either."
  echo "Are you sure you're a scala developer? Install scala and try again."
  exit 1;
}

git init
"$scalac" a.scala
git add -f .
git commit -m "before"

rm *.class
"$scalac" -optimise a.scala
git add -fu .
git commit -m "after"

git --no-pager diff --color HEAD^ A.class
