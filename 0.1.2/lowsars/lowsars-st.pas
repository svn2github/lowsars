{
# This is a part of LowSars (pre-alazea) - Lsz's OI Wonderful Scoring And Ranking System
# Used for sorting.
# credit: chinatslsz@hotmail.com
}
const maxn=2000;maxm=30;
var i,j,k,m,n,x:longint;
    a:array[1..maxn]of string;
    b:array[1..maxn,0..maxm]of double;// b[x,0]: tot for x
    c:array[1..maxn]of longint;
    t:double;
    s,d:string; ch:char; xx:byte;
begin
    d:=paramstr(1);
    if d='' then d:=' ';
    xx:=0;
    s:=paramstr(2);    val(s,x,xx);
    if xx<>0 then x:=0;
    readln(s);
    m:=-1;
    write('#',d,' ':10);
    j:=1;
    for i:=1 to length(s) do if s[i]=' ' then begin
       inc(m); write(d);
    end else write(s[i]);
    writeln;
    n:=0;
    {while not eof do begin
       k:=0; inc(n);
       a[n]:='';
       while k<m do begin
          read(ch);
          if ch=' ' then begin
             a[n]:=a[n]+d;
             inc(k);
          end else a[n]:=a[n]+ch;
       end;
       readln(b[n]);
    end;}
    while not eof do begin
       k:=0; inc(n);
       a[n]:=''; read(ch);
       while ch<>' ' do begin
          a[n]:=a[n]+ch; read(ch);
       end;
       for i:=1 to m do read(b[n,i]);
       readln(b[n,0]);
    end;
    for i:=1 to n do c[i]:=1;
    for i:=1 to n-1 do for j:=i+1 to n do if a[i]=a[j] then c[i]:=0;
    i:=1; k:=0;
    for i:=1 to n do if c[i]=1 then begin
       inc(k); c[k]:=i;
    end;
    n:=k;
    for i:=1 to n-1 do for j:=i+1 to n do if b[c[i],x]<b[c[j],x] then begin
       k:=c[i]; c[i]:=c[j]; c[j]:=k;
    end;
    i:=1; 
    for i:=1 to n do begin
       write(i,d,a[c[i]]:12,d);
       for j:=1 to m do write(b[c[i],j]:0:0,d);
       writeln(b[c[i],0]:0:0);
    end;
end.
