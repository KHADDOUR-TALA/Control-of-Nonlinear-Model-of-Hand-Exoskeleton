clear; clc; close all;

q0 = 0; v0 = 0; ac0 = 0; 
q1 = 30*pi/180; v1 = 0; ac1 = 0; 
t0 = 0; tf = 5; 
q01 = -10*pi/180;
q11 = 40*pi/180;
t0 = 0; tf = 5; 
t = linspace(t0, tf, 500);
c = ones(size(t));

%% Quintic Polynomial Trajectory
M = [ 1 t0 t0^2 t0^3 t0^4 t0^5;
      0 1 2*t0 3*t0^2 4*t0^3 5*t0^4;
      0 0 2 6*t0 12*t0^2 20*t0^3;
      1 tf tf^2 tf^3 tf^4 tf^5;
      0 1 2*tf 3*tf^2 4*tf^3 5*tf^4;
      0 0 2 6*tf 12*tf^2 20*tf^3];

b = [q0; v0; ac0; q1; v1; ac1];
a = M \ b;

qd1 = a(1).*c + a(2).*t + a(3).*t.^2 + a(4).*t.^3 + a(5).*t.^4 + a(6).*t.^5;
vd1 = a(2).*c + 2*a(3).*t + 3*a(4).*t.^2 + 4*a(5).*t.^3 + 5*a(6).*t.^4;
ad1 = 2*a(3).*c + 6*a(4).*t + 12*a(5).*t.^2 + 20*a(6).*t.^3;
y1= [t' qd1'];

%% Quintic Polynomial Trajectory
M = [ 1 t0 t0^2 t0^3 t0^4 t0^5;
      0 1 2*t0 3*t0^2 4*t0^3 5*t0^4;
      0 0 2 6*t0 12*t0^2 20*t0^3;
      1 tf tf^2 tf^3 tf^4 tf^5;
      0 1 2*tf 3*tf^2 4*tf^3 5*tf^4;
      0 0 2 6*tf 12*tf^2 20*tf^3];

b = [q01; v0; ac0; q11; v1; ac1];
a = M \ b;

qd11 = a(1).*c + a(2).*t + a(3).*t.^2 + a(4).*t.^3 + a(5).*t.^4 + a(6).*t.^5;
vd1 = a(2).*c + 2*a(3).*t + 3*a(4).*t.^2 + 4*a(5).*t.^3 + 5*a(6).*t.^4;
ad1 = 2*a(3).*c + 6*a(4).*t + 12*a(5).*t.^2 + 20*a(6).*t.^3;
y2= [t' qd11'];

