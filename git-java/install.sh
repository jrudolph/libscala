#!/usr/bin/env bash
#
# !!! This will modify (or create) your $HOME/.gitconfig and $HOME/.gitattributes.
# It's adding this to your core.attributes:
#
#   *.class diff=textconv-javap
#   *.jar   diff=textconv-jar
#
# And then the config to make use of it to .gitconfig.

gitJavaDir="$(cd $(dirname $BASH_SOURCE) && pwd)"
defaultAttributes="$HOME/.gitattributes"

die () {
  echo "$@" && exit 1
}
log () {
  echo >&2 "$@"
}
  
gitConfig () {
  git config --global "$@"
}
gitConfigAdd () {
  key="$1"
  value="$2"
  gitConfig --add "$key" "$value" && log "[create] config $key = $value"
}
gitConfigGet () {
  gitConfig --get "$@"
}

gitConfigAddIfAbsent () {
  if gitConfigGet "$1" >/dev/null; then
    log "[exists]    config  $1 = $(gitConfigGet $1)"
  else
    gitConfigAdd "$@"
  fi
}

gitAttributesFile () {
  local file=$(gitConfigGet core.attributesfile)
  [[ -n "$file" ]] || {
    gitConfigAdd core.attributesfile "$defaultAttributes"
    file=$(gitConfigGet core.attributesfile)
  }
  # manual twiddle expansion, whee
  [[ -f "$file" ]] || file=$(eval "echo $file")
  [[ -f "$file" ]] || {
    touch "$file" && log "[create]      file  $file"
  }
  echo "$file"
}
    
attributesFile="$(gitAttributesFile)"

gitAttributeAdd () {
  local ext="$1"
  local handler="$2"
  
  existing="$(egrep "=${handler}\b" "$attributesFile")"
  
  if [[ -n "$existing" ]]; then
    log "[exists] attribute  $existing"
  else
    line="*.${ext} diff=${handler}"
    echo "$line" >>"$attributesFile"
    log "[create] attribute $line"
  fi
}

[[ -f "$attributesFile" ]] && {
  gitAttributeAdd class javap
  gitAttributeAdd jar jar-toc
}

gitConfigAddIfAbsent diff.javap.textconv "$gitJavaDir/textconv-javap"
gitConfigAddIfAbsent diff.javap.cachetextconv true

gitConfigAddIfAbsent diff.jar-toc.textconv "$gitJavaDir/textconv-jar"
gitConfigAddIfAbsent diff.jar-toc.cachetextconv true

cat <<EOM

git-java setup complete.  Now run this:

git-java/demo.sh
EOM
