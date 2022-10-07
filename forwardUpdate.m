function forwardUpdate(theta1, theta2, theta3, theta4)
yOffsetMatrix = [1 0 0 0,
                0 1 0 -2.4,
                0 0 1 0,
                0 0 0 1]
T1 = createDHmatrix(0, pi/2 , 7.7, theta1/180*pi)
T2 = createDHmatrix(12.8, 0 , 0, theta2/180*pi)
T3 = createDHmatrix(12.4, 0 , 0, theta3/180*pi)
T4 = createDHmatrix(12.6, 0 , 0, theta4/180*pi)
T20 = T1*T2*yOffsetMatrix;
T30 = T1*T2*yOffsetMatrix*T3;
T40 = T1*T2*yOffsetMatrix*T3*T4;

ry_angle = 90*pi/180; 
Ry = makehgtform('yrotate',ry_angle);

r = 1.2;
[X, Y, Z] = cylinder(r);
Z = Z * 7.7;
s1 = surf(X,Y,Z, 'Facecolor', 'c', 'EdgeColor', 'none');
hold on
xlim([-50 50])
ylim([-60 60])
zlim([0 40])
rotate3d 'on'

Z = [-3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3 -3;
    3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3]
t = hgtransform;
t.Matrix = T1;
s2 = surf(X,Y,Z, 'parent', t);
s2.FaceColor = 'b';
s2.EdgeColor = 'none';


t = hgtransform;
t.Matrix = T20;
t.Matrix
s3 = surf(X,Y,Z, 'parent', t);
s3.FaceColor = 'b';
s3.EdgeColor = 'none';
O2 = transpose(T20([1:3],[4:4]));
O1 = transpose(T1([1:3],[4:4]));
[Xp, Yp, Zp] = cylinder2P(1, 5,O1, O2);
surf(Xp, Yp, Zp, 'FaceColor', 'c', 'EdgeColor', 'none');


t = hgtransform;
t.Matrix = T30;
t.Matrix
s4 = surf(X,Y,Z, 'parent', t);
s4.FaceColor = 'b';
s4.EdgeColor = 'none';
O3 = transpose(T30([1:3],[4:4]));
[Xp, Yp, Zp] = cylinder2P(1, 5,O2, O3);
surf(Xp, Yp, Zp, 'FaceColor', 'c', 'EdgeColor', 'none');

t = hgtransform;
t.Matrix = T40;
t.Matrix
% s5 = surf(X,Y,Z, 'parent', t);
O4 = transpose(T40([1:3],[4:4]));
[Xp, Yp, Zp] = cone2P(1, 5,O3, O4);
surf(Xp, Yp, Zp, 'FaceColor', 'r', 'EdgeColor', 'none');

hold off

end