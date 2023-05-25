clc
clear
close all

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
k1 = 2.5746;
k2 = 8.7453;
k3 = 11.9425;
 

T=25;

um=0.013*T-0.129;
umc=0.013*T-0.129;

tspan=[0 25];
y0=[14 data1(1) 1.2 0.35];

[t,y1] = ode23(@(t,y) odefcn2(t,y,k1,k2,k3,kd,kdc,ks,ksc,ki,kic,b,V,Ffeed,sbvsin,svfain,um,umc),tspan,y0,options_sim);


% plot graf 2
k1 = 1.4551;
k2 = 4.55307;
k3 = 8.5571;

T=35;

um=0.013*T-0.129;
umc=0.013*T-0.129;

tspan=[0 25];
y0=[6 data2(1) 1.2 0.35];

[t,y2] = ode23(@(t,y) odefcn2(t,y,k1,k2,k3,kd,kdc,ks,ksc,ki,kic,b,V,Ffeed,sbvsin,svfain,um,umc),tspan,y0,options_sim);

% plot graf 3
k1 = 1.6538;
k2 = 5.5426;
k3 = 10.1;

T=55;

um=0.013*T-0.129;
umc=0.013*T-0.129;

tspan=[0 25];
y0=[14 data3(1) 1.2 0.35];

[t,y3] = ode23(@(t,y) odefcn2(t,y,k1,k2,k3,kd,kdc,ks,ksc,ki,kic,b,V,Ffeed,sbvsin,svfain,um,umc),tspan,y0,options_sim);


% plot graf 4
k1 = 2.7391;
k2 = 5.8608;
k3 = 7.2995;

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
xlim([0 15])
xlabel('Time [d]')
ylabel('VFA´s [g/L]')
title('Model 1')

subplot(2,2,2)

plot(t2,data2,'o')
hold on 
grid on
grid minor
plot(t,y2(:,2))
xlabel('Time [d]')
ylabel('VFA´s [g/L]')
xlim([0 15])
title('Model 2')

subplot(2,2,3)
plot(t3,data3,'o')
hold on 
grid on
grid minor
plot(t,y3(:,2))
xlim([0 15])
xlabel('Time [d]')
ylabel('VFA´s [g/L]')
title('Model 3')

subplot(2,2,4)
plot(t4,data4,'o')
hold on 
grid on
grid minor
plot(t,y4(:,2))
xlim([0 15])
xlabel('Time [d]')
ylabel('VFA´s [g/L]')
title('Model 4')

yp1=[y1(1,2) y1(301,2) y1(601,2) y1(901,2) y1(1201,2)];
er1=rms(data1'-yp1)/(max(data1))

pe1=100*abs(data1'-yp1)./data1';

yp2=[y2(1,2) y2(301,2) y2(601,2) y2(901,2) y2(1201,2)];
er2=rms(data2'-yp2)/(max(data2))

pe2=100*abs(data2'-yp2)./data2';

yp3=[y3(1,2) y3(201,2) y3(401,2) y3(601,2)];
er3=rms(data3'-yp3)/(max(data3))

pe3=100*abs(data3'-yp3)./data3';

yp4=[y4(1,2) y4(201,2) y4(401,2) y4(601,2)];
er4=rms(data4'-yp4)/(max(data4))

pe4=100*abs(data4'-yp4)./data4';

ye1=fitlm(t1,pe1')
yesal1=ye1.predict(t1);

ye2=fitlm(t2,pe2')
yesal2=ye2.predict(t2);

ye3=fitlm(t3,pe3')
yesal3=ye3.predict(t3);

ye4=fitlm(t4,pe4')
yesal4=ye4.predict(t4);

mean1=mean(pe1);
mean2=mean(pe2);
mean3=mean(pe3);
mean4=mean(pe4);

std1=std(pe1);
std2=std(pe2);
std3=std(pe3);
std4=std(pe4);

[h,pvalue1,ci] = ttest(pe1)
[h,pvalue2,ci] = ttest(pe2)
[h,pvalue3,ci] = ttest(pe3)
[h,pvalue4,ci] = ttest(pe4)

figure(2)
subplot(2,2,1)
normplot(pe1)
hold on
text(0,1.1,{['mean         ',num2str(mean1)];['std             ',num2str(std1)];['P-Value     ',num2str(pvalue1)]},'FontSize',7)
xlabel({'Difference between simulation';'and experiment data [%]'})
ylabel('Percent Error')
grid on
grid minor
title('Model 1')
set(gca,'FontSize',9)

subplot(2,2,2)
normplot(pe2)
hold on
text(0,1.1,{['mean         ',num2str(mean2)];['std             ',num2str(std2)];['P-Value     ',num2str(pvalue2)]},'FontSize',7)
xlabel({'Difference between simulation';'and experiment data [%]'})
ylabel('Percent Error')
grid on
grid minor 
title('Model 2')
set(gca,'FontSize',9)

subplot(2,2,3)
normplot(pe3)
hold on
text(0,1.1,{['mean         ',num2str(mean3)];['std             ',num2str(std3)];['P-Value     ',num2str(pvalue3)]},'FontSize',7)
xlabel({'Difference between simulation';'and experiment data [%]'})
ylabel('Percent Error')
grid on
grid minor
title('Model 3')
set(gca,'FontSize',9)

subplot(2,2,4)
normplot(pe4)
hold on
text(0,1,{['mean         ',num2str(mean4)];['std             ',num2str(std4)];['P-Value     ',num2str(pvalue4)]},'FontSize',7)
xlabel({'Difference between simulation';'and experiment data [%]'})
ylabel('Percent Error')
grid on
grid minor
title('Model 4')
set(gca,'FontSize',9)

