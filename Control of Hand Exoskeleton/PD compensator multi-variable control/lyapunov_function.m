t = simout.Time(:,1);
q1 = simout.Data(:,1);
q2 = simout.Data(:,2); 
q_d1 = simout.Data(:,1);
q_d2 = simout1.Data(:,1);
dq1 = simout2.Data(:,1);
dq2 = simout5.Data(:,1);
DD=simout3.Data(1,:)
V = arrayfun(@(i) lyapunov_function1([q1(i); q2(i)], [dq1(i); dq2(i)], ...
                [q_d1(i); q_d2(i)], simout4(:,:,i), simout3.Data(i,:)), 1:length(t));

dV = arrayfun(@(i) lyapunov_derivative([q1(i); q2(i)], [dq1(i); dq2(i)], ...
                [q_d1(i); q_d2(i)],simout4(:,:,i), simout3.Data(i,:)), 1:length(t));

r = V ./ max(abs(dV), 1e-6);  

figure;
subplot(2,1,1);
plot(t, V, 'r', 'LineWidth', 2);
xlabel('Time (s)'); ylabel('V(x)'); title('Lyapunov Function V(x)');
grid on;

subplot(2,1,2);
plot(t, dV, 'b', 'LineWidth', 2);
xlabel('Time (s)'); ylabel('dV/dt'); title('Time Derivative of V(x)');
grid on;

% subplot(3,1,3);
% plot(t, r, 'k', 'LineWidth', 2);
% xlabel('Time (s)'); ylabel('r = V/dV'); title('Lyapunov Rate');
% grid on;
