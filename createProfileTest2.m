pmax = 721;
vmax = 33333;
amax = 360;
if vmax * vmax > amax * pmax
    vmaxnew = sqrt(amax * pmax);
    vmax = vmaxnew;
end
t1 = vmax / amax;
t2 = t1;
tm = (pmax - t1 * vmax) / vmax;
% dummy values
x1 = [0:0.001:t1];
y1 = amax * linspace(1,1,length(x1));
% integral
Y1 = cumtrapz(x1,y1);

x2 = [t1:0.001:t1+tm];
y2 = 0 * linspace(1,1,length(x2));
a = length(x2);
% integral
if a == 1
    Y2 = vmax;
else
    Y2 = cumtrapz(x2,y2) + vmax;
end


x3 = [tm+t1:0.001:tm+t1+t2];
y3 = amax * linspace(-1,-1,length(x3));
% integral
Y3 = cumtrapz(x3,y3) + vmax;
% plot
figure, hold on;

xbuf = cat(2,x1,x2);
xall = cat(2, xbuf,x3);
ybuf = cat(2,y1,y2);
yall = cat(2, ybuf,y3);
Ybuf = cat(2,Y1,Y2);
Yall = cat(2, Ybuf,Y3);
Z1 = cumtrapz(x1,Y1);
if a == 1
    Z2 = t1 * vmax/2;
else
    Z2 = cumtrapz(x2,Y2) + t1 * vmax/2;
end
% Z2 = cumtrapz(x2,Y2) + t1 * vmax/2;
Z3 = cumtrapz(x3,Y3) + t1 * vmax/2 + tm * vmax;
Zbuf = cat(2,Z1,Z2);
Zall = cat(2, Zbuf,Z3);


plot(xall,yall);
plot(xall,Yall);
plot(xall,Zall);
legend('a', 'v', 'p')
% list = [];
% for i = 1:100
%     list = [list, Zall(30*i)]
% end