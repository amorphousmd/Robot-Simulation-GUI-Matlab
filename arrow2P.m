% function arrow2P(R, N,r1,r2)
% midpoint = r1 + (r2-r1) * 0.8
% [Xp, Yp, Zp] = cylinder2P(R,N,r1,midpoint);
% surf(Xp, Yp, Zp, 'FaceColor', 'b');
% hold on;
% [Xp, Yp, Zp] = cone2P(R*2,N,midpoint,r2);
% surf(Xp, Yp, Zp, 'FaceColor', 'b');
% hold on;

function arrow2P(tMatrix)
center = transpose(tMatrix([1:3],[4:4]))
XEndPoint = center + transpose(tMatrix([1:3],[1:1]) * 7)
YEndPoint = center + transpose(tMatrix([1:3],[2:2]) * 7)
ZEndPoint = center + transpose(tMatrix([1:3],[3:3]) * 7)

% X Arrow
midpoint = center + (XEndPoint-center) * 0.8
[Xp, Yp, Zp] = cylinder2P(0.5,4,center,midpoint)
surf(Xp, Yp, Zp, 'FaceColor', 'r');
hold on;
[Xp, Yp, Zp] = cone2P(0.8,4,midpoint,XEndPoint);
surf(Xp, Yp, Zp, 'FaceColor', 'r');
hold on;

% Y Arrow
midpoint = center + (YEndPoint-center) * 0.8
[Xp, Yp, Zp] = cylinder2P(0.5,4,center,midpoint);
surf(Xp, Yp, Zp, 'FaceColor', 'g');
hold on;
[Xp, Yp, Zp] = cone2P(0.8,4,midpoint,YEndPoint);
surf(Xp, Yp, Zp, 'FaceColor', 'g');
hold on;

% Z Arrow
midpoint = center + (ZEndPoint-center) * 0.8
[Xp, Yp, Zp] = cylinder2P(0.5,4,center,midpoint);
surf(Xp, Yp, Zp, 'FaceColor', 'b');
hold on;
[Xp, Yp, Zp] = cone2P(0.8,4,midpoint,ZEndPoint);
surf(Xp, Yp, Zp, 'FaceColor', 'b');
hold on;
    
