clear all;
%motor model
Torque_mul = 100; %x100 ���� �� ��ũ�� ��. �������� �� �����ϸ� 1V�� ������ 100N�� ������ �ǹ�
Back_electro_force = 0; % 1m/s = 2V -> 1m/s = 200N

%pendulum model
MM = 5; % M = 1kg
rr = 0.1; % M �� ������
II = 0.5*MM*rr^2; %M�� ���� ���Ʈ
mm = 5; % m = 9kg
LL = 1.0; % L = 2m

Damping_x = 5.5; %0.1N/(m/s) x�� ����
Culc_Damping_x = Damping_x;
%��������
gg = 9.8;
x_start = 0; %0m���� ����
theta_start = 179; %10deg ���� ����.

%������ ���
PP = (mm^2*LL^2)/(II + mm*LL^2); %
TM = (MM + mm); % ��Ż ����
AA = [  0 1 0 0;
        0 -Culc_Damping_x/(TM - PP) PP*gg/(TM - PP) 0;
        0 0 0 1;
        0 -Culc_Damping_x/(mm*LL*(TM/PP - 1)) gg*TM/(mm*LL*(TM/PP - 1)) 0]

BB = [0; 1/(TM - PP); 0; 1/(mm*LL*(TM/PP - 1))]
QQ = [  100 0 0     0;
        0   0 0     0;
        0   0 100   0;
        0   0 0     0     ];
R = 0.1;

lqr_k = -lqr(AA,BB,QQ,R)