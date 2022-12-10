function T = forwardkinematic(theta1, theta2, theta3, theta4)
d1 = 7.7;
a2 = 12.8;
a2dot = 2.4;
a3 = 12.4;
a4 = 12.6;



A0_1 = [ cos(theta1) 0  sin(theta1)  0;
         sin(theta1) 0  -cos(theta1) 0;
         0           1  0            d1;
         0           0  0            1];
A1_1dot = [-sin(theta2) -cos(theta2) 0  -a2*sin(theta2);
          cos(theta2)   -sin(theta2) 0  a2*cos(theta2);
          0              0           1  0;
          0              0           0  1];
A1dot_2 = [ 0   1   0   0;
            -1  0   0   -a2dot;
            0   0   1   0;
            0   0   0   1];  
        
A2_3 = [ cos(theta3) -sin(theta3) 0 a3*cos(theta3);
         sin(theta3) cos(theta3)  0 a3*sin(theta3);
         0           0            1 0;
         0           0            0 1];
A3_4 = [ cos(theta4) -sin(theta4) 0 a4*cos(theta4);
         sin(theta4) cos(theta4)  0 a4*sin(theta4);
         0           0            1 0;
         0           0            0 1];
    
T(:,:,1) =  A0_1;
T(:,:,21) =  A0_1 * A1_1dot;
T(:,:,22) =  A0_1 * A1_1dot * A1dot_2;
T(:,:,3) =  A0_1 * A1_1dot * A1dot_2 * A2_3;
T(:,:,4) =  A0_1 * A1_1dot * A1dot_2 * A2_3 * A3_4;   

