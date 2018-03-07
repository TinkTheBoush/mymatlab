clear all;
%motor model
Torque_mul = 100; %x100 ���� �� ��ũ�� ��. �������� �� �����ϸ� 1V�� ������ 100N�� ������ �ǹ�
Back_electro_force = 0; % 1m/s = 2V -> 1m/s = 200N

%pendulum model
MM = 2; % M = 1kg
mm = 8; % m = 9kg
LL1 = 1; % L1 = 1m
LL2 = 1.0; %L2 = 2.5m
LL12 = LL1*LL2;

Damping_theta1 = 1.5;%5.5; %5.5N*m per deg/s
Damping_theta2 = 1.5;%1.5; %1.5N*m per deg/s
%��������
gg = 9.8;
theta1_start = 0; %0m���� ����
theta2_start = 179; %10deg ���� ����.

%������ ���
PP = (mm^2*LL2^2)/(mm*LL2^2); %
TM = (MM + mm); % ��Ż ����

AA = [0 1 0 0;
    0 +Damping_theta1/(MM*LL1^2) -(mm*gg)/(MM*LL1) +Damping_theta2/(MM*LL12);
    0 0 0 1;
    0 -Damping_theta1/(MM*LL12) +(TM*gg)/(MM*LL12) -(TM*Damping_theta2)/(MM*mm*LL2^2)];
BB = [0;
    -1/(MM*LL1^2);
    0;
    1/(MM*LL12)];
QQ = [10000 0 0 0;
    0 0 0 0;
    0 0 10000 0;
    0 0 0 0];
R = 1;

LQR_K = lqr(AA,BB,QQ,R)
