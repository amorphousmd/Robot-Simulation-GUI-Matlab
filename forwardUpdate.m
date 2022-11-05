function forwardUpdate(theta1, theta2, theta3, theta4)
global prevS1
global prevS2
global prevS3
global prevS4
global prevS5
global prevS6
global prevS7
delete(prevS1);
delete(prevS2);
delete(prevS3);
delete(prevS4);
delete(prevS5);
delete(prevS6);
delete(prevS7);
yOffsetMatrix = [1 0 0 0,
                0 1 0 -2.4,
                0 0 1 0,
                0 0 0 1];
T1 = createDHmatrix(0, pi/2 , 7.7, theta1/180*pi)
T2 = createDHmatrix(12.8, 0 , 0, theta2/180*pi);
T3 = createDHmatrix(12.4, 0 , 0, theta3/180*pi);
T4 = createDHmatrix(12.6, 0 , 0, theta4/180*pi);
T20 = T1*T2*yOffsetMatrix
T30 = T1*T2*yOffsetMatrix*T3
T40 = T1*T2*yOffsetMatrix*T3*T4
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
prevS1 = surf(X,Y,Z, 'Facecolor', 'y');
hold on
xlim([-50 50])
ylim([-60 60])
zlim([0 40])
rotate3d 'on'

Z = [-3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3;
    3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3];
t = hgtransform;
t.Matrix = T1;
prevS2 = surf(X,Y,Z, 'parent', t);
prevS2.FaceColor = 'b';


t = hgtransform;
t.Matrix = T20;
prevS3 = surf(X,Y,Z, 'parent', t);
prevS3.FaceColor = 'b';
O2 = transpose(T20([1:3],[4:4]));
O1 = transpose(T1([1:3],[4:4]));
[Xp, Yp, Zp] = cylinder2P(1, 5,O1, O2);
prevS5 = surf(Xp, Yp, Zp, 'FaceColor', 'y');


t = hgtransform;
t.Matrix = T30;
prevS4 = surf(X,Y,Z, 'parent', t);
prevS4.FaceColor = 'b';
O3 = transpose(T30([1:3],[4:4]));
[Xp, Yp, Zp] = cylinder2P(1, 5,O2, O3);
prevS6 =surf(Xp, Yp, Zp, 'FaceColor', 'y');

t = hgtransform;
t.Matrix = T40;
% s5 = surf(X,Y,Z, 'parent', t);
O4 = transpose(T40([1:3],[4:4]));
[Xp, Yp, Zp] = cone2P(1, 5,O3, O4);
% arrow2P(T40);
prevS7 = surf(Xp, Yp, Zp, 'FaceColor', 'r');
% hold off
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

plot3(endEffectorX, endEffectorY, endEffectorZ, 'o','Color','b','MarkerSize',2,'MarkerFaceColor','b')

end



