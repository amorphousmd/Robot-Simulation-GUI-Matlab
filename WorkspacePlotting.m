% This code can plot the workspace of a 2R planar robot 
% this code is written by Madi Babaiasl

% number of samples
N = 1000;

% link lengths
l1 = 15.6;
l2 = 9.2;
l3 = 13;

% joint angle limitations

theta1_min = 0;
theta1_max = 180;

theta2_min = 0;
theta2_max = 180;

theta3_min = 0;
theta3_max = 180;


% limitations on theta1
theta1_start_end = [theta1_min,theta1_max];
% change the angle to Radians
theta1_start_end = theta1_start_end*pi/180;

% limitations on theta2
theta2_start_end =[theta2_min,theta2_max];
% change the angle to Radians
theta2_start_end = theta2_start_end*pi/180;

% limitations on theta3
theta3_start_end =[theta3_min,theta3_max];
% change the angle to Radians
theta3_start_end = theta3_start_end*pi/180;


% joint angles 
theta1 = linspace(theta1_min,theta1_max,N);
% change the angle to Radians
theta1 = theta1*pi/180;

theta2 = linspace(theta2_min,theta2_max,N);
% change the angle to Radians
theta2 = theta2*pi/180;

theta3 = linspace(theta3_min,theta3_max,N);
% change the angle to Radians
theta3 = theta3*pi/180;

%intialization of the x and y
x = zeros(6*length(theta1_start_end),length(theta2));
y = zeros(6*length(theta1_start_end),length(theta2));

% x and y are calculated using kinematics

% Constant theta 2, 3
% Min, Min
for j = 1:length(theta1)
    x(1,j) = l1*cos(theta1(j)) + l2*cos(theta1(j) + theta2_start_end(1)) ... 
           + l3*cos(theta1(j) + theta2_start_end(1) + theta3_start_end(1));
    y(1,j) = l1*sin(theta1(j)) + l2*sin(theta1(j) + theta2_start_end(1)) ... 
           + l3*sin(theta1(j) + theta2_start_end(1) + theta3_start_end(1));
end

% Min, Max
for j = 1:length(theta1)
    x(2,j) = l1*cos(theta1(j)) + l2*cos(theta1(j) + theta2_start_end(1)) ... 
           + l3*cos(theta1(j) + theta2_start_end(1) + theta3_start_end(2));
    y(2,j) = l1*sin(theta1(j)) + l2*sin(theta1(j) + theta2_start_end(1)) ... 
           + l3*sin(theta1(j) + theta2_start_end(1) + theta3_start_end(2));
end

% % Max, Min
for j = 1:length(theta1)
    x(3,j) = l1*cos(theta1(j)) + l2*cos(theta1(j) + theta2_start_end(2)) ... 
           + l3*cos(theta1(j) + theta2_start_end(2) + theta3_start_end(1));
    y(3,j) = l1*sin(theta1(j)) + l2*sin(theta1(j) + theta2_start_end(2)) ... 
           + l3*sin(theta1(j) + theta2_start_end(2) + theta3_start_end(1));
end
% 
% Max, Max
for j = 1:length(theta1)
    x(4,j) = l1*cos(theta1(j)) + l2*cos(theta1(j) + theta2_start_end(2)) ... 
           + l3*cos(theta1(j) + theta2_start_end(2) + theta3_start_end(2));
    y(4,j) = l1*sin(theta1(j)) + l2*sin(theta1(j) + theta2_start_end(2)) ... 
           + l3*sin(theta1(j) + theta2_start_end(2) + theta3_start_end(2));
end


% Constant theta 1, 3
% Min, Min
for k = 1:length(theta1)
     x(5,k) = l1*cos(theta1_start_end(1)) + l2*cos(theta1_start_end(1) + theta2(k)) ...
            + l3*cos(theta1_start_end(1) + theta2(k) + theta3_start_end(1));
     y(5,k) = l1*sin(theta1_start_end(1)) + l2*sin(theta1_start_end(1) + theta2(k)) ...
            + l3*sin(theta1_start_end(1) + theta2(k) + theta3_start_end(1));
end

% Min, Max
for k = 1:length(theta1)
     x(6,k) = l1*cos(theta1_start_end(1)) + l2*cos(theta1_start_end(1) + theta2(k)) ...
            + l3*cos(theta1_start_end(1) + theta2(k) + theta3_start_end(2));
     y(6,k) = l1*sin(theta1_start_end(1)) + l2*sin(theta1_start_end(1) + theta2(k)) ...
            + l3*sin(theta1_start_end(1) + theta2(k) + theta3_start_end(2));
end

% Max, Min
for k = 1:length(theta1)
     x(7,k) = l1*cos(theta1_start_end(2)) + l2*cos(theta1_start_end(2) + theta2(k)) ...
            + l3*cos(theta1_start_end(2) + theta2(k) + theta3_start_end(1));
     y(7,k) = l1*sin(theta1_start_end(2)) + l2*sin(theta1_start_end(2) + theta2(k)) ...
            + l3*sin(theta1_start_end(2) + theta2(k) + theta3_start_end(1));
end

% Max, Max
for k = 1:length(theta1)
     x(8,k) = l1*cos(theta1_start_end(2)) + l2*cos(theta1_start_end(2) + theta2(k)) ...
            + l3*cos(theta1_start_end(2) + theta2(k) + theta3_start_end(2));
     y(8,k) = l1*sin(theta1_start_end(2)) + l2*sin(theta1_start_end(2) + theta2(k)) ...
            + l3*sin(theta1_start_end(2) + theta2(k) + theta3_start_end(2));
end

% Constant theta 1, 2
% Min, Min
for k = 1:length(theta1)
     x(9,k) = l1*cos(theta1_start_end(1)) + l2*cos(theta1_start_end(1) + theta2_start_end(1)) ...
            + l3*cos(theta1_start_end(1) + theta2_start_end(1) + theta3(k));
     y(9,k) = l1*sin(theta1_start_end(1)) + l2*sin(theta1_start_end(1) + theta2_start_end(1)) ...
            + l3*sin(theta1_start_end(1) + theta2_start_end(1) + theta3(k));
end

% Min, Max
for k = 1:length(theta1)
     x(10,k) = l1*cos(theta1_start_end(1)) + l2*cos(theta1_start_end(1) + theta2_start_end(2)) ...
            + l3*cos(theta1_start_end(1) + theta2_start_end(2) + theta3(k));
     y(10,k) = l1*sin(theta1_start_end(1)) + l2*sin(theta1_start_end(1) + theta2_start_end(2)) ...
            + l3*sin(theta1_start_end(1) + theta2_start_end(2) + theta3(k));
end

% Max, Min
for k = 1:length(theta1)
     x(11,k) = l1*cos(theta1_start_end(2)) + l2*cos(theta1_start_end(2) + theta2_start_end(1)) ...
            + l3*cos(theta1_start_end(2) + theta2_start_end(1) + theta3(k));
     y(11,k) = l1*sin(theta1_start_end(2)) + l2*sin(theta1_start_end(2) + theta2_start_end(1)) ...
            + l3*sin(theta1_start_end(2) + theta2_start_end(1) + theta3(k));
end

% Max, Max
for k = 1:length(theta1)
     x(12,k) = l1*cos(theta1_start_end(2)) + l2*cos(theta1_start_end(2) + theta2_start_end(2)) ...
            + l3*cos(theta1_start_end(2) + theta2_start_end(2) + theta3(k));
     y(12,k) = l1*sin(theta1_start_end(2)) + l2*sin(theta1_start_end(2) + theta2_start_end(2)) ...
            + l3*sin(theta1_start_end(2) + theta2_start_end(2) + theta3(k));
end


x = x';
y = y';


%plotting
% plot(x(:,1),y(:,1),'b','LineWidth',2)
% % plot(x(:,2),y(:,2),'b','LineWidth',2)
% % plot(x(:,3),y(:,3),'b','LineWidth',2)
% plot(x(:,4),y(:,4),'b','LineWidth',2)
% % plot(x(:,5),y(:,5),'b','LineWidth',2)
% plot(x(:,6),y(:,6),'b','LineWidth',2)
% plot(x(:,7),y(:,7),'b','LineWidth',2)
% % plot(x(:,8),y(:,8),'b','LineWidth',2)
% plot(x(:,9),y(:,9),'b','LineWidth',2)
% % plot(x(:,10),y(:,10),'b','LineWidth',2)
% % plot(x(:,11),y(:,11),'b','LineWidth',2)
% plot(x(:,12),y(:,12),'b','LineWidth',2)
% 
% plot(x(:,1),y(:,1),'b','LineWidth',2)
% plot(x(:,2),y(:,2),'b','LineWidth',2)
% plot(x(:,3),y(:,3),'b','LineWidth',2)
% plot(x(:,4),y(:,4),'b','LineWidth',2)
% plot(x(:,5),y(:,5),'b','LineWidth',2)
% plot(x(:,6),y(:,6),'b','LineWidth',2)
% plot(x(:,7),y(:,7),'b','LineWidth',2)
% plot(x(:,8),y(:,8),'b','LineWidth',2)
% plot(x(:,9),y(:,9),'b','LineWidth',2)
% plot(x(:,10),y(:,10),'b','LineWidth',2)
% plot(x(:,11),y(:,11),'b','LineWidth',2)
% plot(x(:,12),y(:,12),'b','LineWidth',2)

X = x';
X = X(:);
Y = y';
Y = Y(:);
k = boundary(X,Y,1);
u = X(k)
s = plot(X(k),Y(k),'r','LineWidth',2);
