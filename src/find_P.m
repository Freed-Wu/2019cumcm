function Q=find_P(rh,rho,P)
q=abs(rho-rh);
m1=find(q==min(q));
if rho(m1)>rh
		m=m1-1;
		n=m1;
	else
		m=m1;
		n=m+1;
	end
	if m>0 && n>0 && m<=length(rho) && n<= length(rho)
		d=(rh-rho(m))/(rho(n)-rho(m));
		Q=(P(n)-P(m))*d+P(m);
    elseif n>0 && n<=length(rho)
		Q=P(n);
    else
        Q=P(length(rho));
	end
end
