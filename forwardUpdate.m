function forwardUpdate(theta1, theta2, theta3, theta4)
yOffsetMatrix = [1 0 0 0,
                0 1 0 -2.4,
                0 0 1 0,
                0 0 0 1];
T1 = createDHmatrix(0, pi/2 , 7.7, theta1/180*pi);
T2 = createDHmatrix(12.8, 0 , 0, theta2/180*pi);
T3 = createDHmatrix(12.4, 0 , 0, theta3/180*pi);
T4 = createDHmatrix(12.6, 0 , 0, theta4/180*pi);
T20 = T1*T2*yOffsetMatrix;
T30 = T1*T2*yOffsetMatrix*T3;
T40 = T1*T2*yOffsetMatrix*T3*T4;
global drawCoordsAllow;
if drawCoordsAllow == 1
    arrow2P(eye(4));
    arrow2P(T1);
    arrow2P(T20);
    arrow2P(T30);
    arrow2P(T40);
end


ry_angle = 90*pi/180; 
Ry = makehgtform('yrotate',ry_angle);

r = 1.2;
[X, Y, Z] = cylinder(r);
Z = Z * 7.7;
s1 = surf(X,Y,Z, 'Facecolor', 'y');
hold on
xlim([-50 50])
ylim([-60 60])
zlim([0 40])
rotate3d 'on'

Z = [-3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3;
    3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3];
t = hgtransform;
t.Matrix = T1;
s2 = surf(X,Y,Z, 'parent', t);
s2.FaceColor = 'b';


t = hgtransform;
t.Matrix = T20;
s3 = surf(X,Y,Z, 'parent', t);
s3.FaceColor = 'b';
O2 = transpose(T20([1:3],[4:4]));
O1 = transpose(T1([1:3],[4:4]));
[Xp, Yp, Zp] = cylinder2P(1, 5,O1, O2);
surf(Xp, Yp, Zp, 'FaceColor', 'y');


t = hgtransform;
t.Matrix = T30;
s4 = surf(X,Y,Z, 'parent', t);
s4.FaceColor = 'b';
O3 = transpose(T30([1:3],[4:4]));
[Xp, Yp, Zp] = cylinder2P(1, 5,O2, O3);
surf(Xp, Yp, Zp, 'FaceColor', 'y');

t = hgtransform;
t.Matrix = T40;
% s5 = surf(X,Y,Z, 'parent', t);
O4 = transpose(T40([1:3],[4:4]));
[Xp, Yp, Zp] = cone2P(1, 5,O3, O4);
% arrow2P(T40);
surf(Xp, Yp, Zp, 'FaceColor', 'r');
hold off
global endEffectorX;
global endEffectorY;
global endEffectorZ;
global endEffectorRoll;
global endEffectorPitch;
global endEffectorYaw;
endEffectorX = T40(1,4);
endEffectorY = T40(2,4);
endEffectorZ = T40(3,4);
endEffectorYaw = atan2(T40(2,1),T40(1,1));
endEffectorPitch = atan2(-T40(3,1),sqrt(T40(3,2)^2+T40(3,3)^2));
endEffectorRoll = atan2(T40(3,2),T40(3,3));


end



