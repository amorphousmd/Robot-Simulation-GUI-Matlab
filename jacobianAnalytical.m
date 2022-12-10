function L = jacobianAnalytical(theta1, theta2, theta3, theta4)
%     syms theta1 theta2 theta3 theta4
pitch = theta2 + theta3 + theta4;
global T;
T = forwardkinematic(theta1, theta2, theta3, theta4);
z0 = [0;0;1];
z1 = [T(1,3,1); T(2,3,1); T(3,3,1)];
z2 = [T(1,3,22); T(2,3,22); T(3,3,22)];
z3 = [T(1,3,3); T(2,3,3); T(3,3,3)];

p0 = [0;0;0];
p1 = [T(1,4,1); T(2,4,1); T(3,4,1)];
p2 = [T(1,4,22); T(2,4,22); T(3,4,22)];
p3 = [T(1,4,3); T(2,4,3); T(3,4,3)];
p4 = [T(1,4,4); T(2,4,4); T(3,4,4)];

Jq = [cross(z0,(p4-p0)) cross(z1,(p4-p1)) cross(z2,(p4-p2)) cross(z3,(p4-p3));
       z0 z1 z2 z3];  

angleJacobian = [cos(theta1)*sin(pitch) -sin(theta1) 0; sin(theta1)*sin(pitch) cos(pitch) 0; cos(pitch) 0 1];
invAngleJacobian = inv(angleJacobian);

rpyJacobianMatrix = angleJacobian \ Jq(4:6,:);
pitchDotJacobianMatrix = rpyJacobianMatrix(2,:);
xyzJacobianMatrix = Jq(1:3,:);
analyticJacobian = [xyzJacobianMatrix; pitchDotJacobianMatrix];

L = inv(analyticJacobian);

end