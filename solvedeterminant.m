syms theta1 theta2 theta3 theta4
eqn = (248*cos(theta1)*(192*cos(theta2 - theta3) + 93*cos(theta2 + 2*theta3) - 494*sin(theta2 - theta3) + 496*sin(theta2 + 2*theta3) + (189*cos(theta2 + 2*theta3 + theta4))/2 + 504*sin(theta2 + 2*theta3 + theta4) + (189*cos(theta2 + theta4))/2 + 530*sin(theta2 + theta3) - 504*sin(theta2 + theta4) + 93*cos(theta2) - 496*sin(theta2)))/125 == 0;

S = solve(eqn, [theta1 theta2 theta3 theta4])