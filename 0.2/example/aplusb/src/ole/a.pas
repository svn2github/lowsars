var a,b:longint;
begin
assign(output,'a.out');
rewrite(output);
for a:=1 to 1000 do for b:=1 to 2000 do writeln('xxxxxxx');
close(output);
end.
