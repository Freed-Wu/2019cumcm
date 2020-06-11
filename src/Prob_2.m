function pp = Prob_2(omega)
%单字母变量 油泵
%双字母变量 油管

load('data_1.mat');
load('distAndStroke0.mat');

%%in
[distaMin, index] = min(dista);
dista = [dista(index:length(dista)); dista(1:index - 1)];
t = cal_t(theta, omega);
V = cal_V(dista);
dt = zeros(1, length(t));
for i = 2:length(t)
	dt(i)=t(i) - t(i - 1);
end
Area = cal_A(stroke);
A = zeros(1, length(t));
qq = zeros(1, length(t));
for i = 1:length(t)
	A(i) = find_A(t(i), time, Area);
end
atm = 0.101325;%标准大气压

m = zeros(1, length(V));%质量
q = zeros(1, length(V));%流量
p = zeros(1, length(V));%压力
pp = zeros(1, length(V));
mm = zeros(1, length(V));
r = zeros(1, length(V));%密度
rr = zeros(1, length(V));
p(1) = 0.5;
r(1) = find_rho(p(1),P,rho);
m(1) = V(1) * r(1);%初始质量
q(1) = 0;
pp(1) = 100;
mm(1)=pi*5*5*500*0.850;
rr(1) = find_rho(pp(1), P, rho);
V0=pi*5*5*500;

%%procsee
for i = 1:length(V)
	r(i) = m(i) / V(i);
	p(i) = min(find_P(r(i),rho,P));
	q(i) = max(cal_Q(p(i), pp(i), r(i)), 0);%单向阀
	if(i < length(V))
		m(i + 1) = m(i) - r(i) * q(i) * dt(i);%更新
	end
	rr(i) = mm(i) / V0;
	pp(i) = min(find_P(rr(i), rho, P));
	qq(i) = cal_Q_by_A(pp(i), atm, rr(i), A(i));
	if(i < length(V))
		mm(i + 1) = mm(i) + r(i) * q(i) * dt(i) - rr(i) * qq(i) * dt(i);
	end
end

%%out
pp = real(pp);
plot(1:length(pp), pp);

end

