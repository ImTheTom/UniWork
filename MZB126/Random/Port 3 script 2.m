%% question 2
TSPAN = [0,60];
Y0=[30;30];
[TOUT, YOUT]= ode45(@(t,y)[y(2);-0.02*y(1)-9.81*y(2)],TSPAN, Y0);
plot (TOUT,YOUT(:,1))
xlabel('time')
ylabel('Theata')

%% question 3
TSPAN = [0,60];
Y0=[30;0];
[TOUT, YOUT]= ode45(@(t,y)[y(2);-0.02*y(2)-9.81*sind(y(1))],TSPAN, Y0);
plot (TOUT,YOUT(:,1))
xlabel('time')
ylabel('Theata')

%% question 4
TSPAN = [0,60];
Y0=[150;0];
[TOUT, YOUT]= ode45(@(t,y)[y(2);-0.02*y(2)-9.81*y(1)],TSPAN, Y0);
plot (TOUT,YOUT(:,1))
xlabel('time')
ylabel('Theata')

%% question 5
TSPAN = [0,60];
Y0=[150;0];
[TOUT, YOUT]= ode45(@(t,y)[y(2);-0.02*y(2)-9.81*sind(y(1))],TSPAN, Y0);
plot (TOUT,YOUT(:,1))
xlabel('time')
ylabel('Theata')
