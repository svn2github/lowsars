#!/bin/bash
# database.sh: data management for lowsars(lowbase?)
# Copyright © 2007 Yu Hang, released under GNU General Public License Version 2 or later
# originally for lowsars-test, but mostly moved from and used in lowsars-commander

RANDOM_SIZE=32768
#LOWSARS_DB_INIT=lowsars_db

get_varname(){
#get_varname string[@]
#return legal variable names(in hexadecimal code)
local i
varname=()
for i
do { varname[${#varname[@]}]="x`od -vtx1 -An -N "${#i}"`";} <<<"$i"; done
varname=("${varname[@]//[ $'\12']/_}")
}

restore_text(){
#restore_text varname[@]
local i t
resulttext=()
for i
do printf -v t %b "${i//_/\x}";resulttext[${#resulttext[@]}]="${t:1}"; done
#could not set array element target in printf
#could not set new string in ${// /} as }"' without another variable
}

#lowsars_db_id_name=id
#lowsars_db__name[id]
#lowsars_db__parent[id]
#lowsars_db__count[id]
#lowsars_db__sum[id]
#lowsars_db__max[id]
#lowsars_db__maxid
#lowsars_db__avail_id=(sub_ids)
#lowsars_db__total_id=(sub_ids) not used
#lowsars_db__avails[id] count
#lowsars_db__totals[id]
#lowsars_db__avail_[id] reversedlink
#lowsars_db__total_[id]
#lowsars_db__factor[id] should be changed to no parent item
#the random algorithm is distributed equally for each sub item with content
#i'm sorry but it's too costive to implement a bbst in bash
#it is slow, use disjoint set of things with non-zero count, preserve the structure and get to the nearest exist ancestor, may have the fastest speed

trap 'echo "${FUNCNAME[@]}";echo "${BASH_LINENO[@]}";echo "$@"' exit

db_clean(){
unset "${!lowsars_db_@}"
lowsars_db_=0
lowsars_db__factor[0]=0
}

db_add(){
#db_add root count varname[@]
local i cur="$1" cur2 t j
for i in "${@:3}"; do
  [ "$((cur=lowsars_db_$((cur2=cur))_$i))" = "0" ]&&{
    lowsars_db__name[lowsars_db_${cur2}_$i=cur=++lowsars_db__maxid]="$i"
    lowsars_db__parent[cur]="$cur2"
    lowsars_db__factor[cur]=1
  }
  #(((lowsars_db__sum[cur2=cur]+=$2)==$2&&$2&&(lowsars_db__avail_$cur2[lowsars_db__avail_[cur]=lowsars_db__avails[$cur2]++]=cur)))
done
(($2))&&for ((i=cur;lowsars_db__sum[i]+=$2,j=lowsars_db__parent[i],lowsars_db__factor[i];i=j))
  do ((lowsars_db__sum[i]==$2&&(lowsars_db__avail_$j[lowsars_db__avail_[i]=lowsars_db__avails[j]++]=i))); done
(((t=(lowsars_db__count[cur]+=$2)-lowsars_db__max[cur])>0))&&
  for ((i=cur;lowsars_db__max[i]+=t,lowsars_db__factor[i];i=lowsars_db__parent[i])); do :; done
NODEID="$cur"
}

db_query(){
#db_query root count varname[@]
#***in the current version, count must be 1 if the variable have sub items
local i cur="$1" cur2 t j
for i in "${@:3}"; do
  [ "$((cur=lowsars_db_$((cur2=cur))_$i))" = "0" ]&&{
    NODEID=
    return 2
#    lowsars_db__name[lowsars_db_${cur2}_$i=cur=++lowsars_db__maxid]="$i"
#    lowsars_db__parent[cur]="$cur2"
  }
done
extrapath=()
NODEID="$cur"
((lowsars_db__sum[cur]>=$2))&&{
while ((lowsars_db__count[cur]<$2))
  do extrapath[${#extrapath[@]}]=${lowsars_db__name[cur=lowsars_db__avail_$cur[RANDOM*lowsars_db_avails[cur]/RANDOM_SIZE]]}; done
ENODEID="$cur"
(($2))&&for ((lowsars_db__count[i=cur]-=$2;j=lowsars_db__parent[i],lowsars_db__sum[i]-=$2,lowsars_db__factor[i];i=j))
  do ((lowsars_db__sum[i]||(lowsars_db__avail_[lowsars_db__avail_$j[lowsars_db__avail_[i]]=lowsars_db__avail_$j[--lowsars_db__avails[j]]]=lowsars_db__avail_[i]))); done
:;}
}

#an advanced algorithm assigning resource for both cpu and memory still required

db_link(){
#db_link id1 id2 [name]
#should add path support
((${lowsars_db__maxid:-0}<(NODEID=${2:-$((lowsars_db_$1_$3?lowsars_db_$1_$3:++lowsars_db__maxid))})))&&{
  lowsars_db__name[NODEID]="$3"
  lowsars_db__parent[NODEID]="-1"
  lowsars_db__factor[NODEID]=0
}
((lowsars_db_$1_${3:-${lowsars_db__name[NODEID]}}=NODEID))
:
}

db_unset(){
:
}

db_check(){
#db_check id [name] varname[@]
#does not support sub with blank name
#should add requested count
local i cur2 t
NODEID="$1"
for i in "${@:3}"; do
  [ "$((NODEID=lowsars_db_$((cur2=NODEID))_$i))" = "0" ]&&break
done
extrapath=()
for ((i=NODEID,t=1;t;t=lowsars_db__factor[i],i=lowsars_db__parent[i])); do
  extrapath[${#extrapath[@]}]="${lowsars_db__name[i]}"
  ((${2+1}0&&(RNODEID=${2:+lowsars_db_}$i${2:+_}$2)&&lowsars_db__sum[RNODEID]))&&break
done
}

db_debug_dump(){
declare -p "${!lowsars_db_@}"
}

