

%% Control model for MCP joint (ab/ad and f/e angles) 
clc
clear

old = digits(2);

syms q1 q2 q3 q4 q5 real;    
syms dq1 dq2 dq3 dq4 dq5 real; 
syms ddq1 ddq2 ddq3 ddq4 ddq5 real; 

syms c1 c2 c3 c4 k1 k2 k3 k4 real;
syms L1 L2 L3 L4 L5 real;
syms m1 m2 m3 m4 m5 real;


g1 = [0; L1/2; 0]; 
g2 = [0; L2/2; 0]; 
g3 = [0; L3/2; 0]; 
g4 = [0; L4/2; 0]; 
g5 = [0; L5/2; 0]; 


g = 9.82;

DH = [  0      0       q1   0;
        L1  pi/2    0   q2;
        L2 -pi/2    0   q3;
        L3    0     0   q4;
        L4  pi/2    0   0  ];

T01 = DHmatrix(0, 0, q1, 0);
T12 = DHmatrix(L1, pi/2, 0, q2);
T23 = DHmatrix(L2, -pi/2, 0, q3);
T34 = DHmatrix(L3, 0, 0, q4);
T45 = DHmatrix(L4, pi/2, 0, 0);

T02 = vpa(T01 * T12);
T03 = vpa(T02 * T23);
T04 = vpa(T03 * T34);
T05 = vpa(T04 * T45);

threshold = 1e-10;  

numeric_M = double(subs(T02, [q1, q2, L1], ones(1,3))); 
T02(abs(numeric_M) < threshold) = 0;
numeric_M = double(subs(T03, [q1, q2,q3, L1,L2], ones(1,5))); 
T03(abs(numeric_M) < threshold) = 0;

numeric_M = double(subs(T04, [q1, q2,q3,q4, L1,L2,L3], ones(1,7))); 
T04(abs(numeric_M) < threshold) = 0;

numeric_M = double(subs(T05, [q1, q2,q3,q4, L1,L2,L3,L4], ones(1,8))); 
T05(abs(numeric_M) < threshold) = 0;

