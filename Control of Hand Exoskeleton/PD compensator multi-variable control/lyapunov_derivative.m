function dV = lyapunov_derivative(q, dq, q_d, M, G)
    q_tilde = q - q_d

    Kp = diag([30, 30]);
    KD=diag([8, 8]);

    u = -Kp * q_tilde + G'-KD*dq;

    dV = -dq' *KD * dq; 
end
