close all
clear all


pkg load symbolic

R1 = 1.00196314014; 
R2 = 2.082319235;
R3 = 3.05798143645; 
R4 = 4.10496355098; 
R5 = 3.03658050119; 
R6 = 2.00356698935;
R7 = 1.0495200477;
Va = 5.06400320393; 
Id = 1.01960705059; 
Kb = 7.0260450587; 
Kc = 8.35916956066;
G1=1/R1;
G2=1/R2;
G3=1/R3;
G4=1/R4;
G5=1/R5;
G6=1/R6;
G7=1/R7;


N=[0 -G1 G1+G2+G3 -G2 0 -G3 0 0 0 0 0; 0 0 -G2 G2 0 0 0 -1 0 0 0; G4 G1 -G1 0 0 -G4 0 0 1 0 0;0 0 0 0 G5 -G5 0 1 0 0 0; 0 0 0 0 0 0 0 1 0 -Kb 0; 0 0 1 0 0 -1 0 0 0 -1 0; 1 0 0 0 0 0 0 0 0 0 0; -1 1 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 1 -1 0 0 0 -1; 0 0 0 0 0 0 0 0 -Kc 0 1; -1 0 0 0 0 0 1 0 R6+R7 0 0];

x=[0;0;0;Id;0;0;0;Va;0;0;0];


M=[R1+R3+R4 R3 R4 0 0;R4 0 R4+R6+R7 0 -1;0 0 -Kc 0 1;R3 R3 0 -1 0;0 1 0 -Kb 0];

z=[Va;0;0;0;0];

solnodes=N\x;

solmesh=M\z;


printf("\n\nNodal Method\n");

V0 = solnodes(1,1) %V
V2 = solnodes(2,1) %V
V3 = solnodes(3,1) %V
V4 = solnodes(4,1) %V
V5 = solnodes(6,1) %V
V6 = solnodes(5,1) %V
V9 = solnodes(7,1) %V
Ib = solnodes(8,1) %A
Ic = solnodes(9,1) %A
Vb = solnodes(10,1) %V
Vc = solnodes(11,1) %V


printf("\n\nMesh Method\n");


Ia = solmesh(1,1) %A
Ib = solmesh(2,1) %A
Ic = solmesh(3,1) %A
Vb = solmesh(4,1) %V
Vc = solmesh(5,1) %V

