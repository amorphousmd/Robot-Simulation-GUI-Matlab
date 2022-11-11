function [xall,yall,Yall,Zall] = createProfile(pmax, vmax, amax)
if vmax * vmax > amax * pmax
    disp('too big')
    vmaxnew = sqrt(amax * pmax)
    vmax = vmaxnew;
end
t1 = vmax / amax;
t2 = t1;
tm = (pmax - t1 * vmax) / vmax;
% dummy values
x1 = linspace(0,t1,1000);
y1 = amax * linspace(1,1,1000);
% integral
Y1 = cumtrapz(x1,y1);

x2 = linspace(t1,tm+t1,1000);
y2 = 0 * linspace(1,1,1000);
% integral
Y2 = cumtrapz(x2,y2) + vmax;

x3 = linspace(tm+t1,t2+tm+t2,1000);
y3 = amax * linspace(-1,-1,1000);
% integral
Y3 = cumtrapz(x3,y3) + vmax;
% plot
% figure, hold on

xbuf = cat(2,x1,x2);
xall = cat(2, xbuf,x3)
ybuf = cat(2,y1,y2);
yall = cat(2, ybuf,y3)
Ybuf = cat(2,Y1,Y2);
Yall = cat(2, Ybuf,Y3)
Z1 = cumtrapz(x1,Y1);
Z2 = cumtrapz(x2,Y2) + t1 * vmax/2;
Z3 = cumtrapz(x3,Y3) + t1 * vmax/2 + tm * vmax;
Zbuf = cat(2,Z1,Z2);
Zall = cat(2, Zbuf,Z3)


% plot(xall,yall);
% plot(xall,Yall);
% plot(xall,Zall);
% legend('a', 'v', 'p')
end