function V = lyapunov_function1(q, dq, q_d, M, G)
    q_tilde = q - q_d; 

    Kp = diag([30, 30]); 

    V = 0.5 * (dq' * M * dq) + 0.5 * (q_tilde' * Kp * q_tilde);
end
