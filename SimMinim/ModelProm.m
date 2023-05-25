clc
clear
close all


k1 = 2.1057;
k2 = 6.1762;
k3 = 9.4749;

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
svsin=0
sbvsin=0
svfain=0

Ts=0.01;
options_sim=odeset('MaxStep',Ts);


t1=[0 3 6 9 12]';
data1=[1696 4296 5640 6672 6480]'/(1000);

t2=[0 3 6 9 12]';
data2=[492 1416 1776 1632 1344]'/(1000);

t3=[0 2 4 6]';
data3=[1360 3984 4704 3440]'/(1000);

t4=[0 2 4 6]';
data4=[705 3060 4200 2655]'/(1000);


% plot graf 1


T=25;

um=0.013*T-0.129;
umc=0.013*T-0.129;

tspan=[0 25];
y0=[14 data1(1) 1.2 0.35];

[t,y1] = ode23(@(t,y) odefcn2(t,y,k1,k2,k3,kd,kdc,ks,ksc,ki,kic,b,V,Ffeed,sbvsin,svfain,um,umc),tspan,y0,options_sim);


% plot graf 2

T=35;

um=0.013*T-0.129;
umc=0.013*T-0.129;

tspan=[0 25];
y0=[6 data2(1) 1.2 0.35];

[t,y2] = ode23(@(t,y) odefcn2(t,y,k1,k2,k3,kd,kdc,ks,ksc,ki,kic,b,V,Ffeed,sbvsin,svfain,um,umc),tspan,y0,options_sim);

% plot graf 3

T=55;

um=0.013*T-0.129;
umc=0.013*T-0.129;

tspan=[0 25];
y0=[14 data3(1) 1.2 0.35];

[t,y3] = ode23(@(t,y) odefcn2(t,y,k1,k2,k3,kd,kdc,ks,ksc,ki,kic,b,V,Ffeed,sbvsin,svfain,um,umc),tspan,y0,options_sim);


% plot graf 4
T=55;

um=0.013*T-0.129;
umc=0.013*T-0.129;

tspan=[0 25];
y0=[10 data4(1) 1.2 0.35];

[t,y4] = ode23(@(t,y) odefcn2(t,y,k1,k2,k3,kd,kdc,ks,ksc,ki,kic,b,V,Ffeed,sbvsin,svfain,um,umc),tspan,y0,options_sim);



figure(1)

subplot(2,2,1)

plot(t1,data1,'o')
hold on 
grid on
grid minor
plot(t,y1(:,2))
xlim([0 25])
xlabel('Tiempo [d]')
ylabel('AGV´s [g/L]')
title('Modelo 1')

subplot(2,2,2)

plot(t2,data2,'o')
hold on 
grid on
grid minor
plot(t,y2(:,2))
xlabel('Tiempo [d]')
ylabel('AGV´s [g/L]')
xlim([0 25])
title('Modelo 2')

subplot(2,2,3)
plot(t3,data3,'o')
hold on 
grid on
grid minor
plot(t,y3(:,2))
xlim([0 25])
xlabel('Tiempo [d]')
ylabel('AGV´s [g/L]')
title('Modelo 3')

subplot(2,2,4)
plot(t4,data4,'o')
hold on 
grid on
grid minor
plot(t,y4(:,2))
xlim([0 25])
xlabel('Tiempo [d]')
ylabel('AGV´s [g/L]')
title('Modelo 4')

yp1=[y1(1,2) y1(301,2) y1(601,2) y1(901,2) y1(1201,2)];
er1=rms(data1'-yp1)/(max(data1))

yp2=[y2(1,2) y2(301,2) y2(601,2) y2(901,2) y2(1201,2)];
er2=rms(data2'-yp2)/(max(data2))

yp3=[y3(1,2) y3(201,2) y3(401,2) y3(601,2)];
er3=rms(data3'-yp3)/(max(data3))

yp4=[y4(1,2) y4(201,2) y4(401,2) y4(601,2)];
er4=rms(data4'-yp4)/(max(data4))

erp=(er1+er2+er3+er4)/4