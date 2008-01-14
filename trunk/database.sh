#!/bin/bash
# database.sh: data management for lowsars(lowbase?)
# Copyright © 2007 Yu Hang, released under GNU General Public License Version 2 or later
# originally for lowsars-test, but mostly moved from and used in lowsars-commander
# this is slow, hopefully to be replaced by cowbase(if no one yet used this name) later

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
#lowsars_db__avails[id]
#lowsars_db__totals[id]
#lowsars_db__avail_[id]
#lowsars_db__total_[id]
#the random algorithm is distributed equally for each sub item with content
#i'm sorry but it's too costive to implement a bbst in bash
#it is slow, use disjoint set of things with non-zero count, preserve the structure and get to the nearest exist ancestor, may have the fastest speed

db_clean(){
unset "${!lowsars_db_@}"
lowsars_db_=0
}

db_add(){
local i cur cur2=0 t
#get_varname "$@"
for i in "${varname[@]}"; do
  cur=$((lowsars_db_${cur2}_$i))
  [ "$cur" = "" ]&&{
    lowsars_db__name[lowsars_db_${cur2}_$i=cur=++lowsars_db__maxid]="$i"
    lowsars_db__parent[cur]="$cur2"
  }
  ((lowsars_db__sum[cur2=cur]++||lowsars_db__avail_$cur2[lowsars_db__avail_[cur]=lowsars_db__avails[$cur2]++]=cur))
done
((++lowsars_db__sum[0],(t=++lowsars_db__count[cur2]-lowsars_db__max[cur2])>0))&&
  for ((i=cur;lowsars_db__max[i]+=t,i;i=lowsars_db__parent[i])); do :; done
}

db_query(){
local i cur=0 cur2 t j
#get_varname "$@"
for i in "${varname[@]}"; do
  cur=$((lowsars_db_$((cur2=cur))_$i))
  [ "$cur" = "" ]&&{
    lowsars_db__name[lowsars_db_${cur2}_$i=cur=++lowsars_db__maxid]="$i"
    lowsars_db__parent[cur]="$cur2"
  }
done
avail&&
for ((--lowsars_db__sum[0],--lowsars_db__count[cur],i=cur;j=lowsars_db__parent[i],i;i=j))
  do ((--lowsars_db__sum[i]||lowsars_db__avail_[lowsars_db__avail_$j[lowsars_db__avail_[i]]=lowsars_db__avail_$j[--lowsars_db__avails[j]]]=lowsars_db__avail_[i])); done
}

db_query(){
get_varname "$@"
if ((lowsars_db_avail_$varname))
  then queryresult="$varname"
elif
"${!lowsars_db_avail_$varname_@}"

}














