function q=cal_Q(P1,P2,rho)
    q=0.85*pi*0.7*0.7*sqrt(2*abs(P1-P2)/rho);
	if imag(q) > 0
		q = 0;
	end
end
