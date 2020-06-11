function theA = find_A(t, time, A)

%%in
t = mod(t, max(time));
timeNew = time(find(time < t));
timeL = time(length(timeNew));
timeH = time(length(timeNew) + 1);
AL = A(length(timeNew));
AH = A(length(timeNew) + 1);

%%process
theA = (AH - AL) / (timeH - timeL) * (t - timeL) + AL;

%%out

end

