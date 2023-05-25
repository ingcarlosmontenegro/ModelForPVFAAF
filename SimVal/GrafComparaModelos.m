clc
clear 
close all

load Comparacion.mat

t=0:0.01:200;

figure(1)

plot(t,Fm(1:20001),'LineWidth',2.5)
hold on
plot(out.tout,out.FSimulink,'--','LineWidth',2.5)
yline(196.156,'k','Ref','LineWidth',1.5,"FontSize",14);
grid on
grid minor 
xlim([0 150])
ylim([0 220])
ylabel("Methane Flow [L/d]",'Interpreter','latex')
xlabel("Time [d]",'Interpreter','latex')
legend('ode23','Simulink')
set(gca, "FontSize",14)