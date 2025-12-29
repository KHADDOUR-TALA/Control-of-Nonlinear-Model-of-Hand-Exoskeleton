%% Function to Compute Metrics 
function metrics = compute_metrics(t, ref, output)
    error = ref - output;
    
    RMSE = sqrt(mean(error.^2));

    steady_state_error = abs(mean(error(end - round(0.1*length(error)):end)));

    final_value = ref(end);
    idx_rise_start = find(output >= 0.1 * final_value, 1);
    idx_rise_end = find(output >= 0.9 * final_value, 1);
    rise_time = t(idx_rise_end) - t(idx_rise_start);

    settling_idx = find(abs(error) <= 0.02 * abs(final_value), 1, 'first');
    settling_time = t(settling_idx);

    max_value = max(output);
    overshoot = ((max_value - final_value) / final_value) * 100;
    
    if std(diff(ref) ./ diff(t)) < 0.01 
        slope_ref = mean(diff(ref) ./ diff(t));
        slope_out = mean(diff(output) ./ diff(t));
        if ~isnan(slope_ref) && ~isnan(slope_out)
            slope_error = abs(slope_ref - slope_out);
        else
            slope_error = NaN;  
        end
    else
        slope_error = NaN;  
    end

    if max(ref) - min(ref) > 0.5 * max(ref)  
        [~, peak_idx_ref] = findpeaks(ref, t);  
        [~, peak_idx_out] = findpeaks(output, t); 
        
        if ~isempty(peak_idx_ref) && ~isempty(peak_idx_out)
            phase_lag = mean(peak_idx_out - peak_idx_ref) * (360 / (t(end) - t(1))); 
        else
            phase_lag = NaN;  
        end
    else
        phase_lag = NaN;  
    end

    metrics = struct('RMSE', RMSE, ...
                     'SteadyStateError', steady_state_error, ...
                     'RiseTime', rise_time, ...
                     'SettlingTime', settling_time, ...
                     'Overshoot', overshoot, ...
                     'SlopeError', slope_error, ...
                     'PhaseLag', phase_lag);
end
