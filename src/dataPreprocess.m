function dataPreprocess(numExtend)

%%in
%numExtend = 5;%ÑÓÍØ5¸öÖÜÆÚ

%%procsee
load distAndStroke0.mat
[distaMin, index] = min(dista);
dista = [dista(index:length(dista)); dista(1:index - 1)];
distanew = [];
thetanew = [];
for kk = 1:numExtend
	distanew = [distanew; dista];
	thetanew = [thetanew; theta + 6.28 * (kk - 1)];
end
dista = distanew;
theta = thetanew;
V = cal_V(dista);

%%out
clear index;
clear distaMin;
clear distanew;
clear thetanew;
clear numExtend;
clear kk;
clear dista;
save distAndStroke.mat

end

