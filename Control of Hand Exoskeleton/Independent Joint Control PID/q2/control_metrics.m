function metrics = control_metrics(t, ref,y)

    t = t(:);
    y = y(:);

    if length(ref) == 1
        ref = ref * ones(size(y)); 
    end


    e_ss = abs(ref(end) - y(end));

    ITAE = trapz(t, t .* abs(ref - y));

    ss_val = ref(end);
    tolerance = 0.02 * abs(ss_val); 
    settling_idx = find(abs(y - ss_val) > tolerance, 1, 'last');
    if isempty(settling_idx)
        settling_time = 0; 
    else
        settling_time = t(settling_idx);
    end

    
    overshoot = (max(y) - ss_val) / abs(ss_val) * 100;
   
    y_min = 0.1 * ss_val;
    y_max = 0.9 * ss_val;
    rise_idx1 = find(y >= y_min, 1, 'first');
    rise_idx2 = find(y >= y_max, 1, 'first');
    if isempty(rise_idx1) || isempty(rise_idx2)
        rise_time = NaN; % Cannot determine rise time
    else
        rise_time = t(rise_idx2) - t(rise_idx1);
    end

    metrics = struct('steady_state_error', e_ss, ...
                     'ITAE', ITAE, ...
                     'settling_time', settling_time, ...
                     'overshoot', overshoot, ...
                     'rise_time', rise_time);
end

