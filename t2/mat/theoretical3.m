
syms t
syms A
syms wn
syms V6n(t)

V6n(t) = A*exp(wn*t)

A = Vx;
wn = - (1/TAU);

t=0:1e-5:20e-3;
V6n = A*exp(wn*t);

hf = figure (1);
plot (t*1000, V6n, "g");

xlabel ("t [ms]");
ylabel ("V 6_n [V]");
legend ('V 6_n(t)','Location','Northeast')
print (hf, "natural.eps", "-depsc");




