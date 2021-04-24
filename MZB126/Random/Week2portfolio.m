%% Plot the graph
x = 0:0.1:15;
y = 100*(1-exp(-0.11889*x));
figure
plot(x,y)
x1 = 0:0.1:50;
y1 = 100*(1-exp(-0.11889*x1));
figure
plot(x1,y1)

%% Distance
x = 0:0.1:5;
y1 = 100*(x+(exp(-0.11889*x)/0.11889))-841;
plot(x,y1)
#when y=100 x= 4.5 seconds

%% question 4
x1 = 0:0.1:10;
y1=8.32*x1+5.03;
y2 = 100*(1-exp(-0.11889*x1));
hold on
plot(x1,y2)
plot(x1,y1)
hold off
%% question 5
x1=1.7:0.1:5.2;
x2=0:0.1:5.2;
y1=8.32*x1+5.03;
y2 = 100*(1-exp(-0.11889*x2));
hold on
plot (x1,y1)
plot (x2,y2)
hold off
