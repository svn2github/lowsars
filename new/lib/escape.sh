#!/bin/bash
# escape.sh: bash escaping and substituting function used in lowsars
# Copyright © 2007 Yu Hang, released under GNU General Public License Version 2 or later

: ${ESCAPECHAR="%"}
declare -p ESCAPE_VALUES &>/dev/null||ESCAPE_VALUES=([37]="%" [32]=" ")
#this in fact does not work if not called by . command!
#and... this does not work with this two characters yet!
declare -p ESCAPE_REQUEST_HANDLE &>/dev/null||ESCAPE_REQUEST_HANDLE=()
#the handle should put the escape result in ESCAPE_VALUES, and write the number of characters used in charcount, the following characters are available in escapetemp

unescape(){
#unescape string
#names begin with %, \ and % should be replaced to \\ and \%
#this method is faster than the old implementation of single character escaping, in bash
#characters like \0 can't be used since it can't be saved into a variable
local i escapecur escapetemp charcode charcount IFS=" "
escaperesult=()
escapecur=()
{
read -d "$ESCAPECHAR" -a escapetemp
while
  if ((${#escapetemp[@]}>1)); then
    IFS=""
    escaperesult[${#escaperesult[@]}]="${escapecur[*]}$escapetemp"
    for ((i=1;i<${#escapetemp[@]}-1;i++))
      do escaperesult[${#escaperesult[@]}]="${escapetemp[i]}"; done
    escapecur=("${escapetemp[${#escapetemp[@]}-1]%"$ESCAPECHAR"}")
  else
    escapecur[${#escapecur[@]}]="${escapetemp%\%}"
  fi
  IFS=" "
  read -d "$ESCAPECHAR" -a escapetemp
do
  printf -v charcode %u "'${escapetemp:0:1}"
  charcount=1
  ${ESCAPE_REQUEST_HANDLE[charcode]+"${ESCAPE_REQUEST_HANDLE[charcode]}" "$escapetemp"}
  escapecur[${#escapecur[@]}]="${ESCAPE_VALUES[charcode]-"$ESCAPECHAR${escapetemp:0:1}"}"
  escapetemp="${escapetemp:$charcount}"
done
}<<<"${1//"$ESCAPECHAR"/\\$ESCAPECHAR$ESCAPECHAR}\\$ESCAPECHAR$ESCAPECHAR"
IFS=
escaperesult[${#escaperesult[@]}]="${escapecur[*]}"
}

compositesubst(){
#compositesubst string
#substitute another thing with a fixer
#return result in ESCAPE_VALUES[charcode of $1:0:1], escaped character count in charcount
#this is ugly, ugly, very ugly!!!
:
}

longnamesubst(){
#longnamesubst string
#subst a long variable until $ESCAPETERM found
#return result in ESCAPE_VALUES[charcode of $1:0:1], escaped character count in charcount
#this is ugly, ugly, very ugly!!!
:
}

((${#BASH_SOURCE[@]}<=1))&&{
  #more parameters seemed to be needed
  unescape "$1"
  printf %s\\n "${escaperesult[*]}"
  #a better plainecho alternative (prevent -n problem)
  exit
}

