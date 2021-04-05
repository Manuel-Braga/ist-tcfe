
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
fprintf(tab_file, "$V1$ & %f $V$\\\\ \\hline\n$V2$ & %f $V$\\\\ \\hline\n$V3$ & %f $V$\\\\ \\hline\n$V5$ & %f $V$\\\\ \\hline\n$V6$ & %f $V$\\\\ \\hline\n$V7$ & %f $V$\\\\ \\hline\nV8 & %f $V$\\\\ \\hline\n$I(R_1)$ & %f $mA$\\\\ \\hline\n$I(R_2)$ & %f $mA$\\\\ \\hline\n$I(R_3)$ & %f $mA$\\\\ \\hline\n$I(R_4)$ & %f $mA$\\\\ \\hline\n$I(R_5)$ & %f $mA$\\\\ \\hline\n$I(R_6)$ & %f $mA$\\\\ \\hline\n$I(R_7)$ & %f $mA$\\\\ \\hline\n$I(V_s)$ & %f $mA$\\\\ \\hline\n$I_b$ & %f $mA$\\\\ \\hline\n$I_c$ & %f $mA$\\\\ \\hline\n$I(K_d)$ & %f $mA$\\\\ \\hline\n",V1,V2,V3,V5,V6,V7,V8,IR1*1000,IR2*1000,IR3*1000,IR4*1000,IR5*1000,IR6*1000,IR7*1000,IVs*1000,Ib*1000,Ic*1000,Ikd*1000);
fclose(tab_file);

tab_file=fopen('data_TAB.tex', 'wt');
fprintf(tab_file, "$R_1$ & %f $k\\Omega$\\\\ \\hline\n$R_2$ & %f $k\\Omega$\\\\ \\hline\n$R_3$ & %f $k\\Omega$\\\\ \\hline\n$R_4$ & %f $k\\Omega$\\\\ \\hline\n$R_5$ & %f $k\\Omega$\\\\ \\hline\n$R_6$ & %f $k\\Omega$\\\\ \\hline\n$R_7$ & %f $k\\Omega$\\\\ \\hline\n$V_S$ & %f $V$\\\\ \\hline\n$C$n& %f $uF$\\\\ \\hline\n$K_b$ & %f $mS$\\\\ \\hline\n$K_d$ & %f $mS$\\\\ \\hline\n",R1/1000,R2/1000,R3/1000,R4/1000,R5/1000,R6/1000,R7/1000,Vs,C/0.000001,Kb*1000,Kd/1000);
fclose(tab_file);

