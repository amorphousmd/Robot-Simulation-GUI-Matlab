function forwardUpdateIncrement(theta1, theta2, theta3, theta4)
global theta1Old;
global theta2Old;
global theta3Old;
global theta4Old;
global endEffectorX;
global endEffectorY;
global endEffectorZ;
theta1Points = linspace(theta1Old, theta1, 20)
theta2Points = linspace(theta2Old, theta2, 20)
theta3Points = linspace(theta3Old, theta3, 20)
theta4Points = linspace(theta4Old, theta4, 20)
for i = 1:20
    forwardUpdate(theta1Points(i), theta2Points(i), theta3Points(i), theta4Points(i))
    pause(0.0001)
end

end