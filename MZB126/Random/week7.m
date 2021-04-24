%% Question 2
p1=10000;
p2=0;
o=1.0472;

a=[cos(o) 1 0 1 0 0; sin(o) 0 0 0 1 0;-cos(o) 0 cos(o) 0 0 0;-sin(o) 0 -sin(o) 0 0 0;0 -1 -cos(o) 0 0 0;0 0 sin(o) 0 0 1];
b=[0;0;-p2;p1;0;0];
x=a\b
x_test=a^-1*b

%% Question 5
p1=10000;
p2=0;
o=0.5;

a=[cos(o) 1 0 1 0 0; sin(o) 0 0 0 1 0;-cos(o) 0 cos(o) 0 0 0;-sin(o) 0 -sin(o) 0 0 0;0 -1 -cos(o) 0 0 0;0 0 sin(o) 0 0 1];
b=[0;0;-p2;p1;0;0];
x=a\b