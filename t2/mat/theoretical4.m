
data_circuit1

w = 2*pi*1000

N = [1 0 0 0 0 0 0;-G1 G1+G2+G3 -G2 -G3 0 0 0;0 Kb+G2 -G2 -Kb 0 0 0;-G1 G1 0 G4 0 G6 0;0 0 0 0 0 -G6-G7 G7;0 0 0 1 0 G6*Kd -1;0 -G3 0 G3+G4+G5 -G5-(j*w*C) G6 j*w*C];

x = [-j; 0; 0; 0; 0; 0; 0];

solnodes = N\x;

V1r = abs(solnodes(1,1))
V1phase = angle(solnodes(1,1))
V2r = abs(solnodes(2,1))
V2phase = angle(solnodes(2,1))
V3r = abs(solnodes(3,1))
V3phase = angle(solnodes(3,1))
V5r = abs(solnodes(4,1))
V5phase = angle(solnodes(4,1))
V6r = abs(solnodes(5,1))
V6phase = angle(solnodes(5,1))
V7r = abs(solnodes(6,1))
V7phase = angle(solnodes(6,1))
V8r = abs(solnodes(7,1))
V8phase = angle(solnodes(7,1))

tab_file=fopen("forced_tab.tex","w");

fprintf(tab_file, "$V_{1}$ & %f & %f\\\\ \\hline\n$V_{2}$ & %f & %f\\\\ \\hline\n$V_{3}$ & %f & %f\\\\ \\hline\n$V_{5}$ & %f & %f\\\\ \\hline\n$V_{6}$ & %f & %f\\\\ \\hline\n$V_{7}$ & %f & %f\\\\ \\hline\n$V_{8}$ & %f & %f\\\\ \\hline", V1r,V1phase*180/pi,V2r,V2phase*180/pi,V3r,V3phase*180/pi,
V5r,V5phase*180/pi,V6r,V6phase*180/pi,V7r,V7phase*180/pi,V8r,V8phase*180/pi);

fclose(tab_file);


