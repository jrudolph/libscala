#!/usr/bin/env bash
#
# !!! This will modify (or create) your ~/.gitconfig and ~/.gitattributes.
# It's a pure append operation.

gitJavaDir="$(cd $(dirname $BASH_SOURCE) && pwd)"

gitconfigData () {
  cat <<EOM
[diff "javap"]
	textconv = $gitJavaDir/textconv-javap
	cachetextconv = true

[diff "jar-toc"]
  textconv = $gitJavaDir/textconv-jar
  cachetextconv = true
EOM
}

gitAttributesData () {
  cat <<EOM
*.class diff=javap
*.jar   diff=jar-toc
EOM
}

[[ -f ~/.gitconfig     ]] || touch ~/.gitconfig
[[ -f ~/.gitattributes ]] || touch ~/.gitattributes

if grep -q '\[diff "javap"\]' ~/.gitconfig; then
  echo "~/.gitconfig already contains a javap entry: doing nothing."
else
  gitconfigData >> ~/.gitconfig
  echo "Updated ~/.gitconfig with git-java configuration."
fi

if grep -q 'diff=javap' ~/.gitattributes; then
  echo "~/.gitattributes already contains a javap entry: doing nothing."
else
  gitAttributesData >> ~/.gitattributes
  echo "Updated ~/.gitattributes with git-java attributes."
fi
