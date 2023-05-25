function dydt = odefcn(t,y,k1,k2,k3,kd,kdc,ks,ksc,ki,kic,b,V,Ffeed,sbvsin,svfain,um,umc)

% if  t>=100 
% Ffeed=40;
% 
% end

uc=umc/((ksc/y(2))+1);
u=um/((ks/y(1))+1);


dydt=zeros(4,1);
dydt(1)=(sbvsin-y(1))*(Ffeed/V)-(u*k1*y(3));
dydt(2)=(svfain-y(2))*(Ffeed/V)+(u*k2*y(3))-(uc*k3*y(4));
dydt(3)=(u-kd-((Ffeed/b)/V))*y(3);
dydt(4)=(uc-kdc-((Ffeed/b)/V))*y(4);
end