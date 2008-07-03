var a,b,c:longint;
begin
   for a:=1 to 100000 do
     for b:=1 to 100000 do c:=(c+a+b)mod 12345678;
end.
