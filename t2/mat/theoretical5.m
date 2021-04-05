

V6f = V6r*cos((w*t)+V6phase);
V6t = V6n + V6f;

negative_t=-5e-3:1e-5:0;
total_t=[negative_t,t];
Vs_negative = Vs + 0*negative_t;
Vs_positive = sin(w*t);
V6_negative = V6 + 0*negative_t;
V6_positive = V6t;
Vs_total = [Vs_negative,Vs_positive];
V6_total = [V6_negative,V6_positive];

hf = figure (2);
plot (total_t, Vs_total, "b");
hold on
plot (total_t, V6_total, "r");

xlabel ("t [s]");
ylabel ("V_s(t) , V_6(t) [V]");
legend ('V_s(t)','V_6(t)','Location','Northeast')
print (hf, "total.eps", "-depsc");
