
syms theta1 theta2 theta3 theta4 alpha1 d1 a2 a3 a4 offset pitch
yOffsetMatrix = [1 0 0 0;
                0 1 0 -24;
                0 0 1 0;
                0 0 0 1]
% T1 = createDHmatrix(0, pi/2 , d1, theta1);
T2 = createDHmatrix(128, 0 , 0, theta2);
T3 = createDHmatrix(124, 0 , 0, theta3);
T4 = createDHmatrix(126, 0 , 0, theta4);

T1 = [cos(theta1) 0 sin(theta1) 0; sin(theta1) 0 -cos(theta1) 0; 0 1 0 77; 0 0 0 1]
T20 = T1*T2*yOffsetMatrix
T30 = T1*T2*yOffsetMatrix*T3
T40 = T1*T2*yOffsetMatrix*T3*T4
roll = pi/2
% pitch = theta2 + theta3 + theta4

% T20 = T1*T2
% T30 = T1*T2*T3
% T40 = T1*T2*T3*T4

z0 = [0;0;1]
p0 = [0;0;0]
z1 = T1([1:3],[3:3])
z2 = T20([1:3],[3:3])
z3 = T30([1:3],[3:3])
z4 = T40([1:3],[3:3])
p1 = T1([1:3],[4:4])
p2 = T20([1:3],[4:4])
p3 = T30([1:3],[4:4])
p4 = T40([1:3],[4:4])
column1 = cross(z0, (p4 - p0))
column2 = cross(z1, (p4 - p1))
column3 = cross(z2, (p4 - p2))
column4 = cross(z3, (p4 - p3))
matrixtop = [column1, column2, column3, column4]
matrixbot = [z0, z1, z2, z3]
matrixfull = cat(1, matrixtop, matrixbot)

angleJacobian = [1 0 sin(pitch); 0 0 -cos(pitch); 0 1 0];
invAngleJacobian = inv(angleJacobian)

topconcat = [1 1 1 0 0 0; 1 1 1 0 0 0; 1 1 1 0 0 0];
zeromatrix = [0 0 0; 0 0 0; 0 0 0];
botconcat = cat(2, zeromatrix, invAngleJacobian)
analyticJacobianMul = cat(1, topconcat, botconcat)
matrixfull
J2 = simplify(matrixfull)
analyticJacobian = analyticJacobianMul * matrixfull
rank(analyticJacobian)
% invAnalyticJacovian = inv(analyticJacobian)
% simplify(invAnalyticJacovian)
% matrixtop2 = matrixfull(1:3,:);
% % matrixmid2 = matrixfull(3,:);
% matrixbot2 = matrixfull(5,:);
% matrixfull2 = cat(1, matrixtop2, matrixbot2)
% % matrixfull3 = cat(1, matrixfull2, matrixbot2)
% 
% M = det(matrixfull2);
% 
% % X = transpose(matrixfull) * matrixfull
% % M = det(X)
% simplify(M)
inv(analyticJacobian(3:6,:))

matrixtop2 = analyticJacobian(1:3,:);
matrixbot2 = analyticJacobian(5,:);
matrixfull2 = cat(1, matrixtop2, matrixbot2)
det(matrixfull2)