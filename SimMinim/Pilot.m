clc
clear
close all


k1 = 2.1057;
k2 = 6.1762;
k3 = 8.4749;


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


t1=[0 3 5 7 9 11 13 16]';
data1=[1704 4248 5088 5160 5352 6024 6456 6144]'/(1000);
data2=[1704 4368 5544 5928 5640 6192 6408 5568]'/(1000);
data3=[1704 4152 5088 5328 5712 6432 6792 6432]'/(1000);


T=25;

um=0.013*T-0.129;
umc=0.013*T-0.129;

tspan=[0 25];
y0=[14 data1(1) 1.2 0.35];

[t,y] = ode23(@(t,y) odefcn2(t,y,k1,k2,k3,kd,kdc,ks,ksc,ki,kic,b,V,Ffeed,sbvsin,svfain,um,umc),tspan,y0,options_sim);

figure(1)

plot(t1,data1,'o')
hold on 
grid on
grid minor
plot(t,y(:,2))
xlim([0 20])
xlabel('Time [d]')
ylabel('VFA´s [g/L]')


figure(2)

plot(t1,data2,'o')
hold on 
grid on
grid minor
plot(t,y(:,2))
xlim([0 20])
xlabel('Time [d]')
ylabel('VFA´s [g/L]')


figure(3)

plot(t1,data3,'o')
hold on 
grid on
grid minor
plot(t,y(:,2))
xlim([0 20])
xlabel('Time [d]')
ylabel('VFA´s [g/L]')


figure(4)
subplot(2,2,1)
plot(t1,data1,'o')
hold on 
grid on
grid minor
plot(t,y(:,2))
xlim([0 20])
xlabel('Time [d]')
ylabel('VFA´s [g/L]')
title('Reactor 1')

subplot(2,2,2)
plot(t1,data2,'o')
hold on 
grid on
grid minor
plot(t,y(:,2))
xlim([0 20])
xlabel('Time [d]')
ylabel('VFA´s [g/L]')
title('Reactor 2')

subplot(2,5,7:9)
plot(t1,data3,'o')
hold on 
grid on
grid minor
plot(t,y(:,2))
xlim([0 20])
xlabel('Time [d]')
ylabel('VFA´s [g/L]')
title('Reactor 3')



yp=[y(1,2) y(301,2) y(501,2) y(701,2) y(901,2) y(1101,2) y(1301,2) y(1601,2)];
er1=rms(data1'-yp)/(max(data1))
er2=rms(data2'-yp)/(max(data2))
er3=rms(data3'-yp)/(max(data3))

pe1=100*abs(data1'-yp)./data1';
pe2=100*abs(data2'-yp)./data2';
pe3=100*abs(data3'-yp)./data3';

ye1=fitlm(abs(data1'-yp),pe1')
yesal1=ye1.predict(t1);

ye2=fitlm(abs(data2'-yp),pe2')
yesal2=ye2.predict(t1);

ye3=fitlm(abs(data3'-yp),pe3')
yesal3=ye3.predict(t1);

mean1=mean(pe1);
mean2=mean(pe2);
mean3=mean(pe3);

std1=std(pe1);
std2=std(pe2);
std3=std(pe3);

[h,pvalue1,ci] = ttest(pe1)
[h,pvalue2,ci] = ttest(pe2)
[h,pvalue3,ci] = ttest(pe3)


figure(5)
subplot(2,2,1)
normplot(pe1)
hold on
text(0,1.1,{['mean         ',num2str(mean1)];['std             ',num2str(std1)];['P-Value     ',num2str(pvalue1)]},'FontSize',7)
xlabel({'Difference between simulation';'and experiment data [%]'})
ylabel('Percent Error')
grid on
grid minor
title('Reactor 1')
set(gca,'FontSize',9)

subplot(2,2,2)
normplot(pe1)
hold on
text(0,1.1,{['mean         ',num2str(mean2)];['std             ',num2str(std2)];['P-Value     ',num2str(pvalue2)]},'FontSize',7)
xlabel({'Difference between simulation';'and experiment data [%]'})
ylabel('Porcentaje')
ylabel('Percent Error')
grid on
grid minor 
title('Reactor 2')
set(gca,'FontSize',9)

subplot(2,5,7:9)
normplot(pe1)
hold on
text(0,1.1,{['mean         ',num2str(mean3)];['std             ',num2str(std3)];['P-Value     ',num2str(pvalue3)]},'FontSize',7)
xlabel({'Difference between simulation';'and experiment data [%]'})
ylabel('Porcentaje')
ylabel('Percent Error')
grid on
grid minor
title('Reactor 3')
set(gca,'FontSize',9)

