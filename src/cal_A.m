function [A] = cal_A(h)
%�õ��뷧���

%%in
theta = 9;
d = 2.5;

%%process
A = pi * cosd(theta) * ((h * sind(theta) + d / 2 / cosd(theta)).^2 - (d / 2 / cosd(theta)).^2);

%%out

end

