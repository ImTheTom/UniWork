%% Graph
x=0:0.1:30;
y=exp(-0.01.*x).*(30.*cos(3.13.*x)-3.13.*sin(3.13.*x));
plot(x,y)
ylabel('Theta')
xlabel('time(s)')
title('question2')

%% Test part 2
x=0:0.1:70;
y=exp(-0.0118.*x).*(30.*cos(6.26.*x)-6.26.*sin(6.26.*x));
plot(x,y)