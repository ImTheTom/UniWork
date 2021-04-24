a=-5e-4;
b=0.5;
c=1000;
x1=(-b+sqrt(b^2-4*a*c))/(2*a)
x2=(-b-sqrt(b^2-4*a*c))/(2*a)
p = [-5e-4 0.5 1000];
root = roots (p)
x=[0:0.1:2000];
y=-5e-4*x.^2+0.5*x+1000;
MissileData=[x';y'];
M = max(y)
plot (x,y, 'r')
xlabel 'distance'
ylabel 'projectile height'
title 'Missile launched from a plane'
%(the graph does support the previous answers that were found.)%