#!/bin/bash
# database.sh: data management for lowsars(lowbase?)
# Copyright © 2007 Yu Hang, released under GNU General Public License Version 2 or later
# originally for lowsars-test, but mostly moved from and used in lowsars-commander

RANDOM_SIZE=32768
#LOWSARS_DB_INIT=lowsars_db

get_varname(){
#get_varname string[@]
#return a legal variable name, path separated by _
varname=()
local varnameitem
for varnameitem; do
{ varname[${#varname[@]}]="
`od -vtx1 -N "${#varnameitem}"` ";} <<<"$varnameitem"
done
local IFS=_
{ varname=(`cut -b 9-`);} <<<"${varname[*]}"
varname=("${varname[@]//[
\ ]}")
}

#lowsars_db_id_name=id
#lowsars_db__name[id]
#lowsars_db__parent[id]
#lowsars_db__count[id]
#lowsars_db__sum[id]
#lowsars_db__max[id]
#lowsars_db__maxid
#lowsars_db__avail_id=(sub_ids)
#lowsars_db__total_id=(sub_ids)
#lowsars_db__avails[id] count
#lowsars_db__totals[id]
#lowsars_db__avail_[id] reversedlink
#lowsars_db__total_[id]
#lowsars_db__factor[id]
#the random algorithm is distributed equally for each sub item with content
#i'm sorry but it's too costive to implement a bbst in bash
#it is slow, use disjoint set of things with non-zero count, preserve the structure and get to the nearest exist ancestor, may have the fastest speed

#should change factor to no parent item

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
for ((i=cur;lowsars_db__sum[i]+=$2,j=lowsars_db__parent[i],lowsars_db__factor[i];i=j))
  do (($2&&lowsars_db__sum[i]==$2&&(lowsars_db__avail_$j[lowsars_db__avail_[i]=lowsars_db__avails[j]++]=i))); done
((lowsars_db__sum[0]+=$2,(t=(lowsars_db__count[cur]+=$2)-lowsars_db__max[cur])>0))&&
  for ((i=cur;lowsars_db__max[i]+=t,i;i=lowsars_db__parent[i])); do :; done
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
  do extrapath[${#extrapath[@]}]=${lowsars_db_name[cur=lowsars_db__avail_$cur[RANDOM*lowsars_db_avails[$cur]/RANDOM_SIZE]]}; done
ENODEID="$cur"
for ((lowsars_db__sum[0]-=$2,lowsars_db__count[i=cur]-=$2;j=lowsars_db__parent[i],lowsars_db__factor[i];i=j))
  do (((lowsars_db__sum[i]-=$2)||lowsars_db__avail_[lowsars_db__avail_$j[lowsars_db__avail_[i]]=lowsars_db__avail_$j[--lowsars_db__avails[j]]]=lowsars_db__avail_[i])); done
:;}
}

#an advanced algorithm assigning resource for both cpu and memory still required

db_link(){
:
}

db_unset(){
:
}

