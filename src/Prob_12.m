function [PP time_T]=Prob_12(P0,time_in,dt,n_step,fri_t)
load('data_1.mat')
M0=pi*5*5*500*0.850;
V0=pi*5*5*500;
%计算A口是否开启的flag
ti=0;
flag_A=zeros(1,n_step);
time_T=zeros(1,n_step);
for i=1:n_step
    time_T(i)=ti;
    if mod(ti,(10+time_in))<time_in
        flag_A(i)=1;
    else
        flag_A(i)=0;
    end
    ti=ti+dt;
end
%计算B口每个时间的流量
ti=0;
flag_B=zeros(1,n_step);
PP=zeros(1,n_step);
rh=zeros(1,n_step);
for i=1:n_step
    dda=mod(ti+fri_t,(100));
    if dda>=2.4
        flag_B(i)=0;
    else
        if (dda>=0.2)&(dda+dt<=2.2)%当前dt完全处于0.2-2.2的平台区域，概率最大
            flag_B(i)=20*dt;
        elseif (dda<=2.2)&(dda>=0.2)&(dda+dt>=2.2)%当前dt左侧处于0.2-2.2的平台区域，右侧2.2+进入新区域
            flag_B(i)=20*(2.2-dda)+(20+20-100*(dda+dt-2.2))*(dda+dt-2.2)*0.5;
        elseif (dda+dt<=0.2)%当前dt左侧处于0-0.2的平台区域，右侧2.2+
            flag_B(i)=(dda*100+(dda+dt)*100)*dt*0.5;
        elseif (dda<=0.2)&(dda+dt>=0.2)
            flag_B(i)=(dda*100+20)*(0.2-dda)*0.5+20*(dda+dt-0.2);
        elseif (dda>=2.2)&(dda<=2.4)
            flag_B(i)=(20-100*(dda-2.2)+20-100*(dda+dt-2.2))*dt*0.5;
        else (dda>=2.2)&(dda<=2.4)&(dda+dt>=2.4)
            flag_B(i)=(20-100*(dda-2.2))*(2.4-dda)*0.5;
        end
    end
    ti=ti+dt;
end
for i=1:n_step
    if i==1%第1步
        if flag_A(i)==1
            q=cal_Q(160,100,0.8711223);
            dV1=q*dt;
        else
            dV1=0;
        end
        dm=dV1*0.8711223-flag_B(i)*0.850;%计算当前dt内的质量改变
        M0=M0+dm;
        rh(i)=M0/V0;%密度
        PP(i)=find_P(rh(i),rho,P);%根据密度寻找对应的压力
    else
        if flag_A(i)==1
            q=cal_Q(160,PP(i-1),0.8711223);
            dV1=q*dt;
        else
            dV1=0;
        end
        dm=dV1*0.8711223-flag_B(i)*find_rho(PP(i-1),P,rho);%计算当前dt内的质量改变，减少的密度根据当前压力寻找
        M0=M0+dm;
        rh(i)=M0/V0;
        PP(i)=find_P(rh(i),rho,P);%根据密度寻找对应的压力
    end
end
