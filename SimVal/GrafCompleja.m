clc
clear
close all

t=0:0.01:200;

load DGrara.mat

for i=1:20001
    Ffeed(i)=f(i*0.01);
    T(i)=Temp(i*0.01); 
end

figure(1)

subplot(3,1,1)
plot(t,Ffeed,'LineWidth',1.5)
grid on
grid minor
xlim([39 81])
legend('Ffeed')
ylabel('L/d')
set(gca,'fontsize',12)

subplot(3,1,2)
plot(t,Fm(1:20001),'LineWidth',1.5)
grid on
grid minor
xlim([39 81])
ylim([50 300])
legend('Methane Flow')
ylabel('L/d')
set(gca,'fontsize',12)

subplot(3,1,3)
plot(t,T,'LineWidth',1.5)
grid on
grid minor
xlim([39 81])
ylim([20 40])
legend('Temperature')
ylabel('°C')
xlabel('Time [d]')

set(gca,'fontsize',12)

function y=f(t) 
y1=25.*(0<=t & t<=44); 
y2=10.*(44<t & t<=48);
y3=25.*(48<t & t<=51);
y4=0.*(51<t & t<=51.25);
y5=25.*(51.25<t & t<=62.75);
y6=0.*(62.75<t & t<=63);
y7=25.*(63<t & t<=65);
y8=0.*(65<t & t<=65.1);
y9=25.*(65.1<t & t<=76.5);
y10=50.*(76.5<t & t<=200);
y=y1+y2+y3+y4+y5+y6+y7+y8+y9+y10; 
end

function y=Temp(t) 
y1=24.*(0<=t & t<=60); 
y2=30.*(60<t & t<=67);
y3=35.*(67<t & t<=200);
y=y1+y2+y3;
end
