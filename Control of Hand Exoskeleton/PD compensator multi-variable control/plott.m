figure
subplot(2,1,1);
plot(simout.time(:,1),simout.data(:,1),'k',simout.time(:,1),simout.data(:,2),'b','lineWidth',1.5)
title('controlling q2 using PD controller');
grid on
xlabel('time');
ylabel('q2');
legend('Reference', 'q2');
subplot(2,1,2);
plot(simout1.time(:,1),simout1.data(:,2),'K',simout1.time(:,1),simout1.data(:,1),'b','lineWidth',1.5)
title('controlling q3 using PD control');
grid on
xlabel('time');
ylabel('q3');
legend('Reference','q3' );
figure
subplot(2,1,1);
plot(simout2.time(:,1),simout2.data(:,1),'r','lineWidth',1.5)
title('tracking error of q2 using Multi-variable nonlinear PD control');
grid on
xlabel('time');
ylabel('q2');
subplot(2,1,2);
plot(simout3.time(:,1),simout3.data(:,1),'r','lineWidth',1.5)
title('tracking error of q3 using Multi-variable nonlinear PD control');
grid on
xlabel('time');
ylabel('q3');
