function metrics = compute_nonlinear_robustness(td, d,t1, y1,t2, y2)
    % Computes robustness metrics for a nonlinear system
    %
    % Inputs:
    %   t  - Time vector
    %   d  - Disturbance input signal
    %   y1 - System output without perturbation (Nominal)
    %   y2 - System output with perturbation (Uncertain system)
    %
    % Outputs:
    %   metrics - Structure containing all robustness metrics

    td = td(:); d = d(:); y1 = y1(:); y2 = y2(:);t1=t1(:);t2=t2(:);

    E_d = sqrt(trapz(td, d.^2)); 
    E_y = sqrt(trapz(t1, y1.^2)); 
    L2_gain = E_y / E_d;

    Y1_fft = fft(y1); 
    Y2_fft = fft(y2); 
    freq_response_diff = abs(Y1_fft - Y2_fft) ./ (1 + abs(Y1_fft));
    V_gap = max(freq_response_diff);

    DRI = max(abs(y2 - y1)) / max(abs(d));


    gap_metric = norm(y1 - y2, 2) / norm(y1, 2); 

    ITAE = trapz(t1, t1 .* abs(y1 - y2));

    [~, peak_idx_y1] = max(y1);
    [~, peak_idx_y2] = max(y2);
    phase_margin_dev = (t2(peak_idx_y2) - t1(peak_idx_y1)) * 360 / (t1(end) - t1(1));
    metrics = struct('L2_Gain', L2_gain, ...
                     'V_Gap', V_gap, ...
                     'DRI', DRI, ...
                     'Gap_Metric', gap_metric, ...
                     'ITAE', ITAE, ...
                     'Phase_Margin_Deviation', phase_margin_dev);

    fprintf('\nRobustness Metrics:\n');
    fprintf('L2 Gain: %.4f\n', L2_gain);
    fprintf('V-Gap Metric: %.4f\n', V_gap);
    fprintf('Disturbance Rejection Index (DRI): %.4f\n', DRI);
    fprintf('Gap Metric: %.4f\n', gap_metric);
    fprintf('ITAE: %.4f\n', ITAE);
    fprintf('Phase Margin Deviation: %.4f degrees\n', phase_margin_dev);
end
