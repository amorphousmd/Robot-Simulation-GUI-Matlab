function [output] = inverseJacobianConcat(theta1, theta2, theta3, theta4)
% This Jacobian is calculated by remove the 4th and 6th row of matrix
yOffsetMatrix = [1 0 0 0,
                0 1 0 -2.4,
                0 0 1 0,
                0 0 0 1];
T1 = createDHmatrix(0, pi/2 , 7.7, theta1);
T2 = createDHmatrix(12.8, 0 , 0, theta2);
T3 = createDHmatrix(12.4, 0 , 0, theta3);
T4 = createDHmatrix(12.6, 0 , 0, theta4);

T1 = [cos(theta1) 0 sin(theta1) 0; sin(theta1) 0 -cos(theta1) 0; 0 1 0 7.7; 0 0 0 1];
T20 = T1*T2*yOffsetMatrix;
T30 = T1*T2*yOffsetMatrix*T3;
T40 = T1*T2*yOffsetMatrix*T3*T4;

z0 = [0;0;1];
p0 = [0;0;0];
z1 = T1([1:3],[3:3]);
z2 = T20([1:3],[3:3]);
z3 = T30([1:3],[3:3]);
z4 = T40([1:3],[3:3]);
p1 = T1([1:3],[4:4]);
p2 = T20([1:3],[4:4]);
p3 = T30([1:3],[4:4]);
p4 = T40([1:3],[4:4]);
column1 = cross(z0, (p4 - p0));
column2 = cross(z1, (p4 - p1));
column3 = cross(z2, (p4 - p2));
column4 = cross(z3, (p4 - p3));
matrixtop = [column1, column2, column3, column4];
matrixbot = [z0, z1, z2, z3];
matrixfull = cat(1, matrixtop, matrixbot);
matrixtop2 = matrixfull(1:3,:);
matrixbot2 = matrixfull(5,:);
matrixfull2 = cat(1, matrixtop2, matrixbot2);
output = inv(matrixfull2);
end