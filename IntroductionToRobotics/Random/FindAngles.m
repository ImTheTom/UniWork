function angles = FindAngles(x,y,z)

h = 53.0;
r = 30.309;
l2 = 170.384;
l3 = 136.307;
l4 = 86.0;
c = 40.0;
z= z+l4+c;
T = sqrt(x^2+y^2);

D = ((T-r)^2+(z)^2-l2^2-l3^2)/(2*l2*l3);

theta0 = atan2(y,x);
if y<0 && x>0
    theta0 = atan2(x,y);
elseif x<0 && y>0
    theta0 = atan2(x,y);
end
theta0 = theta0+pi;

try
    theta2(1) = atan2(-sqrt(1-D^2),D);
    theta2(2) = atan2(sqrt(1-D^2),D);
catch
    try
        theta2(1) = atan2(-sqrt(1-D^2),D);
    catch
        theta2(1) = atan2(sqrt(1-D^2),D);
    end
end

theta1 = atan2(T-r,z-h) - atan2(l3*sin(theta2(1)),l2+l3*cos(theta2(1)));

theta2 = pi+theta2(1);

l5 = sqrt((T-r)^2+(z-h-l4-c)^2);

l6squared = (l2^2+l3^2)-(2*l3*l2)*cos(theta2);
l6 = sqrt(l6squared);

cosp = (l3^2+l6^2-l2^2)/(2*l3*l6);
p = acos(cosp);

cosi = ((l4)^2+l6^2-l5^2)/(2*l6*l4);
i = acos(cosi);


theta3 = i+p;

theta0 = round(rad2deg(theta0));
theta1 = round(rad2deg(theta1));
theta2 = round(rad2deg(theta2));
theta3 = round(rad2deg(theta3));

angles(1) = theta0;
angles(2) = theta1;
angles(3) = theta2;
angles(4) = theta3;
end