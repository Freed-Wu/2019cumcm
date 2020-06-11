function q=cal_Q_by_A(P1,P2,rho, A)
q=0.85*A*sqrt(2*abs(P1-P2)/rho);
if imag(q) > 0
		q = 0;
	end
end
