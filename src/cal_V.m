function [V] = cal_V(dist)

%%in
V_r = 20;%�������
d = 5;%�ͱ�ֱ��

%%procsee
V = V_r + dist * pi * d^2 / 4;

%%out

end

