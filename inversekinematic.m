function [theta1, theta2, theta3, theta4] = inversekinematic(x,z,pitch,yaw,theta1o,theta2o,theta3o,theta4o)

% syms u t
% c1 = cos(yaw*pi/180);
% theta1 = yaw;
% d1 = 77;
% a2 = 128;
% a2dot = 24;
% a3 = 124;
% a4 = 126;
% s234 = -sin(pitch*pi/180); 
% c234 = sqrt(1-(s234)^2); 
% % Dat c23 = t => s23 = sqrt(1-t^2)
% % Dat c2 = u => s2 = sqrt(1-u^2)
% % t = (x/c1 - a2dot*u + a2*sqrt(1-u^2) - a4*c234)/a3;
% eqn = d1 + a3*sqrt(1-((x/c1 - a2dot*u + a2*sqrt(1-u^2) - a4*c234)/a3)^2) + a2*u + a2dot*sqrt(1-u^2) + a4*s234 == z;
% u_ans = solve(eqn);
% u_ans = round(u_ans, 4);
% t_ans = (x/c1 - a2dot*u_ans + a2*sqrt(1-u_ans^2) - a4*c234)/a3;
% theta2 = round(atan2(sqrt(1-u_ans^2),u_ans)*180/pi,2);
% theta3 = round(atan2(sqrt(1-t_ans^2),t_ans)*180/pi,2) - theta2;
% theta4 = atan2(s234,c234)*180/pi - theta2 - theta3;

syms u t
theta1 = yaw;
c1 = cos(yaw*pi/180);
theta2o =theta2o*180/pi;
theta3o =theta3o*180/pi;
theta4o =theta4o*180/pi;

% c1 = 0;

d1 = 77;
a2 = 128;
a2dot = 24;
a3 = 124;
a4 = 126;

s234 = -sin(pitch*pi/180);
c234p = sqrt(1-s234^2); 
% c234n = -sqrt(1-s234^2); 
% Dat c23 = t => s23 = sqrt(1-t^2)
% Dat c2 = u => s2 = sqrt(1-u^2)
s2p = sqrt(1-u^2);
s2n = -sqrt(1-u^2);

thsum = 0;
thsum2 = 0;
thsum2pre = 0;
thsumpre = 0;


    
%% TH1: s2p c234p

t = (x/c1 - a2dot*u + a2*s2p - a4*c234p)/a3;
eqn = d1 + a3*sqrt(1-t^2) + a2*u + a2dot*s2p + a4*s234 == z;
u_ans = solve(eqn);
% u_ans = round(u_ans,4);
if isreal(u_ans) && ~isempty(u_ans)
if (isscalar(u_ans))
    if (-1 <=u_ans) && (u_ans <=1)
       
s2p_ans = sqrt(1-u_ans^2);
t_ans = (x/c1 - a2dot*u_ans + a2*s2p_ans - a4*c234p)/a3;
        if (-1 <=t_ans) && (t_ans <=1) && isreal(t_ans)
        theta2p = round(atan2(s2p_ans,u_ans)*180/pi* 100)/100;        
        theta3p = round(atan2(sqrt(1-t_ans^2),t_ans)*180/pi* 100)/100 - theta2p;
        theta4p = round(atan2(s234,c234p)*180/pi* 100)/100 - theta2p - theta3p;
        thsum = abs(theta2p-theta2o) + abs(theta3p-theta3o) + abs(theta4p-theta4o);
        thsum2 = abs(theta2p) + abs(theta3p) + abs(theta4p);
        thsum2pre =thsum2;
        thsumpre = thsum;
        theta2 = theta2p;
        theta3 = theta3p;
        theta4 = theta4p;
        
        end
    end
else       
        if  (-1 <=u_ans(2)) && (u_ans(2) <=1)
s2p_ans2 = sqrt(1-u_ans(2)^2);
t_ans2 = (x/c1 - a2dot*u_ans(2) + a2*s2p_ans2 - a4*c234p)/a3;
        if (-1 <=t_ans2) && (t_ans2 <=1) 
        theta2p = round(atan2(s2p_ans2,u_ans(2))*180/pi,2);
        theta3p = round(atan2(sqrt(1-t_ans2^2),t_ans2)*180/pi,2) - theta2p;
        theta4p = round(atan2(s234,c234p)*180/pi,2) - theta2p - theta3p;
        thsum = abs(theta2p-theta2o) + abs(theta3p-theta3o) + abs(theta4p-theta4o);
        thsumpre = thsum;
        thsum2 = abs(theta2p) + abs(theta3p) + abs(theta4p);
        thsum2pre =thsum2;
        theta2 = theta2p;
        theta3 = theta3p;
        theta4 = theta4p;
        end
        end
        if  (-1 <=u_ans(1)) && (u_ans(1) <=1)
s2p_ans1 = sqrt(1-u_ans(1)^2);  
t_ans1 = (x/c1 - a2dot*u_ans(1) + a2*s2p_ans1 - a4*c234p)/a3;
        if (-1 <=t_ans1) && (t_ans1 <=1) 
        theta2p = round(atan2(s2p_ans1,u_ans(1))*180/pi,2);
        theta3p = round(atan2(sqrt(1-t_ans1^2),t_ans1)*180/pi,2) - theta2p;
        theta4p = round(atan2(s234,c234p)*180/pi,2) - theta2p - theta3p;
        thsum = abs(theta2p-theta2o) + abs(theta3p-theta3o) + abs(theta4p-theta4o);
        thsum2 = abs(theta2p) + abs(theta3p) + abs(theta4p);
        if (thsumpre) == 0 && (thsum2pre ==0)
            thsumpre = thsum;
            thsum2pre = thsum2;
        end
        if (thsum <= thsumpre) && (thsum2 <=thsum2pre)           
            thsum2pre =thsum2;
            thsumpre = thsum;
            theta2 = theta2p;
            theta3 = theta3p;
            theta4 = theta4p;
        end
        end
        end
       
        
    
end
end



% %% TH2 s2p c234n
% if count == 0
% t = (x/c1 - a2dot*u + a2*s2p - a4*c234n)/a3;
% eqn = d1 + a3*sqrt(1-t^2) + a2*u + a2dot*s2p + a4*s234 == z;
% u_ans = solve(eqn);
% u_ans = round(u_ans,4);
% if isreal(u_ans) && ~isempty(u_ans)
% if (isscalar(u_ans))
%     if (-1 <=u_ans) && (u_ans <=1)
%        
% s2p_ans = sqrt(1-u_ans^2);
% t_ans = (x/c1 - a2dot*u_ans + a2*s2p_ans - a4*c234n)/a3;
%         if (-1 <=t_ans) && (t_ans <=1) && isreal(t_ans)
%         theta2 = round(atan2(s2p_ans,u_ans)*180/pi,2)
%         theta3 = round(atan2(sqrt(1-t_ans^2),t_ans)*180/pi,2) - theta2
%         theta4 = round(atan2(s234,c234n)*180/pi,2) - theta2 - theta3
%         if (-90 <=  theta2) && (theta2 <= 90) && (-90 <=  theta3) && (theta3 <= 90) && (-90 <=  theta4) && (theta4 <= 90)
%         count = 1;
%         else 
%         count = 0;
%         end
%         end
%     end
% else
%         if  (-1 <=u_ans(2)) && (u_ans(2) <=1)
% s2p_ans2 = sqrt(1-u_ans(2)^2); 
% t_ans2 = (x/c1 - a2dot*u_ans(2) + a2*s2p_ans2 - a4*c234n)/a3;
%         if (-1 <=t_ans2) && (t_ans2 <=1) 
%         theta2 = round(atan2(s2p_ans2,u_ans(2))*180/pi,2)
%         theta3 = round(atan2(sqrt(1-t_ans2^2),t_ans2)*180/pi,2) - theta2
%         theta4 = round(atan2(s234,c234n)*180/pi,2) - theta2 - theta3
%         if (-90 <=  theta2) && (theta2 <= 90) && (-90 <=  theta3) && (theta3 <= 90) && (-90 <=  theta4) && (theta4 <= 90)
%         count = 1;
%         else 
%         count = 0;
%         end
%         end
%         end
%         
%         if (count == 0) &&(-1 <=u_ans(1)) && (u_ans(1) <=1)
% s2p_ans1 = sqrt(1-u_ans(1)^2); 
% t_ans1 = (x/c1 - a2dot*u_ans(1) + a2*s2p_ans1 - a4*c234n)/a3;
%         if (-1 <=t_ans1) && (t_ans1 <=1) 
%         theta2 = round(atan2(s2p_ans1,u_ans(1))*180/pi,2)
%         theta3 = round(atan2(sqrt(1-t_ans1^2),t_ans1)*180/pi,2) - theta2
%         theta4 = round(atan2(s234,c234n)*180/pi,2) - theta2 - theta3
%         if (-90 <=  theta2) && (theta2 <= 90) && (-90 <=  theta3) && (theta3 <= 90) && (-90 <=  theta4) && (theta4 <= 90)
%         count = 1;
%         else 
%         count = 0;
%         end
%         end
%         end
%         
%         
%     
% end
% end
% end


%% TH3 s2n c234p

t = (x/c1 - a2dot*u + a2*s2n - a4*c234p)/a3;
eqn = d1 + a3*sqrt(1-t^2) + a2*u + a2dot*s2n + a4*s234 == z;
u_ans = solve(eqn);
% u_ans = round(u_ans,4);

if isreal(u_ans) && ~isempty(u_ans) 
% s2n_ans = -sqrt(1-u_ans^2);
% t_ans = (x/c1 - a2dot*u_ans + a2*s2n_ans - a4*c234p)/a3;  
if (isscalar(u_ans))
    if (-1 <=u_ans) && (u_ans <=1)
s2n_ans = -sqrt(1-u_ans^2);
t_ans = (x/c1 - a2dot*u_ans + a2*s2n_ans - a4*c234p)/a3;
        if (-1 <=t_ans) && (t_ans <=1) 
        theta2p = round(atan2(s2n_ans,u_ans)*180/pi * 100)/100;
        theta3p = round(atan2(sqrt(1-t_ans^2),t_ans)*180* 100)/100 - theta2p;
        theta4p = round(atan2(s234,c234p)*180/pi* 100)/100 - theta2p - theta3p;
        thsum = abs(theta2p-theta2o) + abs(theta3p-theta3o) + abs(theta4p-theta4o);
        thsum2 = abs(theta2p) + abs(theta3p) + abs(theta4p);
        if (thsumpre == 0) && (thsum2pre ==0)
            thsumpre = thsum;
            thsum2pre = thsum2;
        end
         if (thsum <= thsumpre) && (thsum2 <=thsum2pre)           
            thsum2pre =thsum2;
            thsumpre = thsum;
            theta2 = theta2p;
            theta3 = theta3p;
            theta4 = theta4p;
        end
        end
    end

else
         if  (-1 <=u_ans(2)) && (u_ans(2) <=1)
s2n_ans2 = -sqrt(1-u_ans(2)^2); 
t_ans2 = (x/c1 - a2dot*u_ans(2) + a2*s2n_ans2 - a4*c234p)/a3;
        if (-1 <=t_ans2) && (t_ans2 <=1) 
        theta2p = round(atan2(s2n_ans2,u_ans(2))*180/pi* 100)/100;
        theta3p = round(atan2(sqrt(1-t_ans2^2),t_ans2)*180/pi* 100)/100 - theta2p;
        theta4p = round(atan2(s234,c234p)*180/pi* 100)/100 - theta2p - theta3p;
        thsum = abs(theta2p-theta2o) + abs(theta3p-theta3o) + abs(theta4p-theta4o);
        thsum2 = abs(theta2p) + abs(theta3p) + abs(theta4p);
        if (thsumpre == 0) && (thsum2pre ==0)
            thsumpre = thsum;
            thsum2pre = thsum2;
        end
         if (thsum <= thsumpre) && (thsum2 <=thsum2pre)           
            thsum2pre =thsum2;
            thsumpre = thsum;
            theta2 = theta2p;
            theta3 = theta3p;
            theta4 = theta4p;
        end
        end
        end
        if  (-1 <=u_ans(1)) && (u_ans(1) <=1) 
s2n_ans1 = -sqrt(1-u_ans(1)^2); 
t_ans1 = (x/c1 - a2dot*u_ans(1) + a2*s2n_ans1 - a4*c234p)/a3;
        if (-1 <=t_ans1) && (t_ans1 <=1) 
        theta2p = round(atan2(s2n_ans1,u_ans(1))*180/pi* 100)/100;
        theta3p = round(atan2(sqrt(1-t_ans1^2),t_ans1)*180/pi* 100)/100 - theta2p;
        theta4p = round(atan2(s234,c234p)*180/pi* 100)/100 - theta2p - theta3p;
        thsum = abs(theta2p-theta2o) + abs(theta3p-theta3o) + abs(theta4p-theta4o);
        thsum2 = abs(theta2p) + abs(theta3p) + abs(theta4p);
        if (thsumpre == 0) && (thsum2pre ==0)
            thsumpre = thsum;
            thsum2pre = thsum2;
        end
        if (thsum <= thsumpre) && (thsum2 <=thsum2pre)           
            thsum2pre =thsum2;
            thsumpre = thsum;
            theta2 = theta2p;
            theta3 = theta3p;
            theta4 = theta4p;
        end
        end   
        end
       
    
end
    
end

%     %% TH4 s2n c234n
% if count == 0
% t = (x/c1 - a2dot*u + a2*s2n - a4*c234n)/a3;
% eqn = d1 + a3*sqrt(1-t^2) + a2*u + a2dot*s2n + a4*s234 == z;
% u_ans = solve(eqn);
% u_ans = round(u_ans,4);
% if isreal(u_ans) && ~isempty(u_ans)
% if (isscalar(u_ans))
%     if (-1 <=u_ans) && (u_ans <=1)
%        
% s2n_ans = -sqrt(1-u_ans^2);
% t_ans = (x/c1 - a2dot*u_ans + a2*s2n_ans - a4*c234n)/a3;
%         if (-1 <=t_ans) && (t_ans <=1) && isreal(t_ans)
%         theta2 = round(atan2(s2n_ans,u_ans)*180/pi,2)
%         theta3 = round(atan2(sqrt(1-t_ans^2),t_ans)*180/pi,2) - theta2
%         theta4 = round(atan2(s234,c234n)*180/pi,2) - theta2 - theta3
%         if (-90 <=  theta2) && (theta2 <= 90) && (-90 <=  theta3) && (theta3 <= 90) && (-90 <=  theta4) && (theta4 <= 90)
%         count = 1;
%         else 
%         count = 0;
%         end
%         end
%     end
% else
%         if  (-1 <=u_ans(2)) && (u_ans(2) <=1)
% s2n_ans2 = -sqrt(1-u_ans(2)^2); 
% t_ans2 = (x/c1 - a2dot*u_ans(2) + a2*s2n_ans2 - a4*c234n)/a3;
%         if (-1 <=t_ans2) && (t_ans2 <=1) 
%         theta2 = round(atan2(s2n_ans2,u_ans(2))*180/pi,2)
%         theta3 = round(atan2(sqrt(1-t_ans2^2),t_ans2)*180/pi,2) - theta2
%         theta4 = round(atan2(s234,c234n)*180/pi,2) - theta2 - theta3
%         if (-90 <=  theta2) && (theta2 <= 90) && (-90 <=  theta3) && (theta3 <= 90) && (-90 <=  theta4) && (theta4 <= 90)
%         count = 1;
%         else 
%         count = 0;
%         end
%         end
%         end
%         if (count == 0) && (-1 <=u_ans(1)) && (u_ans(1) <=1)
% s2n_ans1 = -sqrt(1-u_ans(1)^2); 
% 
% t_ans1 = (x/c1 - a2dot*u_ans(1) + a2*s2n_ans1 - a4*c234n)/a3;
%         if (-1 <=t_ans1) && (t_ans1 <=1) 
%         theta2 = round(atan2(s2n_ans1,u_ans(1))*180/pi,2)
%         theta3 = round(atan2(sqrt(1-t_ans1^2),t_ans1)*180/pi,2) - theta2
%         theta4 = round(atan2(s234,c234n)*180/pi,2) - theta2 - theta3
%         if (-90 <=  theta2) && (theta2 <= 90) && (-90 <=  theta3) && (theta3 <= 90) && (-90 <=  theta4) && (theta4 <= 90)
%         count = 1;
%         else 
%         count = 0;
%         end
%         end
%         end
%         
%         
%     
% end
% end
% end

%% TH5: s2p c234p

t = (x/c1 - a2dot*u + a2*s2p - a4*c234p)/a3;
eqn = d1 + a3*-sqrt(1-t^2) + a2*u + a2dot*s2p + a4*s234 == z;
u_ans = solve(eqn);
% u_ans = round(u_ans,4);
if isreal(u_ans) && ~isempty(u_ans)
if (isscalar(u_ans))
    if (-1 <=u_ans) && (u_ans <=1)
       
s2p_ans = sqrt(1-u_ans^2);
t_ans = (x/c1 - a2dot*u_ans + a2*s2p_ans - a4*c234p)/a3;
        if (-1 <=t_ans) && (t_ans <=1) && isreal(t_ans)
        theta2p = round(atan2(s2p_ans,u_ans)*180/pi* 100)/100;
        theta3p = round(atan2(-sqrt(1-t_ans^2),t_ans)*180/pi* 100)/100 - theta2p;
        theta4p = round(atan2(s234,c234p)*180/pi* 100)/100 - theta2p - theta3p;
        thsum = abs(theta2p-theta2o) + abs(theta3p-theta3o) + abs(theta4p-theta4o);
        thsum2 = abs(theta2p) + abs(theta3p) + abs(theta4p);
        if (thsumpre == 0) && (thsum2pre ==0)
            thsumpre = thsum;
            thsum2pre = thsum2;
        end
         if (thsum <= thsumpre) && (thsum2 <=thsum2pre)           
            thsum2pre =thsum2;
            thsumpre = thsum;
            theta2 = theta2p;
            theta3 = theta3p;
            theta4 = theta4p;
        end
        end
    end
else
        if  (-1 <=u_ans(2)) && (u_ans(2) <=1)
s2p_ans2 = sqrt(1-u_ans(2)^2);
t_ans2 = (x/c1 - a2dot*u_ans(2) + a2*s2p_ans2 - a4*c234p)/a3;
        if (-1 <=t_ans2) && (t_ans2 <=1) 
        theta2p = round(atan2(s2p_ans2,u_ans(2))*180/pi* 100)/100;
        theta3p = round(atan2(-sqrt(1-t_ans2^2),t_ans2)*180/pi* 100)/100 - theta2p;
        theta4p = round(atan2(s234,c234p)*180/pi* 100)/100 - theta2p - theta3p;
        thsum = abs(theta2p-theta2o) + abs(theta3p-theta3o) + abs(theta4p-theta4o);
        thsum2 = abs(theta2p) + abs(theta3p) + abs(theta4p);
        if (thsumpre == 0) && (thsum2pre ==0)
            thsumpre = thsum;
            thsum2pre = thsum2;
        end
         if (thsum <= thsumpre) && (thsum2 <=thsum2pre)           
            thsum2pre =thsum2;
            thsumpre = thsum;
            theta2 = theta2p;
            theta3 = theta3p;
            theta4 = theta4p;
        end
        end
        end
        if (-1 <=u_ans(1)) && (u_ans(1) <=1)
s2p_ans1 = sqrt(1-u_ans(1)^2); 
t_ans1 = (x/c1 - a2dot*u_ans(1) + a2*s2p_ans1 - a4*c234p)/a3;
        if (-1 <=t_ans1) && (t_ans1 <=1) 
        theta2p = round(atan2(s2p_ans1,u_ans(1))*180/pi* 100)/100;
        theta3p = round(atan2(-sqrt(1-t_ans1^2),t_ans1)*180/pi* 100)/100 - theta2p;
        theta4p = round(atan2(s234,c234p)*180/pi* 100)/100 - theta2 - theta3p;
        thsum = abs(theta2p-theta2o) + abs(theta3p-theta3o) + abs(theta4p-theta4o);
        thsum2 = abs(theta2p) + abs(theta3p) + abs(theta4p);
        if (thsumpre == 0) && (thsum2pre ==0)
            thsumpre = thsum;
            thsum2pre = thsum2;
        end
         if (thsum <= thsumpre) && (thsum2 <=thsum2pre)           
            thsum2pre =thsum2;
            thsumpre = thsum;
            theta2 = theta2p;
            theta3 = theta3p;
            theta4 = theta4p;
        end
        end
        end
        
        
    
end
end



% %% TH6 s2p c234n
% if count == 0
% t = (x/c1 - a2dot*u + a2*s2p - a4*c234n)/a3;
% eqn = d1 + a3*-sqrt(1-t^2) + a2*u + a2dot*s2p + a4*s234 == z;
% u_ans = solve(eqn);
% u_ans = round(u_ans,4);
% if isreal(u_ans) && ~isempty(u_ans)
% if (isscalar(u_ans))
%     if (-1 <=u_ans) && (u_ans <=1)
%        
% s2p_ans = sqrt(1-u_ans^2);
% t_ans = (x/c1 - a2dot*u_ans + a2*s2p_ans - a4*c234n)/a3;
%         if (-1 <=t_ans) && (t_ans <=1) && isreal(t_ans)
%         theta2 = round(atan2(s2p_ans,u_ans)*180/pi,2)
%         theta3 = round(atan2(-sqrt(1-t_ans^2),t_ans)*180/pi,2) - theta2
%         theta4 = round(atan2(s234,c234n)*180/pi,2) - theta2 - theta3
%         if (-90 <=  theta2) && (theta2 <= 90) && (-90 <=  theta3) && (theta3 <= 90) && (-90 <=  theta4) && (theta4 <= 90)
%         count = 1;
%         else 
%         count = 0;
%         end
%         end
%     end
% else
%         if  (-1 <=u_ans(2)) && (u_ans(2) <=1)
% s2p_ans2 = sqrt(1-u_ans(2)^2); 
% t_ans2 = (x/c1 - a2dot*u_ans(2) + a2*s2p_ans2 - a4*c234n)/a3;
%         if (-1 <=t_ans2) && (t_ans2 <=1) 
%         theta2 = round(atan2(s2p_ans2,u_ans(2))*180/pi,2)
%         theta3 = round(atan2(-sqrt(1-t_ans2^2),t_ans2)*180/pi,2) - theta2
%         theta4 = round(atan2(s234,c234n)*180/pi,2) - theta2 - theta3
%         if (-90 <=  theta2) && (theta2 <= 90) && (-90 <=  theta3) && (theta3 <= 90) && (-90 <=  theta4) && (theta4 <= 90)
%         count = 1;
%         else 
%         count = 0;
%         end
%         end
%         end 
%         if (count == 0) && (-1 <=u_ans(1)) && (u_ans(1) <=1)
% s2p_ans1 = sqrt(1-u_ans(1)^2); 
% t_ans1 = (x/c1 - a2dot*u_ans(1) + a2*s2p_ans1 - a4*c234n)/a3;
%         if (-1 <=t_ans1) && (t_ans1 <=1) 
%         theta2 = round(atan2(s2p_ans1,u_ans(1))*180/pi,2)
%         theta3 = round(atan2(-sqrt(1-t_ans1^2),t_ans1)*180/pi,2) - theta2
%         theta4 = round(atan2(s234,c234n)*180/pi,2) - theta2 - theta3
%         if (-90 <=  theta2) && (theta2 <= 90) && (-90 <=  theta3) && (theta3 <= 90) && (-90 <=  theta4) && (theta4 <= 90)
%         count = 1;
%         else 
%         count = 0;
%         end
%         end
%         end
%         
%         
%     
% end
% end
% end


%% TH7 s2n c234p

t = (x/c1 - a2dot*u + a2*s2n - a4*c234p)/a3;
eqn = d1 + a3*-sqrt(1-t^2) + a2*u + a2dot*s2n + a4*s234 == z;
u_ans = solve(eqn);
% u_ans = round(u_ans,4);

if isreal(u_ans) && ~isempty(u_ans) 

if (isscalar(u_ans))
    if (-1 <=u_ans) && (u_ans <=1)
s2n_ans = -sqrt(1-u_ans^2);
t_ans = (x/c1 - a2dot*u_ans + a2*s2n_ans - a4*c234p)/a3;
        if (-1 <=t_ans) && (t_ans <=1) 
        theta2p = round(atan2(s2n_ans,u_ans)*180/pi* 100)/100;
        theta3p = round(atan2(-sqrt(1-t_ans^2),t_ans)*180/pi* 100)/100 - theta2p;
        theta4p = round(atan2(s234,c234p)*180/pi* 100)/100 - theta2p - theta3p;
        thsum = abs(theta2p-theta2o) + abs(theta3p-theta3o) + abs(theta4p-theta4o);
        thsum2 = abs(theta2p) + abs(theta3p) + abs(theta4p);
        if (thsumpre == 0) && (thsum2pre ==0)
            thsumpre = thsum;
            thsum2pre = thsum2;
        end
        if (thsum <= thsumpre) && (thsum2 <=thsum2pre)           
            thsum2pre =thsum2;
            thsumpre = thsum;
            theta2 = theta2p;
            theta3 = theta3p;
            theta4 = theta4p;
        end
        end
    end

else
        if  (-1 <=u_ans(2)) && (u_ans(2) <=1)
s2n_ans2 = -sqrt(1-u_ans(2)^2); 
t_ans2 = (x/c1 - a2dot*u_ans(2) + a2*s2n_ans2 - a4*c234p)/a3;
        if (-1 <=t_ans2) && (t_ans2 <=1) 
        theta2p = round(atan2(s2n_ans2,u_ans(2))*180/pi* 100)/100;
        theta3p = round(atan2(-sqrt(1-t_ans2^2),t_ans2)*180/pi* 100)/100 - theta2p;
        theta4p = round(atan2(s234,c234p)*180/pi* 100)/100 - theta2p - theta3p;
        thsum = abs(theta2p-theta2o) + abs(theta3p-theta3o) + abs(theta4p-theta4o);
        thsum2 = abs(theta2p) + abs(theta3p) + abs(theta4p);
        if (thsumpre == 0) && (thsum2pre ==0)
            thsumpre = thsum;
            thsum2pre = thsum2;
        end
        if (thsum <= thsumpre) && (thsum2 <=thsum2pre)           
            thsum2pre =thsum2;
            thsumpre = thsum;
            theta2 = theta2p;
            theta3 = theta3p;
            theta4 = theta4p;
        end
        end
        end
        if  (-1 <=u_ans(1)) && (u_ans(1) <=1) 
s2n_ans1 = -sqrt(1-u_ans(1)^2); 
t_ans1 = (x/c1 - a2dot*u_ans(1) + a2*s2n_ans1 - a4*c234p)/a3;
        if (-1 <=t_ans1) && (t_ans1 <=1) 
        theta2p = round(atan2(s2n_ans1,u_ans(1))*180/pi* 100)/100;
        theta3p = round(atan2(-sqrt(1-t_ans1^2),t_ans1)*180/pi* 100)/100 - theta2p;
        theta4p = round(atan2(s234,c234p)*180/pi* 100)/100 - theta2p - theta3p;
        thsum = abs(theta2p-theta2o) + abs(theta3p-theta3o) + abs(theta4p-theta4o);
        thsum2 = abs(theta2p) + abs(theta3p) + abs(theta4p);
        if (thsumpre == 0) && (thsum2pre ==0)
            thsumpre = thsum;
            thsum2pre = thsum2;
        end
         if (thsum <= thsumpre) && (thsum2 <=thsum2pre)           
            thsum2pre =thsum2;
            thsumpre = thsum;
            theta2 = theta2p;
            theta3 = theta3p;
            theta4 = theta4p;
        end
        end 
        end
        
    
end
    
end

%     %% TH8 s2n c234n
% if count == 0
% t = (x/c1 - a2dot*u + a2*s2n - a4*c234n)/a3;
% eqn = d1 + a3*-sqrt(1-t^2) + a2*u + a2dot*s2n + a4*s234 == z;
% u_ans = solve(eqn);
% u_ans = round(u_ans,4);
% if isreal(u_ans) && ~isempty(u_ans)
% if (isscalar(u_ans))
%     if (-1 <=u_ans) && (u_ans <=1)
%        
% s2n_ans = -sqrt(1-u_ans^2);
% t_ans = (x/c1 - a2dot*u_ans + a2*s2n_ans - a4*c234n)/a3;
%         if (-1 <=t_ans) && (t_ans <=1) && isreal(t_ans)
%         theta2 = round(atan2(s2n_ans,u_ans)*180/pi,2)
%         theta3 = round(atan2(-sqrt(1-t_ans^2),t_ans)*180/pi,2) - theta2
%         theta4 = round(atan2(s234,c234n)*180/pi,2) - theta2 - theta3
%         if (-90 <=  theta2) && (theta2 <= 90) && (-90 <=  theta3) && (theta3 <= 90) && (-90 <=  theta4) && (theta4 <= 90)
%         count = 1;
%         else 
%         count = 0;
%         end
%         end
%     end
% else
%         if (-1 <=u_ans(2)) && (u_ans(2) <=1)
% s2n_ans2 = -sqrt(1-u_ans(2)^2); 
% t_ans2 = (x/c1 - a2dot*u_ans(2) + a2*s2n_ans2 - a4*c234n)/a3;
%         if (-1 <=t_ans2) && (t_ans2 <=1) 
%         theta2 = round(atan2(s2n_ans2,u_ans(2))*180/pi,2)
%         theta3 = round(atan2(-sqrt(1-t_ans2^2),t_ans2)*180/pi,2) - theta2
%         theta4 = round(atan2(s234,c234n)*180/pi,2) - theta2 - theta3
%         if (-90 <=  theta2) && (theta2 <= 90) && (-90 <=  theta3) && (theta3 <= 90) && (-90 <=  theta4) && (theta4 <= 90)
%         count = 1;
%         else 
%         count = 0;
%         end
%         end
%         end
%         if (count == 0) && (-1 <=u_ans(1)) && (u_ans(1) <=1)
% s2n_ans1 = -sqrt(1-u_ans(1)^2); 
% t_ans1 = (x/c1 - a2dot*u_ans(1) + a2*s2n_ans1 - a4*c234n)/a3;
%         if (-1 <=t_ans1) && (t_ans1 <=1) 
%         theta2 = round(atan2(s2n_ans1,u_ans(1))*180/pi,2)
%         theta3 = round(atan2(-sqrt(1-t_ans1^2),t_ans1)*180/pi,2) - theta2
%         theta4 = round(atan2(s234,c234n)*180/pi,2) - theta2 - theta3
%         if (-90 <=  theta2) && (theta2 <= 90) && (-90 <=  theta3) && (theta3 <= 90) && (-90 <=  theta4) && (theta4 <= 90)
%         count = 1;
%         else 
%         count = 0;
%         end
%         end
%         end
%         
%         
%     
% end
% end
% end
% 
% if s234 == 0
%     theta2p = 0;
%     theta3p = 0;
%     theta4p = 0;
%     thsum = abs(theta2p) + abs(theta3p) + abs(theta4p);
% if (thsum <= thsumpre)
%             
%             theta2 = theta2p;
%             theta3 = theta3p;
%             theta4 = theta4p;
% end
% end
%     
    







end