clear;
numExtend = 50;%延拓5个周期

%宏观寻找
%timeIn:减压阀开启时间
%time0:减压阀开启时刻
omega = 1:1:100;%单位1秒10弧度 0.01rad / 1ms
err = zeros(length(omega), length());
flag = zeros(628, 1);
parfor ii=1:length(omega)
for time0 = 1:628
	for time_In = 0:(628 - time_0)
		tic
		flag(time0:(time0 + timeIn)) = 1;
		Omega = omega(ii) * ones(1, 628 * numExtend)';
		pp = Prob_3(Omega, flag);
		toc
		err(ii) = sum(abs(pp-100));
	end
end
end
plot(omega, err);

