
%% Compute Performance Metrics
metricsq2_step = compute_metrics(q2_step.time(:,1), q2_step.data(:,2), q2_step.data(:,1));
metricsq3_step = compute_metrics(q3_step.time(:,1), q3_step.data(:,2), q3_step.data(:,1));

disp('Step Response Metrics for q2:');
disp(metricsq2_step);
disp('Step Response Metrics for q3:');
disp(metricsq3_step);



metricsq2_ramp = compute_metrics(q2_ramp.time(:,1), q2_ramp.data(:,2), q2_ramp.data(:,1));
metricsq3_ramp = compute_metrics(q3_ramp.time(:,1), q3_ramp.data(:,2), q3_ramp.data(:,1));

disp('Ramp Response Metrics for q2:');
disp(metricsq2_ramp);
disp('Ramp Response Metrics for q3:');
disp(metricsq3_ramp);



metricsq2_sine = compute_metrics(q2_sine.time(:,1)/2, q2_sine.data(:,2), q2_sine.data(:,1));
metricsq3_sine = compute_metrics(q3_sine.time(:,1)/2, q3_sine.data(:,2), q3_sine.data(:,1));

disp('Sine Response Metrics for q2:');
disp(metricsq2_sine);
disp('Sine Response Metrics for q3:');
disp(metricsq3_sine);


figure;
subplot(3,2,1); 
plot(q2_step.time(:,1), q2_step.data(:,2), 'r--', q2_step.time(:,1), q2_step.data(:,1), 'b', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Response'); title('Joint q_2 Step Response'); legend('Reference', 'Output');
grid on;

subplot(3,2,3); 
plot(q2_ramp.time(:,1), q2_ramp.data(:,2), 'r--', q2_ramp.time(:,1), q2_ramp.data(:,1), 'b', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Response'); title('Joint q_2 Ramp Response'); legend('Reference', 'Output');
grid on;

subplot(3,2,5); 
plot(q2_sine.time(:,1)/2, q2_sine.data(:,2), 'r--', q2_sine.time(:,1)/2, q2_sine.data(:,1), 'b', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Response'); title('Joint q_2 Sine Wave Response'); legend('Reference', 'Output');ylim([-1 1]); 
grid on;

subplot(3,2,2); 
plot(q3_step.time(:,1), q3_step.data(:,2), 'r--', q2_step.time(:,1), q3_step.data(:,1), 'b', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Response'); title('Joint q_3 Step Response'); legend('Reference', 'Output');
grid on;

subplot(3,2,4);
plot(q3_ramp.time(:,1), q3_ramp.data(:,2), 'r--', q3_ramp.time(:,1), q3_ramp.data(:,1), 'b', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Response'); title('Joint q_3 Ramp Response'); legend('Reference', 'Output');
grid on;

subplot(3,2,6); 
plot(q3_sine.time(:,1)/2, q3_sine.data(:,2), 'r--', q3_sine.time(:,1)/2, q3_sine.data(:,1), 'b', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Response'); title('Joint q_3 Sine Wave Response'); legend('Reference', 'Output');
ylim([-1 1]); 
grid on;

