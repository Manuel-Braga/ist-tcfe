

freq = logspace(-1, 6, 30);

for i=1:1:30

w=2*pi*freq(i);

N = [1 0 0 0 0 0 0;-G1 G1+G2+G3 -G2 -G3 0 0 0;0 Kb+G2 -G2 -Kb 0 0 0;-G1 G1 0 G4 0 G6 0;0 0 0 0 0 -G6-G7 G7;0 0 0 1 0 G6*Kd -1;0 -G3 0 G3+G4+G5 -G5-(j*w*C) G6 j*w*C];

x = [-j; 0; 0; 0; 0; 0; 0];

solnodes = N\x;
V6(i)=solnodes(5,1);
V8(i)=solnodes(7,1);
Vs(i)=solnodes(1,1);
Vc(i)=V6(i)-V8(i);

end 

hf = figure (3);
plot (log10(freq), 20*log10(abs(Vs)), "g");
hold on
plot (log10(freq), 20*log10(abs(V6)), "r");
hold on
plot (log10(freq), 20*log10(abs(Vc)), "b");

xlabel ("Frequency, in logarithmic scale [Hz]");
ylabel ("Magnitude [dB]");
legend ('Vs','V6', 'Vc','Location','Northeast')
print (hf, "magnitude.eps", "-depsc");

hf = figure (4);
plot (log10(freq), (180*angle(Vs))/pi, "g");
hold on
plot (log10(freq), (180*angle(V6))/pi, "r");
hold on
plot (log10(freq) , (180*angle(Vc))/pi, "b");

xlabel ("Frequecy, in logarithmic scale [Hz]");
ylabel ("Phase [Degrees]");
legend ('Vs','V6', 'Vc','Location','Northeast')
print (hf, "phase.eps", "-depsc");
