
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



N=[1 0 0 0 0 0 0;-G1 G1+G2+G3 -G2 -G3 0 0 0;0 Kb+G2 -G2 -Kb 0 0 0;-G1 G1 0 G4 0 G6 0;0 0 0 0 0 -G6-G7 G7;0 0 0 1 0 Kd*G6 -1;0 -G3 0 G3+G4+G5 -G5 G6 0;];

x=[Vs;0;0;0;0;0;0];



solnodes=N\x;



printf("\n\nNodal Method\n");

V1 = solnodes(1,1) %V
V2 = solnodes(2,1) %V
V3 = solnodes(3,1) %V
V5 = solnodes(4,1) %V
V6 = solnodes(5,1) %V
V7 = solnodes(6,1) %V
V8 = solnodes(7,1) %V
IR1 = (V1-V2)/R1
IR2 = (V2-V3)/R2
IR3 = (V5-V2)/R3
IR4 = V5/R4
IR5 = (V6-V5)/R5
IR6 = (-V7)/R6
IR7 = (V7-V8)/R7
IVs = IR1
Ib = -IR2
Ic = 0
Ikd = IR6

tab_file=fopen('theorcir1_TAB.tex', 'wt');
fprintf(tab_file, "V1 & %f V\\\\ \\hline\nV2 & %f V\\\\ \\hline\nV3 & %f V\\\\ \\hline\nV5 & %f V\\\\ \\hline\nV6 & %f V\\\\ \\hline\nV7 & %f V\\\\ \\hline\nV8 & %f V\\\\ \\hline\nIR1 & %f mA\\\\ \\hline\nIR2 & %f mA\\\\ \\hline\nIR3 & %f mA\\\\ \\hline\nIR4 & %f mA\\\\ \\hline\nIR5 & %f mA\\\\ \\hline\nIR6 & %f mA\\\\ \\hline\nIR7 & %f mA\\\\ \\hline\nIVs & %f mA\\\\ \\hline\nIb & %f mA\\\\ \\hline\nIc & %f mA\\\\ \\hline\nIkd & %f mA\\\\ \\hline\n",V1,V2,V3,V5,V6,V7,V8,IR1*1000,IR2*1000,IR3*1000,IR4*1000,IR5*1000,IR6*1000,IR7*1000,IVs*1000,Ib*1000,Ic*1000,Ikd*1000);
fclose(tab_file);

