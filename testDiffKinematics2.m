syms theta1 theta2 theta3 theta4 a1 a2 a3 a4 d1 d2 d3 d4
z0 = [0;0;1]
p0 = [0;0;0]
z1 = [0;0;1]
z2 = [0;0;1]
z3 = [0;0;1]
z4 = [0;0;-1]
p1 = [a1*cos(theta1); a1 * sin(theta1); d1]
p2 = [a1*cos(theta1); a2 * cos(theta1+theta2); d1]
p3 = [a1*cos(theta1); a2 * cos(theta1+theta2); d1 + d3]
p4 = [a1*cos(theta1); a2 * cos(theta1+theta2); d1 + d3 + d4]
column1 = cross(z0, (p4 - p0))
column2 = cross(z1, (p4 - p1))
column3 = cross(z2, (p4 - p2))
column4 = cross(z3, (p4 - p3))
matrixtop = [column1, column2, [0;0;1], column4]
matrixbot = [z0, z1, [0;0;0], z3]
matrixfull = cat(1, matrixtop, matrixbot)
X = transpose(matrixfull) * matrixfull
M = det(X)
simplify(M)