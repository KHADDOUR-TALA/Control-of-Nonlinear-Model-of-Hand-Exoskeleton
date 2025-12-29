clc
clear


%%%%%%%%%%%%%%% Dynamic Model Of Hand Exoskeleton %%%%%%%%%%%%%%%%%

%% Control model for MCP joint (ab/ad and f/e angles)

syms q1 q2 q3 q4 q5 real;     % Joint angles
syms dq1 dq2 dq3 dq4 dq5 real; % Joint velocities
syms ddq1 ddq2 ddq3 ddq4 ddq5 real; % Joint accelerations

syms c1 c2 c3 c4 k1 k2 k3 k4 g real;
syms L1 L2 L3 L4 L5 real;

syms m1 m2 m3 m4 m5 I1 I2 I3 I4 I5 real;

% % Link lengths 
% L1 = 12; L2 = 20; L3 = 45; L4 = 15; L5 = 20;
% 
% % Link masses 
% m1 = 100; m2 = 70; m3 = 170; m4 = 100; m5 = 20;

g1 = [0; L1/2; 0]; 
g2 = [0; L2/2; 0]; 
g3 = [0; L3/2; 0]; 
g4 = [0; L4/2; 0]; 
g5 = [0; L5/2; 0]; 




T01 =[ 1, 0, 0,  0;
    0, 1, 0,  0;
 0, 0, 1, q1;
0, 0, 0,  1];

T02 =[ cos(q2),   0,      sin(q2), L1*cos(q2);
 sin(q2),   0, -1.0*cos(q2), L1*sin(q2);
       0, 1.0,            0,         q1;
       0,   0,            0,        1.0];

   
T03 =simplify([ cos(q2)*cos(q3) , - 1.0*sin(q2) ,  - 1.0*cos(q2)*sin(q3), L1*cos(q2) + L2*cos(q2)*cos(q3);
  cos(q3)*sin(q2),   1.0*cos(q2),  - 1.0*sin(q2)*sin(q3), L1*sin(q2)  + L2*cos(q3)*sin(q2);
 1.0*sin(q3), 0,   1.0*cos(q3),  q1 + 1.0*L2*sin(q3);
 0,        0,  0,    1.0]);


 
 T04 =simplify([ cos(q4)*(cos(q2)*cos(q3)) - sin(q4)*sin(q2), - sin(q4)*(cos(q2)*cos(q3) ) - cos(q4)*(sin(q2)),  - cos(q2)*sin(q3) , L1*cos(q2) - L3*sin(q4)*sin(q2) + (L2+L3*cos(q4))*cos(q2)*cos(q3)  ;
     cos(q4)*( cos(q3)*sin(q2)) + sin(q4)*cos(q2) ,       cos(q4)*(cos(q2) ) - sin(q4)*( cos(q3)*sin(q2)),  - sin(q2)*sin(q3),     L1*sin(q2) + L3*sin(q4)*(cos(q2)) + L3*cos(q4)*(cos(q3)*sin(q2))  + L2*cos(q3)*sin(q2);
        cos(q4)*sin(q3) ,   -sin(q3)*sin(q4),  cos(q3) ,  q1 + L2*sin(q3) + L3*cos(q4)*sin(q3);
   0,    0,  0,   1.0]);
 

T05=[ cos(q4)*cos(q2)*cos(q3)-sin(q4)*sin(q2),-cos(q2)*sin(q3),sin(q4)*(cos(q2)*cos(q3) ) + cos(q4)*sin(q2),L1*cos(q2)-(L3+L4)*sin(q4)*sin(q2)+(L2+(L3+L4)*cos(q4))*cos(q2)*cos(q3) ;
    cos(q4)*cos(q3)*sin(q2)+sin(q4)*cos(q2), -sin(q2)*sin(q3), sin(q4)*cos(q3)*sin(q2)- cos(q4)*cos(q2),(L1+(L2+(L3+L4)*cos(q4))*cos(q3))*sin(q2)+(L4+L3)*sin(q4)*cos(q2);
    cos(q4)*sin(q3), cos(q3), sin(q3)*sin(q4) ,q1+L2*sin(q3)+(L3+L4)*(cos(q4)*sin(q3) ) ;
  0,0,0,1.0
];
 





% Generalized coordinates and their derivatives
q = [q1; q2; q3; q4; q5];
dq = [dq1; dq2; dq3; dq4; dq5];
ddq = [ddq1; ddq2; ddq3; ddq4; ddq5];

%% Velocity Calculation (Analytical method)


z0 = [0; 0; 1]; 

o0 = [0; 0; 0];
o1 = T01(1:3, 4);
o2 = T02(1:3, 4);
o3 = T03(1:3, 4);
o4 = T04(1:3, 4);
o5 = T05(1:3, 4);

% Linear velocity of the center of mass (J_v) - Linear part of Jacobian
J_v1 = cross(z0, (o1 - o0));
J_v2 = cross(T01(1:3,3), (o2 - o1));
J_v3 = cross(T02(1:3,3), (o3 - o2));
J_v4 = cross(T03(1:3,3), (o4 - o3));
J_v5 = cross(T04(1:3,3), (o5 - o4));

% Angular velocity of each frame (J_w) - Rotational part of Jacobian
J_w1 = z0;
J_w2 = T01(1:3, 3);
J_w3 = T02(1:3, 3);
J_w4 = T03(1:3, 3);
J_w5 = T04(1:3, 3);

% Compute linear velocities (v) using the Jacobian approach
v1 =simplify( J_v1 * dq1);
v2 =simplify( J_v2 * dq2);
v3 =simplify( J_v3 * dq3);
v4 =simplify (J_v4 * dq4);
v5 =simplify( J_v5 * dq5);

% Angular velocities (omega)
omega1 = J_w1 * dq1;
omega2 = J_w2 * dq2;
omega3 = J_w3 * dq3;
omega4 = J_w4 * dq4;
omega5 = J_w5 * dq5;

%orientation transformation matrices
R1=T01(1:3, 1:3);
R2=T02(1:3, 1:3);
R3=T03(1:3, 1:3);
R4=T04(1:3, 1:3);
R5=T05(1:3, 1:3);
%% Kinetic Energy (T) for each link
T1 = (1/2) * m1 * dot(v1, v1) + (1/2) * omega1.' * R1 * I1 * R1 * omega1;
T2 = (1/2) * m2 * dot(v2, v2) + (1/2) * omega2.' * R2 * I2 * R2 * omega2;
T3 = (1/2) * m3 * dot(v3, v3) + (1/2) * omega3.' * R3 * I3 * R3 * omega3;
T4 = (1/2) * m4 * dot(v4, v4) + (1/2) * omega4.' * R4 * I4 * R4 * omega4;
T5 = (1/2) * m5 * dot(v5, v5) + (1/2) * omega5.' * R5 * I5 * R5 * omega5;




T =simplify( T1 + T2 + T3 + T4 + T5);

%% Potential Energy (V) for each link
V1 = m1 * g * o1(3); 
V2 = m2 * g * o2(3);
V3 = m3 * g * o3(3);
V4 = m4 * g * o4(3);
V5 = m5 * g * o5(3);


V =simplify( V1 + V2 + V3 + V4 + V5);


L =simplify( T - V);


q = [ q2; q3; ];
dq = [dq2; dq3; ];
ddq = [ ddq2; ddq3;];


%% Equations of motion
dL_dq = simplify(jacobian(L, q).');
dL_ddq =simplify( jacobian(L, dq).');

d_dt_dL_ddq = jacobian(dL_ddq, [q; dq]) * [dq; ddq];

EOM = simplify(d_dt_dL_ddq - dL_dq);

%% Torque Calculation 

% Extract the inertia matrix (M), Coriolis/centrifugal matrix (C), and gravity vector (G)
M = jacobian(EOM, ddq)
G = simplify(jacobian(V, q).')

C = simplify(EOM - M*ddq-G)       


 
tau = M * ddq + C + G;



disp('Torques (tau):');
disp(tau);