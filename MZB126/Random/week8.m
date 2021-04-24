% y(1) = y Y(2)= y'
TSPAN = [0,60];
Y0=[30;30];
[TOUT, YOUT]= ode45(@(t,y)[y(2);-0.02*y(1)-9.81*t], [0,60]; Y0);
plot (TOUT,YOUT)
xlabel('time')
ylabel('Theata')

