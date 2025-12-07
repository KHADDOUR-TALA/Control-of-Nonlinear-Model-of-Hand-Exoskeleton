clear; clc; close all;

q0 = 0; v0 = 0; ac0 = 0; % Initial position, velocity, acceleration
q1 = 10; v1 = 0; ac1 = 0; % Final position, velocity, acceleration
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

%% Cubic Polynomial Trajectory
M = [ 1 t0 t0^2 t0^3;
      0 1 2*t0 3*t0^2;
      1 tf tf^2 tf^3;
      0 1 2*tf 3*tf^2];

b = [q0; v0; q1; v1];
a = M \ b;

qd2 = a(1).*c + a(2).*t + a(3).*t.^2 + a(4).*t.^3;
vd2 = a(2).*c + 2*a(3).*t + 3*a(4).*t.^2;
ad2 = 2*a(3).*c + 6*a(4).*t;

%% LSPB 
Vm = 3.5; 
Td = 1; 
T_total = tf; 
dt = (tf - t0) / length(t);
q_LSPB = zeros(size(t));
V_LSPB = zeros(size(t));
A_LSPB = zeros(size(t));

for i = 1:length(t)
    if t(i) < Td
        V_LSPB(i) = Vm * (t(i) / Td);
        A_LSPB(i) = Vm / Td;
        q_LSPB(i) = q0 + V_LSPB(i)/Td*0.5* t(i)^2;
    elseif t(i) < T_total - Td
        V_LSPB(i) = Vm;
        A_LSPB(i) = 0;
        q_LSPB(i) = (q1+q0 - V_LSPB(i)*tf)*0.5+V_LSPB(i)*t(i);
    else
        V_LSPB(i) = Vm * (T_total - t(i)) / Td;
        A_LSPB(i) = -Vm / Td;
        alpha=Vm / Td;
        q_LSPB(i) = (q1- alpha*0.5*tf^2)+alpha*tf*t(i)- alpha*0.5*t(i)^2;
    end
    if i > 1
        
    end
end

figure;

title('Trajectory Comparison');
subplot(3,1,1);
plot(t, qd1, 'b', t, qd2, 'r', t, q_LSPB, 'g', 'LineWidth', 1.5);
title('Position');
xlabel('Time (s)');
ylabel('Position');
legend('Quintic', 'Cubic', 'LSPB');

subplot(3,1,2);
plot(t, vd1, 'b', t, vd2, 'r', t, V_LSPB, 'g', 'LineWidth', 1.5);

title('Velocity');
xlabel('Time (s)');
ylabel('Velocity');
legend('Quintic', 'Cubic', 'LSPB');
ylim([-1 Vm+1])
subplot(3,1,3);
plot(t, ad1, 'b', t, ad2, 'r', t, A_LSPB, 'g', 'LineWidth', 1.5);
title('Acceleration');
xlabel('Time (s)');
ylabel('Acceleration');
legend('Quintic', 'Cubic', 'LSPB');

