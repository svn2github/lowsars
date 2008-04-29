var a,b:longint;
begin
assign(input,'a.in');
reset(input);
assign(output,'a.out');
rewrite(output);
read(a,b);
writeln(a+b);
close(output);
end.
