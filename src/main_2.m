clear;
%���Ѱ��
omega = 0.1:0.1:20;%��λ1��10���� 0.01rad / 1ms
err = zeros(1, length(omega));
parfor ii=1:length(omega)
tic
Omega = omega(ii) * ones(1, 628)';
pp = Prob_2(Omega);
toc
err(ii) = sum(abs(pp-100));
end
plot(omega, err);

