clc
clear 
close all


initial_search_point=[25 10]
lower_bounds=[25 0]
upper_bounds=[55 20]

x=fmincon(@fun,initial_search_point,[],[],[],[], lower_bounds,upper_bounds)


topt = 0:0.01:20;
opt = myfunc(x);
otro1=myfunc([35 6]);
otro2=myfunc([35 10]);
otro3=myfunc([35 14]);
otro4=myfunc([35 18]);

otro12=myfunc([25 10]);
otro22=myfunc([35 10]);
otro32=myfunc([45 10]);
otro42=myfunc([55 10]);

t = 0:0.0025:40;

figure(1)

plot(t,otro12(1:16001)./10,'LineWidth',2)
hold on
grid on
grid minor
plot(t,otro22(1:16001)./10,'LineWidth',2)
plot(t,otro32(1:16001)./10,'LineWidth',2)
plot(t,otro42(1:16001)./10,'LineWidth',2)
xlim([0 15])
xlabel('Time [d]')
ylabel('VFA Yield [g/L]')
set(gca,'FontSize',12)
legend('T = 25 °C ; OLR = 10 gVS/L','T = 35 °C ; OLR = 10 gVS/L','T = 45 °C ; OLR = 10 gVS/L','T = 55 °C ; OLR = 10 gVS/L')


figure(2)
plot(t,otro1(1:16001)./6,'LineWidth',2)
hold on
grid on
grid minor
plot(t,otro2(1:16001)./10,'LineWidth',2)
plot(t,otro3(1:16001)./14,'LineWidth',2)
plot(t,otro4(1:16001)./18,'LineWidth',2)
xlim([0 15])
xlabel('Time [d]')
ylabel('VFA Yield [g/L]')
set(gca,'FontSize',12)

legend('T = 35 °C ; OLR = 6 gVS/L','T = 35 °C ; OLR = 10 gVS/L','T = 35 °C ; OLR = 14 gVS/L','T = 35 °C ; OLR = 18 gVS/L')


 figure(3)
    plot(t(1:8000),opt(1:8000)./(x(2)),'LineWidth',2)
    grid on
    grid minor
    xlabel('Time [d]')
    ylabel('VFA Yield [g/L]')
    set(gca,'FontSize',12)
    legend('T = 55 °C ; OLR = 20 gVS/L')
    xlim([0 8])    

function maximo=fun(pars)
    y=myfunc(pars);
    maximo=(-max(y))/pars(2);
end


 function output = myfunc(pars)
        k1 = 2.1057;
        k2 = 6.1762;
        k3 = 8.4749;
        T=pars(1);
        kd=0.02;
        kdc=0.02;
        ks=15.5;
        ksc=3;
        ki=12;
        kic=6;
        b=3;
        V=1;
        Ffeed=0;
        sbvsin=0;
        svfain=0;
        um=0.013*T-0.129;
        umc=0.013*T-0.129;

        function dydt = odefcn(t,y)
            
            uc=umc/((ksc/y(2))+1);
            u=um/((ks/y(1))+1);
            
            dydt=zeros(4,1);
            dydt(1)=(sbvsin-y(1))*(Ffeed/V)-(u*k1*y(3));
            dydt(2)=(svfain-y(2))*(Ffeed/V)+(u*k2*y(3))-(uc*k3*y(4));
            dydt(3)=(u-kd-((Ffeed/b)/V))*y(3);
            dydt(4)=(uc-kdc-((Ffeed/b)/V))*y(4);
            end

        t1=[0 40];
        Ts=0.01;
        options_sim=odeset('MaxStep',Ts);
        y0=[pars(2) 0 1.2 0.35];
        [t,y] = ode45(@odefcn,t1,y0,options_sim);
        output = y(:,2);
    end 