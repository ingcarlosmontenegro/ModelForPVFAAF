function dydt = odefcn(t,y,k1,k2,k3,kd,kdc,ks,ksc,ki,kic,b,V,Ffeed,sbvsin,svfain,um,umc)

% if  t>=100 
% Ffeed=40;
% 
% end

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

T=Temp(t);

um=0.013*T-0.129;
umc=0.013*T-0.129;
uc=umc/((ksc/y(2))+1);
u=um/((ks/y(1))+1);


Ff=f(t)+1;

dydt=zeros(4,1);
dydt(1)=(sbvsin-y(1))*(Ff/V)-(u*k1*y(3));
dydt(2)=(svfain-y(2))*(Ff/V)+(u*k2*y(3))-(uc*k3*y(4));
dydt(3)=(u-kd-((Ff/b)/V))*y(3);
dydt(4)=(uc-kdc-((Ff/b)/V))*y(4);
end