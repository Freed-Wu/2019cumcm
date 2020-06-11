function [err] = function4GA( omega)

%%in
numExtend = 50;%延拓5个周期
N = 1;
time0=0;
timeIn=0;
%%procsee
%宏观寻找
%timeIn:减压阀开启时间
%time0:减压阀开启时刻
%omega单位1秒10弧度 0.01rad / 1ms
flag = zeros(628, 1);
if time0 ~= 0
	flag(time0:(time0 + timeIn)) = 1;
end
Omega = omega * ones(1, 628 * numExtend)';
pp = Prob_3(Omega, flag, N);
err = sum(abs(pp-100));

%%out

end

