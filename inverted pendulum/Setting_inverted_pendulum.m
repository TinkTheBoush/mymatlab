clear all;
%motor model
Torque_mul = 100; %x100 전압 대 토크의 비. 역기전력 을 제외하면 1V를 넣으면 100N이 나옴을 의미
Back_electro_force = 0; % 1m/s = 2V -> 1m/s = 200N

%pendulum model
MM = 5; % M = 1kg
rr = 0.1; % M 의 반지름
II = 0.5*MM*rr^2; %M의 관성 모멘트
mm = 5; % m = 9kg
LL = 1.0; % L = 2m

Damping_x = 5.5; %0.1N/(m/s) x축 마찰
Culc_Damping_x = Damping_x;
%사전설정
gg = 9.8;
x_start = 0; %0m에서 시작
theta_start = 179; %10deg 에서 시작.

%방정식 계산
PP = (mm^2*LL^2)/(II + mm*LL^2); %
TM = (MM + mm); % 토탈 질량
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