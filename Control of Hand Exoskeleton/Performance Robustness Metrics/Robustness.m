%% Robustness Metrics Evaluation for Nonlinear System


%% Compute Disturbance Rejection Index (DRI)
error_nominal = ref - output_nominal;
error_disturbed = ref - output_disturbed;

DRI = norm(error_disturbed) / norm(error_nominal);



%% Compute Gap Metric
freqs = logspace(-2, 2, 100);
[mag_nominal, ~] = bode(G_perturbed, freqs);
[mag_disturbed, ~] = bode(1.1*G_perturbed, freqs); 

gap_metric = norm(mag_nominal - mag_disturbed) / norm(mag_nominal);

fprintf('Disturbance Rejection Index (DRI): %.4f\n', DRI);
fprintf('Gap Metric: %.4f\n', gap_metric);

figure;
subplot(2,1,1);
plot(t, ref, 'k--', 'LineWidth', 1.5); hold on;
plot(t, output_nominal, 'b', 'LineWidth', 1.2);
plot(t, output_disturbed, 'r', 'LineWidth', 1.2);
legend('Reference', 'Nominal Output', 'Disturbed Output');
title('System Response');
xlabel('Time (s)'); ylabel('Output');

subplot(2,1,2);
plot(t, abs(error_nominal), 'b', 'LineWidth', 1.2); hold on;
plot(t, abs(error_disturbed), 'r', 'LineWidth', 1.2);
legend('Error (Nominal)', 'Error (Disturbed)');
title('Error Comparison');
xlabel('Time (s)'); ylabel('Absolute Error');

