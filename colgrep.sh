#!/usr/bin/env bash
set -e

[ -z "$1" ] && echo "usage: colgrep <pattern> [color] [file]" 1>&2 && exit 1
pattern=$1
color="0;32"
if [ ! -f $2 ]; then
  case $2 in
    green) color="0;32" ;;
    red) color="0;31" ;;
    RED) color="38;5;196" ;;
    blue) color="0;36" ;;
    yellow) color="0;33" ;;
    grey|gray) color="0;30" ;;
  esac
  shift
fi

while read line; do
  echo "$line" | sed ''/"${pattern}"/s//`printf "\033[%sm%s\033[0m" "$color" "$pattern"`/g'' $2
done
