#!/usr/bin/env bash
#
# Demos diffing classfiles via git.

dir=$(mktemp -dt git-java-demo)
cd "$dir" || exit 1;

cat >a.scala <<EOM
final class A {
  @inline def foo[T](cond: => Boolean, result: => T) = if (cond) Some(result) else None
  def f(x: Int) = foo(x > 5, x)
}
EOM

git init
scalac a.scala
git add -f .
git commit -m "before"

rm *.class
scalac -optimise a.scala
git add -fu .
git commit -m "after"

git --no-pager diff --color head^ A.class
