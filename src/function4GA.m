function [err] = function4GA( omega)

%%in
numExtend = 50;%����5������
N = 1;
time0=0;
timeIn=0;
%%procsee
%���Ѱ��
%timeIn:��ѹ������ʱ��
%time0:��ѹ������ʱ��
%omega��λ1��10���� 0.01rad / 1ms
flag = zeros(628, 1);
if time0 ~= 0
	flag(time0:(time0 + timeIn)) = 1;
end
Omega = omega * ones(1, 628 * numExtend)';
pp = Prob_3(Omega, flag, N);
err = sum(abs(pp-100));

%%out

end

