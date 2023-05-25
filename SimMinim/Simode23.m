clc
clear 
close all

k1=24.13;
k2=36.83;
k3=7.8;% variable 
k5=0;
kd=0.02;
kdc=0.02;
ks=15.5;
ksc=3;
ki=12;
kic=6;
b=6;

V=0.2;
Ffeed=0;
Xmeth=0.35;
Xacid=1.2;
T=55;
svsin=0
sbvsin=0
svfain=0

um=0.013*T-0.129;
umc=0.013*T-0.129;
Ts=0.01;
options_sim=odeset('MaxStep',Ts);

parametros=[k1,k2,k3,kd,kdc,ks,ksc,ki,kic,b,V,Ffeed,sbvsin,svfain,um,umc];

tspan=[0 20];
y0=[6 10.24 1.2 0.35];

[t,y] = ode23(@(t,y) odefcn2(t,y,k1,k2,k3,kd,kdc,ks,ksc,ki,kic,b,V,Ffeed,sbvsin,svfain,um,umc),tspan,y0,options_sim);

Sb=y(:,1);
Sv=y(:,2);
Xa=y(:,3);
Xm=y(:,4);


uc=(umc)./((ksc./Sv)+1);

u=(um)./((ks./Sb)+1);
%%
Fm=V*k5*uc.*Xm;

figure(1)
plot(t,Fm(:,1))
ylabel('Methane flow [L/d]')
grid on
grid minor

xlabel('Time [d]')

figure(2)

plot(t,Sv)
grid on
grid minor
xlabel('Time [d]')

figure(3)

plot(t,Sb)
grid on
grid minor
xlabel('Time [d]')



