function [t] = cal_t(theta, omega)

%%in

t=zeros(1,length(omega));
dt=zeros(1,length(omega));
theta = [theta; 6.28];

%%procsee
for i = 1:length(omega)
	dt(i) = (theta(i + 1) - theta(i)) / omega(i);
	t(i) = sum(dt);
end

%%out

end

