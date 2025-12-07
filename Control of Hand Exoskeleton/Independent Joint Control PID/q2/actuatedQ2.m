close all;
L1 = 12/1000; L2 = 20/1000; L3 = 45/1000; L4 = 15/1000; L5 = 20/1000;
m1 = 100; m2 = 70; m3 = 170; m4 = 100; m5 = 20;x=1/1000;
I1 = m1*L1^2/3; I2 = m2*L2^2/3; I3 = m3*L3^2/3; I4 =m4*L4^2/3; I5 = m5*L5^2/3;
V=47/1000;
H=20/1000;
aq3=0;
q3=20*pi/180;
dq3=0;
aq2=-0.1:0.001:0.1;
q2=zeros(size(aq2,2),1);
dq2=zeros(size(aq2,2),1);
tau2=zeros(size(aq2,2),1);
q2(1)=10*pi/90;
dq2(1)=0.1;
for i=1:size(aq2,2)-3
        ddq2=aq2(i)*pi/90;
        ddq3=aq3*pi/90;
        q1 = (L1 - V) * tan(q2(i));
        q4=q3;
        dq4=dq3;
        q5=(H-L4*cos(q3+q4)-L3*cos(q3))/cos(q3+q4);
        dq5=(L3*sin(q3)*dq3*cos(q3+q4)+sin(q3+q4)*(dq3+dq4)*(H-L3*cos(q3)))/cos(q3+q4)^2;
        ddq = [ ddq2; ddq3;];
        g = 9.82;
        M=[m2*L1^2-I2*cos(q2(i)) 0;
            0 L2^2*m3-I3*cos(q3)+I3*cos(q2(i))^2+I3*cos(q2(i))^2*cos(q3)];
        invM=inv(M);
        C=[ (I2*dq2(i)^2*sin(q2(i)))/2 + (I3*dq3^2*sin(2*q2(i)))/2 - (I5*dq5^2*sin(2*q2(i)))/2 - (I4*dq4^2*cos(q2(i))*sin(q4))/2 - (I4*dq4^2*cos(q4)*sin(q2(i)))/2 + (I4*dq4^2*cos(q2(i))*cos(q3)^2*sin(q4))/2 + (I4*dq4^2*cos(q3)^2*cos(q4)*sin(q2(i)))/2 + I5*dq5^2*cos(q2(i))*cos(q3)^2*sin(q2(i)) - (I5*dq5^2*cos(q2(i))*cos(q3)^2*sin(q4))/2 + I3*dq3^2*cos(q2(i))*cos(q3)*sin(q2(i)) - (I5*dq5^2*cos(q3)*cos(q4)*sin(q2(i)))/2 - (I5*dq5^2*cos(q3)*cos(q4)*sin(q3))/2 + I5*dq5^2*cos(q2(i))^2*cos(q3)*cos(q4)*sin(q3) - I5*dq5^2*cos(q2(i))*sin(q2(i))*sin(q3)*sin(q4);
         (I3*dq3^2*sin(q3))/2 + (I4*dq4^2*sin(2*q3))/2 - (I5*dq5^2*sin(2*q3))/2 - (I3*dq3^2*cos(q2(i))^2*sin(q3))/2 - I3*dq2(i)*dq3*sin(2*q2(i)) + I5*dq5^2*cos(q2(i))^2*cos(q3)*sin(q3) + (I5*dq5^2*cos(q2(i))^2*cos(q3)*sin(q4))/2 - (I5*dq5^2*cos(q2(i))*cos(q4)*sin(q2(i)))/2 - (I5*dq5^2*cos(q2(i))*cos(q4)*sin(q3))/2 + I5*dq5^2*cos(q2(i))*cos(q3)^2*cos(q4)*sin(q2(i)) + I4*dq4^2*cos(q2(i))*cos(q3)*cos(q4)*sin(q3) - I4*dq4^2*cos(q3)*sin(q2(i))*sin(q3)*sin(q4) + I5*dq5^2*cos(q3)*sin(q2(i))*sin(q3)*sin(q4) - 2*I3*dq2(i)*dq3*cos(q2(i))*cos(q3)*sin(q2(i))];
        G=[0;
         g*cos(q3)*(L2*m3 + L2*m4 + L2*m5 + L3*m4*cos(q4) + L3*m5*cos(q4) + L4*m5*cos(q4))];
        tau = M * ddq + C + G;
        tau2(i)=tau(1);
        tau3=tau(2);
        dq2(i+1)=dq2(i)+ddq2*0.1;
        q2(i+1)=q2(i)+dq2(i)*0.1;
    end
T2=timeseries(tau2);
Q2=timeseries(q2);
%Mabuchi RS-550 DC motor
Jmk=3*10^(-6); %kg·mm^2
Bmk=1.5*10^(-6); %N/rpm
Kbk=1.5*10^(-6); %V/rpm
Kmk=0.01; %Nm/A
Rk=0.8; %ohm
dkk=10^(-6);%
r=10;
Jeff=Jmk +dkk/(r)^2
Beff= Bmk + Kbk*Kmk/Rk
%uk=Kmk/RkVk
K=1 ;
w=0.9;
zeta=0.7;
set1=[2000 100 0.01];
set2=[2000 100 0.05];
set3=[2500 100 0.01];
KP1=w^2*Jeff/K*set1(1);KP2=KP1;
KD1=(2*zeta*w*Jeff-Beff)/K*set1(2);KD2=KD1;
KI1=(Beff+K*KD1)*KP1/Jeff*set1(3);KI2=KI1;

KP3=w^2*Jeff/K*set2(1);KP4=KP3;
KD3=(2*zeta*w*Jeff-Beff)/K*set2(2);KD4=KD3;
KI3=(Beff+K*KD3)*KP3/Jeff*set2(3);KI4=KI3;

KP5=w^2*Jeff/K*set3(1);KP6=KP5;
KD5=(2*zeta*w*Jeff-Beff)/K*set3(2);KD6=KD5;
KI5=(Beff+K*KD5)*KP5/Jeff*set3(3);KI6=KI5;
c=1;

subplot(2,1,1);
plot(ver1(:,1),ver1(:,2)*c,'k',ver1(:,1),ver1(:,3)*c,'r',ver3(:,1),ver3(:,3)*c,'b',ver5(:,1),ver5(:,3)*c,'g','lineWidth',1.5)
title('controlling q2 without the actuator load torques');
grid on
xlabel('time');
ylabel('theta');
legend('Reference', 'set1','set2','set3');
subplot(2,1,2);
plot(ver2(:,1),ver2(:,2)*c,'k',ver2(:,1),ver2(:,3)*c,'r',ver4(:,1),ver4(:,3)*c,'b',ver6(:,1),ver6(:,3)*c,'g','lineWidth',1.5)
title('controlling q2 with the actuator load torques');
grid on
xlabel('time');
ylabel('theta');
legend('Reference', 'set1','set2','set3');
disp('without the actuator load torques')
woPID1=control_metrics(ver1(:,1), ver1(:,2), ver1(:,3))
woPID2=control_metrics(ver1(:,1), ver1(:,2), ver3(:,3))
woPID3=control_metrics(ver1(:,1), ver1(:,2), ver5(:,3))
disp('with the actuator load torques')
wPID1=control_metrics(ver2(:,1), ver2(:,2), ver2(:,3))
wPID2=control_metrics(ver2(:,1), ver2(:,2), ver4(:,3))
wPID3=control_metrics(ver2(:,1), ver2(:,2), ver6(:,3))