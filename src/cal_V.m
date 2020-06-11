function [V] = cal_V(dist)

%%in
V_r = 20;%²ĞÓàÌå»ı
d = 5;%ÓÍ±ÃÖ±¾¶

%%procsee
V = V_r + dist * pi * d^2 / 4;

%%out

end

