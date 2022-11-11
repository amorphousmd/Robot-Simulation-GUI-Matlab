function forwardUpdate(theta1, theta2, theta3, theta4)
% Update Sequence Just ignore this
for d = 1
    global prevS1;
    global prevS2;
    global prevS3;
    global prevS4;
    global prevS5;
    global prevS6;
    global prevS7;
    global prevX10;
    global prevX20;
    global prevY10;
    global prevY20;
    global prevZ10;
    global prevZ20;
    global prevX11;
    global prevX21;
    global prevY11;
    global prevY21;
    global prevZ11;
    global prevZ21;
    global prevX12;
    global prevX22;
    global prevY12;
    global prevY22;
    global prevZ12;
    global prevZ22;
    global prevX13;
    global prevX23;
    global prevY13;
    global prevY23;
    global prevZ13;
    global prevZ23;
    global prevX14;
    global prevX24;
    global prevY14;
    global prevY24;
    global prevZ14;
    global prevZ24;
    delete(prevS1);
    delete(prevS2);
    delete(prevS3);
    delete(prevS4);
    delete(prevS5);
    delete(prevS6);
    delete(prevS7);
    delete(prevX10);
    delete(prevX20);
    delete(prevY10);
    delete(prevY20);
    delete(prevZ10);
    delete(prevZ20);
    delete(prevX11);
    delete(prevX21);
    delete(prevY11);
    delete(prevY21);
    delete(prevZ11);
    delete(prevZ21);
    delete(prevX12);
    delete(prevX22);
    delete(prevY12);
    delete(prevY22);
    delete(prevZ12);
    delete(prevZ22);
    delete(prevX13);
    delete(prevX23);
    delete(prevY13);
    delete(prevY23);
    delete(prevZ13);
    delete(prevZ23);
    delete(prevX14);
    delete(prevX24);
    delete(prevY14);
    delete(prevY24);
    delete(prevZ14);
    delete(prevZ24);
end

% Calculating the homogenous matrices
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

for d = 1
    % Draw Coordinate Arrows
    global drawCoordsAllow;
    if drawCoordsAllow == 1
    % Coords Base
    T0 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
    center = transpose(T0([1:3],[4:4]));
    XEndPoint = center + transpose(T0([1:3],[1:1]) * 7);
    YEndPoint = center + transpose(T0([1:3],[2:2]) * 7);
    ZEndPoint = center + transpose(T0([1:3],[3:3]) * 7);

    % X Arrow
    midpoint = center + (XEndPoint-center) * 0.8;
    [Xp, Yp, Zp] = cylinder2P(0.5,4,center,midpoint);
    prevX10 = surf(Xp, Yp, Zp, 'FaceColor', 'r');
    hold on;
    [Xp, Yp, Zp] = cone2P(0.8,4,midpoint,XEndPoint);
    prevX20 = surf(Xp, Yp, Zp, 'FaceColor', 'r');
    hold on;

    % Y Arrow
    midpoint = center + (YEndPoint-center) * 0.8;
    [Xp, Yp, Zp] = cylinder2P(0.5,4,center,midpoint);
    prevY10 = surf(Xp, Yp, Zp, 'FaceColor', 'g');
    hold on;
    [Xp, Yp, Zp] = cone2P(0.8,4,midpoint,YEndPoint);
    prevY20 = surf(Xp, Yp, Zp, 'FaceColor', 'g');
    hold on;

    % Z Arrow
    midpoint = center + (ZEndPoint-center) * 0.8;
    [Xp, Yp, Zp] = cylinder2P(0.5,4,center,midpoint);
    prevZ10 = surf(Xp, Yp, Zp, 'FaceColor', 'b');
    hold on;
    [Xp, Yp, Zp] = cone2P(0.8,4,midpoint,ZEndPoint);
    prevZ20 = surf(Xp, Yp, Zp, 'FaceColor', 'b');
    hold on;    


    % Coords 1
    center = transpose(T1([1:3],[4:4]));
    XEndPoint = center + transpose(T1([1:3],[1:1]) * 7);
    YEndPoint = center + transpose(T1([1:3],[2:2]) * 7);
    ZEndPoint = center + transpose(T1([1:3],[3:3]) * 7);

    % X Arrow
    midpoint = center + (XEndPoint-center) * 0.8;
    [Xp, Yp, Zp] = cylinder2P(0.5,4,center,midpoint);
    prevX11 = surf(Xp, Yp, Zp, 'FaceColor', 'r');
    hold on;
    [Xp, Yp, Zp] = cone2P(0.8,4,midpoint,XEndPoint);
    prevX21 = surf(Xp, Yp, Zp, 'FaceColor', 'r');
    hold on;

    % Y Arrow
    midpoint = center + (YEndPoint-center) * 0.8;
    [Xp, Yp, Zp] = cylinder2P(0.5,4,center,midpoint);
    prevY11 = surf(Xp, Yp, Zp, 'FaceColor', 'g');
    hold on;
    [Xp, Yp, Zp] = cone2P(0.8,4,midpoint,YEndPoint);
    prevY21 = surf(Xp, Yp, Zp, 'FaceColor', 'g');
    hold on;

    % Z Arrow
    midpoint = center + (ZEndPoint-center) * 0.8;
    [Xp, Yp, Zp] = cylinder2P(0.5,4,center,midpoint);
    prevZ11 = surf(Xp, Yp, Zp, 'FaceColor', 'b');
    hold on;
    [Xp, Yp, Zp] = cone2P(0.8,4,midpoint,ZEndPoint);
    prevZ21 = surf(Xp, Yp, Zp, 'FaceColor', 'b');
    hold on;

    % Coords 2
    center = transpose(T20([1:3],[4:4]));
    XEndPoint = center + transpose(T20([1:3],[1:1]) * 7);
    YEndPoint = center + transpose(T20([1:3],[2:2]) * 7);
    ZEndPoint = center + transpose(T20([1:3],[3:3]) * 7);

    % X Arrow
    midpoint = center + (XEndPoint-center) * 0.8;
    [Xp, Yp, Zp] = cylinder2P(0.5,4,center,midpoint);
    prevX12 = surf(Xp, Yp, Zp, 'FaceColor', 'r');
    hold on;
    [Xp, Yp, Zp] = cone2P(0.8,4,midpoint,XEndPoint);
    prevX22 = surf(Xp, Yp, Zp, 'FaceColor', 'r');
    hold on;

    % Y Arrow
    midpoint = center + (YEndPoint-center) * 0.8;
    [Xp, Yp, Zp] = cylinder2P(0.5,4,center,midpoint);
    prevY12 = surf(Xp, Yp, Zp, 'FaceColor', 'g');
    hold on;
    [Xp, Yp, Zp] = cone2P(0.8,4,midpoint,YEndPoint);
    prevY22 = surf(Xp, Yp, Zp, 'FaceColor', 'g');
    hold on;

    % Z Arrow
    midpoint = center + (ZEndPoint-center) * 0.8;
    [Xp, Yp, Zp] = cylinder2P(0.5,4,center,midpoint);
    prevZ12 = surf(Xp, Yp, Zp, 'FaceColor', 'b');
    hold on;
    [Xp, Yp, Zp] = cone2P(0.8,4,midpoint,ZEndPoint);
    prevZ22 = surf(Xp, Yp, Zp, 'FaceColor', 'b');
    hold on;

    % Coords 3
    center = transpose(T30([1:3],[4:4]));
    XEndPoint = center + transpose(T30([1:3],[1:1]) * 7);
    YEndPoint = center + transpose(T30([1:3],[2:2]) * 7);
    ZEndPoint = center + transpose(T30([1:3],[3:3]) * 7);

    % X Arrow
    midpoint = center + (XEndPoint-center) * 0.8;
    [Xp, Yp, Zp] = cylinder2P(0.5,4,center,midpoint);
    prevX13 = surf(Xp, Yp, Zp, 'FaceColor', 'r');
    hold on;
    [Xp, Yp, Zp] = cone2P(0.8,4,midpoint,XEndPoint);
    prevX23 = surf(Xp, Yp, Zp, 'FaceColor', 'r');
    hold on;

    % Y Arrow
    midpoint = center + (YEndPoint-center) * 0.8;
    [Xp, Yp, Zp] = cylinder2P(0.5,4,center,midpoint);
    prevY13 = surf(Xp, Yp, Zp, 'FaceColor', 'g');
    hold on;
    [Xp, Yp, Zp] = cone2P(0.8,4,midpoint,YEndPoint);
    prevY23 = surf(Xp, Yp, Zp, 'FaceColor', 'g');
    hold on;

    % Z Arrow
    midpoint = center + (ZEndPoint-center) * 0.8;
    [Xp, Yp, Zp] = cylinder2P(0.5,4,center,midpoint);
    prevZ13 = surf(Xp, Yp, Zp, 'FaceColor', 'b');
    hold on;
    [Xp, Yp, Zp] = cone2P(0.8,4,midpoint,ZEndPoint);
    prevZ23 = surf(Xp, Yp, Zp, 'FaceColor', 'b');
    hold on;

    % Coords 4
    center = transpose(T40([1:3],[4:4]));
    XEndPoint = center + transpose(T40([1:3],[1:1]) * 7);
    YEndPoint = center + transpose(T40([1:3],[2:2]) * 7);
    ZEndPoint = center + transpose(T40([1:3],[3:3]) * 7);

    % X Arrow
    midpoint = center + (XEndPoint-center) * 0.8;
    [Xp, Yp, Zp] = cylinder2P(0.5,4,center,midpoint);
    prevX14 = surf(Xp, Yp, Zp, 'FaceColor', 'r');
    hold on;
    [Xp, Yp, Zp] = cone2P(0.8,4,midpoint,XEndPoint);
    prevX24 = surf(Xp, Yp, Zp, 'FaceColor', 'r');
    hold on;

    % Y Arrow
    midpoint = center + (YEndPoint-center) * 0.8;
    [Xp, Yp, Zp] = cylinder2P(0.5,4,center,midpoint);
    prevY14 = surf(Xp, Yp, Zp, 'FaceColor', 'g');
    hold on;
    [Xp, Yp, Zp] = cone2P(0.8,4,midpoint,YEndPoint);
    prevY24 = surf(Xp, Yp, Zp, 'FaceColor', 'g');
    hold on;

    % Z Arrow
    midpoint = center + (ZEndPoint-center) * 0.8;
    [Xp, Yp, Zp] = cylinder2P(0.5,4,center,midpoint);
    prevZ14 = surf(Xp, Yp, Zp, 'FaceColor', 'b');
    hold on;
    [Xp, Yp, Zp] = cone2P(0.8,4,midpoint,ZEndPoint);
    prevZ24 = surf(Xp, Yp, Zp, 'FaceColor', 'b');
    hold on;
    end
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

global drawPathAllow;
if drawPathAllow == 1
plot3(endEffectorX, endEffectorY, endEffectorZ, 'o','Color','b','MarkerSize',2,'MarkerFaceColor','b')
end
end



