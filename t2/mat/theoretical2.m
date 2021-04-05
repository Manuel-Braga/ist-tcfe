
pkg load symbolic
format long

fid=fopen('data.txt');
for k=1:9
fgetl(fid);
end

fid2=fopen('data_circuit1.m', 'wt');

for k=10:16
line=fgetl(fid);
fprintf(fid2,'%s*1000;\n',line);
end

line=fgetl(fid);
fprintf(fid2,'%s;\n',line);

line=fgetl(fid);
fprintf(fid2,'%s*0.000001;\n',line);

line=fgetl(fid);
fprintf(fid2,'%s /1000;\n',line);

line=fgetl(fid);
fprintf(fid2,'%s *1000;\n',line);


fclose(fid);

fclose(fid2);
data_circuit1


G1=1/R1;
G2=1/R2;
G3=1/R3;
G4=1/R4;
G5=1/R5;
G6=1/R6;
G7=1/R7;


N=[1 0 0 0 0 0 0;-G1 G1+G2+G3 -G2 -G3 0 0 0;0 Kb+G2 -G2 -Kb 0 0 0;-G1 G1 0 G4 0 G6 0;0 0 0 0 0 -G6-G7 G7;0 0 0 1 0 Kd*G6 -1;0 0 0 0 1 0 -1];

x=[0;0;0;0;0;0;Vx];


solnodes=N\x;



printf("\n\nNodal Method\n");

V1 = solnodes(1,1) %V
V2 = solnodes(2,1) %V
V3 = solnodes(3,1) %V
V5 = solnodes(4,1) %V
V6 = solnodes(5,1) %V
V7 = solnodes(6,1) %V
V8 = solnodes(7,1) %V

Ix = ((V6-V5)/R5) + ((V3-V2)/R2)
REq = abs(Vx/Ix)
TAU = REq*C

tab_file=fopen('theorcir2_TAB.tex', 'wt');
fprintf(tab_file, "$V_x$ & %f $V$\\\\ \\hline\n$I_x$ & %f $mA$\\\\ \\hline\n$R_{Eq}$ & %f $k\\Omega$\\\\ \\hline\n$\\tau$ & %f $s$\\\\ \\hline",Vx, Ix*1000, REq/1000,TAU);
fclose(tab_file);

