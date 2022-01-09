f = @(x) [2*sqrt(x).*(0<=x & x<1) + (3-x).*(1<=x & x<=3)];
x = linspace(0,3);
intvl = [-6 6];
pfx = repmat(f(x),1,diff(intvl)/3);
px = linspace(intvl(1),intvl(2),length(pfx));
figure(1)
plot(px, pfx)
grid