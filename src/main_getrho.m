load('data.mat')
[a y_new err]=Le_Sq(x,y,6);%进行弹性模量和压力的耦合，x压力，y弹性模量
%四阶龙哥库达法
syms xx
f=1/(a(1)+a(2)*xx^1+a(3)*xx^2+a(4)*xx^3+a(5)*xx^4+a(6)*xx^5+a(7)*xx^6);
%向前龙哥库达
h=-0.001;
n=100000;
P_fo=zeros(1,n+1);
rho_fo=zeros(1,n+1);
P_fo(1)=100;
rho_fo(1)=0.850;
for ii=2:n+1
    P_fo(ii)=P_fo(ii-1)+h;
    k1=rho_fo(ii-1)*subs(f,xx,P_fo(ii-1));
    k2=(rho_fo(ii-1)+h/2*k1)*subs(f,xx,P_fo(ii-1)+h/2);
    k3=(rho_fo(ii-1)+h/2*k2)*subs(f,xx,P_fo(ii-1)+h/2);
    k4=(rho_fo(ii-1)+h*k3)*subs(f,xx,P_fo(ii-1)+h);
    rho_fo(ii)=rho_fo(ii-1)+h/6*(k1+2*k2+2*k3+k4);
end
%向后龙哥库达
h=0.001;
n=100000;
P_back=zeros(1,n+1);
rho_back=zeros(1,n+1);
P_back(1)=100;
rho_back(1)=0.850;
for ii=2:n+1
    P_back(ii)=P_back(ii-1)+h;
    k1=rho_back(ii-1)*subs(f,xx,P_back(ii-1));
    k2=(rho_back(ii-1)+h/2*k1)*subs(f,xx,P_back(ii-1)+h/2);
    k3=(rho_back(ii-1)+h/2*k2)*subs(f,xx,P_back(ii-1)+h/2);
    k4=(rho_back(ii-1)+h*k3)*subs(f,xx,P_back(ii-1)+h);
    rho_back(ii)=rho_back(ii-1)+h/6*(k1+2*k2+2*k3+k4);
end