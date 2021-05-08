close all
clear all

pkg load symbolic;
format long;

%CHOSEN VALUES
C = 0.0005
R1 = 1300
R2 = 5300

%SET VALUES
freq=50;
Vs = 230;

%TRANSFORMER
n = 10;
Vr = Vs/n;

%VOLTAGE REGULATOR 
num_diodes = 22;
von = 0.6;
I_s = 1e-14;
Vt = 0.025;
diode_mat = 1;

T = 1/(2*freq); %FULL-WAVE RECTIFIER EFFECT
tOFF = (1/4)*T;  %INITIAL GUESS FOR TOFF
w = 2*pi*freq;

%NEWTON RAPHSON METHOD TO APPROXIMATE TOFF

for i = 1:10
  f = Vr*C*w*sin(w*tOFF) - (Vr/R1)*cos(w*tOFF) - I_s*(exp(12/(diode_mat*Vt*num_diodes))-1);
  df = Vr*C*(w^2)*cos(w*tOFF)+(Vr/R1)*w*sin(w*tOFF);
  tOFF = tOFF - (f/df);
end

tON = (3/4)*T; %INITIAL GUESS FOR TON

Req = 1/((1/R1)+(1/R2));

%NEWTON RAPHSON METHOD TO APPROXIMATE TON

for i = 1:10
  g = Vr*cos(w*tON)+Vr*cos(w*tOFF)*exp(-(1/(Req*C))*(tON-tOFF));
  dg = -w*Vr*sin(w*tON)-Vr*cos(w*tOFF)*(1/(Req*C))*exp(-(1/(Req*C))*(tON-tOFF));
  tON = tON - (g/dg);
end

t = 0:(1e-6):0.2;

l = length(t);

vO = zeros(1,l);

for i = 1:l
  if t(i)<=tOFF
    vO(i) = abs(Vr*cos(w*t(i)));
  else
    if t(i)<=tON
      vO(i) = Vr*abs(cos(w*tOFF))*exp(-((t(i)-tOFF)/(Req*C)));
    else
      tOFF = tOFF + T;
      tON = tON + T;
      if t(i)<=tOFF
        vO(i) = abs(Vr*cos(w*t(i)));
      else
        if t(i)<=tON
          vO(i) = Vr*abs(cos(w*tOFF))*exp(-((t(i)-tOFF)/(Req*C)));
        end
      end
    end
  end    
end


dc_vO = mean(vO)
ripple_env = max(vO) - min(vO);
vO_aux = (ripple_env/2) + min(vO);

vr = zeros(1, length(t));
vr = Vr * cos(w*t);
for i=1:length(t)
	vr(i) = abs(vr(i));
endfor

rd = (diode_mat*Vt)/(I_s*exp((12/num_diodes)/(diode_mat*Vt))); %DIODES RESISTANCE
ac_vO_fin = ((num_diodes*rd)/(num_diodes*rd + R2))*(vO - dc_vO);

if vO_aux >= 12
    dc_vO_fin = 12;
else
    dc_vO_fin = vO_aux;
end

vO_fin = ac_vO_fin + dc_vO_fin;

ripple_env = max(vO) - min(vO)
average_env = mean(vO)

average_reg = mean(vO_fin)
ripple_reg = max(vO_fin)-min(vO_fin)



%TABLES

printf ("chosen_values_TAB\n");
printf ("R1 = %e \n", R1);
printf ("R2 = %e \n", R2);
printf ("C = %e \n", C);
printf ("chosen_values_END\n\n");

printf ("envelope_TAB\n");
printf ("Ripple(envelope) = %e \n", ripple_env);
printf ("Average(envelope) = %e \n", average_env);
printf ("envelope_END\n\n");

printf ("regulator_TAB\n");
printf ("Ripple(regulator) = %e \n", ripple_reg);
printf ("Average(regulator) = %e \n", average_reg);
printf ("regulator_END\n\n");

%PLOTS
	
%VOLTAGE OUTPUTS AT RECTIFIER, ENVELOPE DETECTOR AND REGULATOR TERMINALS
hf = figure(1);
plot(t*1000, vr,"g");
hold on
plot(t*1000,vO, "r");
hold on
plot(t*1000,vO_fin,"b");
xlabel ("t[ms]");
ylabel ("vO [Volts]");
legend('vr', 'vO envelope', 'vO regulator', 'Location', 'northeast');
print (hf, "output.eps", "-depsc");
	
%AC COMPONENT 
hf = figure(2);
plot (t*1000, vO-12, "r");
hold on
plot(t*1000, vO_fin-12,"b");
xlabel ("t[ms]");
ylabel ("vO [Volts]");
legend('vO envelope - 12V', 'vO regulator - 12V',  'Location', 'northeast');
print (hf, "ac_component.eps", "-depsc");


