clear;
close all;

%%%%%%%%% Part 1 Data Fit %%%%%%%%%



% Step 1: Load the data from the 'COVID_STL.mat' file
load('COVID_STL.mat');

% normalizing cases and deaths by population
normalized_cases = cases_STL / POP_STL;
normalized_deaths = deaths_STL / POP_STL;




% %%%DATA FROM DAYS BEFORE FIRST PHASE%%%%%
selected_dates_phase1 = dates(1:68);
selected_dates_phase1a = dates(1:10);
A = [.9995 0 0 0;
    .0005 .98 0 0;
    0 0 1 0;
    0 .02 0 1];

% Normalized COVID Cases and Deaths in St. Louis for first 68 weeks

% Single plot
figure;
plot(selected_dates_phase1, normalized_cases(1:68), '--r', 'LineWidth', 2);
hold on;
plot(selected_dates_phase1, normalized_deaths(1:68), '--k', 'LineWidth', 2);


% initial condition: 
x0 = [1; 0; 0; 0]; 

phase1 = 10; 

% Allocate
sys = ss(A, [], [], [], 1);
[Y, T, X] = lsim(sys, [], 0:phase1-1, x0);



% Use selected_dates for the x-axis
plot(selected_dates_phase1a, X(:,2), 'r', 'LineWidth', 2);
plot(selected_dates_phase1a, X(:,4), 'k', 'LineWidth', 2);





selected_dates_phase1a = dates(10:17);
A = [.9995 0 0 0;
    .0005 .998 0 0;
    0 0 1 0;
    0 .002 0 1];

% initial condition: 
x0 = [0.9955; 0.00414772; 0; 0.000357227]; 

phase1 = 8; 

% Allocate
sys = ss(A, [], [], [], 1);
[Y, T, X] = lsim(sys, [], 0:phase1-1, x0);

% Use selected_dates for the x-axis
plot(selected_dates_phase1a, X(:,2), 'r', 'LineWidth', 2);
plot(selected_dates_phase1a, X(:,4), 'k', 'LineWidth', 2);




selected_dates_phase1a = dates(17:35);
A = [.9985 0 0 0;
    .0015 .998 0 0;
    0 0 1 0;
    0 .002 0 1];

% initial condition: 
x0 = [0.992; 0.00754821; 0; 0.000435766]; 

phase1 = 19; 

% Allocate
sys = ss(A, [], [], [], 1);
[Y, T, X] = lsim(sys, [], 0:phase1-1, x0);

% Use selected_dates for the x-axis
plot(selected_dates_phase1a, X(:,2), 'r', 'LineWidth', 2);
plot(selected_dates_phase1a, X(:,4), 'k', 'LineWidth', 2);






selected_dates_phase1a = dates(35:40);
A = [.9945 0 0 0;
    .0055 .999 0 0;
    0 0 1 0;
    0 .001 0 1];

% initial condition: 
x0 = [0.966; 0.0332794; 0; 0.00114984]; 

phase1 = 6; 

% Allocate
sys = ss(A, [], [], [], 1);
[Y, T, X] = lsim(sys, [], 0:phase1-1, x0);

% Use selected_dates for the x-axis
plot(selected_dates_phase1a, X(:,2), 'r', 'LineWidth', 2);
plot(selected_dates_phase1a, X(:,4), 'k', 'LineWidth', 2);



selected_dates_phase1a = dates(40:46);
A = [.9965 0 0 0;
    .0035 .999 0 0;
    0 0 1 0;
    0 .001 0 1];

% initial condition: 
x0 = [0.9395; 0.0593349; 0; 0.00136869]; 

phase1 = 7; 

% Allocate
sys = ss(A, [], [], [], 1);
[Y, T, X] = lsim(sys, [], 0:phase1-1, x0);

% Use selected_dates for the x-axis
plot(selected_dates_phase1a, X(:,2), 'r', 'LineWidth', 2);
plot(selected_dates_phase1a, X(:,4), 'k', 'LineWidth', 2);


selected_dates_phase1a = dates(46:60);
A = [.9987 0 0 0;
    .0013 .9998 0 0;
    0 0 1 0;
    0 .0002 0 1];

% initial condition: 
x0 = [0.9197; 0.0784884; 0; 0.00177284]; 

phase1 = 15; 

% Allocate
sys = ss(A, [], [], [], 1);
[Y, T, X] = lsim(sys, [], 0:phase1-1, x0);

% Use selected_dates for the x-axis
plot(selected_dates_phase1a, X(:,2), 'r', 'LineWidth', 2);
plot(selected_dates_phase1a, X(:,4), 'k', 'LineWidth', 2);




selected_dates_phase1a = dates(60:68);
A = [.9995 0 0 0;
    .0005 .9998 0 0;
    0 0 1 0;
    0 .0002 0 1];

% initial condition: 
x0 = [0.903; 0.0948451; 0; 0.00199521]; 

phase1 = 9; 

% Allocate
sys = ss(A, [], [], [], 1);
[Y, T, X] = lsim(sys, [], 0:phase1-1, x0);

% Use selected_dates for the x-axis
plot(selected_dates_phase1a, X(:,2), 'r', 'LineWidth', 2);
plot(selected_dates_phase1a, X(:,4), 'k', 'LineWidth', 2);


% Plot
title('COVID Cases & Deaths in St. Louis Before Any Variant');
xlabel('Date');
ylabel('Rate for STL Population');
legend('Infection Rate', 'Death Rate', 'Modeled Infection Rate', 'Modeled Death Rate');
grid on;
datetick('x', 'mmm dd yy', 'keepticks');  
hold off;











%%%DELTA PHASE%%%%%
figure;

phase2 = 18; 

% Look at first 100 days
selected_dates_phase2 = dates(68:85);


A_phase2 = [.9993 0 0 0;
            .0007 .999984 0 0;
            0 0 1 0;
            0 .000016 0 1];


% Initial conditions for the second phase
x0_phase2 = [0.89926519; 0.0985651; 0; 0.00216971];


% Create the system for the second phase
sys_phase2 = ss(A_phase2, [], [], [], 1); 

% Simulate the system for the second phase
[Y, T, X] = lsim(sys_phase2, [], 0:phase2-1, x0_phase2);

% Plot normalized cases and deaths for the second phase

plot(selected_dates_phase2, X(:,4), 'k', 'LineWidth', 2);
hold on;
plot(selected_dates_phase2, normalized_cases(68:85), '--r', 'LineWidth', 2);
plot(selected_dates_phase2, normalized_deaths(68:85), '--k', 'LineWidth', 2);

%Making the tuned model exact
selected_dates_phase2a = dates(68:69);
phase2 = 2; 
x0_phase2 = [0.89926519; 0.0985651; 0; 0.00216971];
sys_phase2 = ss(A_phase2, [], [], [], 1); 
[Y, T, X] = lsim(sys_phase2, [], 0:phase2-1, x0_phase2);
plot(selected_dates_phase2a, X(:,2), 'r', 'LineWidth', 2);



%Tuning for model 2nd week
A_phase2 = [.999 0 0 0;
            .001 .999984 0 0;
            0 0 1 0;
            0 .000016 0 1];
selected_dates_phase2a = dates(69:70);
phase2 = 2; 
x0_phase2 = [0.89926519; 0.099193; 0; 0.00216971];
sys_phase2 = ss(A_phase2, [], [], [], 1); 
[Y, T, X] = lsim(sys_phase2, [], 0:phase2-1, x0_phase2);
plot(selected_dates_phase2a, X(:,2), 'r', 'LineWidth', 2);


%Tuning for linear weeks following 2nd week
A_phase2 = [.99782 0 0 0;
            .00218 .999984 0 0;
            0 0 1 0;
            0 .000016 0 1];
selected_dates_phase2a = dates(70:80);
phase2 = 11; 
x0_phase2 = [0.89926519; 0.100091; 0; 0.00216971];
sys_phase2 = ss(A_phase2, [], [], [], 1); 
[Y, T, X] = lsim(sys_phase2, [], 0:phase2-1, x0_phase2);
plot(selected_dates_phase2a, X(:,2), 'r', 'LineWidth', 2);


%Tuning for linear weeks following 2nd week
A_phase2 = [.9981 0 0 0;
            .0019 .999984 0 0;
            0 0 1 0;
            0 .000016 0 1];
selected_dates_phase2a = dates(80:81);
phase2 = 2; 
x0_phase2 = [0.89926519; 0.119486; 0; 0.00216971];
sys_phase2 = ss(A_phase2, [], [], [], 1); 
[Y, T, X] = lsim(sys_phase2, [], 0:phase2-1, x0_phase2);
plot(selected_dates_phase2a, X(:,2), 'r', 'LineWidth', 2);


%Tuning for linear weeks following 2nd week
A_phase2 = [.9989 0 0 0;
            .0011 .999984 0 0;
            0 0 1 0;
            0 .000016 0 1];
selected_dates_phase2a = dates(81:82);
phase2 = 2; 
x0_phase2 = [0.89926519; 0.121193; 0; 0.00216971];
sys_phase2 = ss(A_phase2, [], [], [], 1); 
[Y, T, X] = lsim(sys_phase2, [], 0:phase2-1, x0_phase2);
plot(selected_dates_phase2a, X(:,2), 'r', 'LineWidth', 2);




%Tuning for very last few linear weeks
A_phase2 = [.99882 0 0 0;
            .00118 .999984 0 0;
            0 0 1 0;
            0 .000016 0 1];
selected_dates_phase2a = dates(82:85);
phase2 = 4; 
x0_phase2 = [0.89926519; 0.12218; 0; 0.00216971];
sys_phase2 = ss(A_phase2, [], [], [], 1); 
[Y, T, X] = lsim(sys_phase2, [], 0:phase2-1, x0_phase2);
plot(selected_dates_phase2a, X(:,2), 'r', 'LineWidth', 2);


title('COVID Cases & Deaths in St. Louis During Delta Variant');
xlabel('Date');
ylabel('Rate for STL Population');
legend('Modeled Infection Rate', 'Modeled Death Rate', 'Infection Rate', 'Death Rate');
grid on;
datetick('x', 'mmm dd yy', 'keepticks');
hold off;
















%%OMICRON PHASE%%%%%

% IMPLEMENT 5 SEPARATE SLOPES FOR ONE MODEL
% 
% plot all the data in a new figure


figure;
phase3 = 4; 
selected_dates_phase3 = dates(85:106);
selected_dates_phase3a = dates(85:88);
x0_phase3 = [0.874624; 0.125376; 0; 0.00244247]; 

A_phase3_slope1 = [.99882 0 0 0;
            .00118 .999984 0 0;
            0 0 1 0;
            0 .000016 0 1];


sys_slope1 = ss(A_phase3_slope1, [], [], [], 1); 
[Y1, T1, X1] = lsim(sys_slope1, [], 0:phase3-1, x0_phase3);


plot(selected_dates_phase3a, X1(:,2), 'r', 'LineWidth', 2);
hold on;
plot(selected_dates_phase3a, X1(:,4), 'k', 'LineWidth', 2);


plot(selected_dates_phase3, normalized_cases(85:106), '--r', 'LineWidth', 2);
plot(selected_dates_phase3, normalized_deaths(85:106), '--k', 'LineWidth', 2);


phase3 = 5; 
selected_dates_phase3a = dates(88:92);
x0_phase3 = [0.874624; 0.128733; 0; 0.00244247]; 

A_phase3_slope1 = [.998 0 0 0;
            .002 .999984 0 0;
            0 0 1 0;
            0 .000016 0 1];


sys_slope1 = ss(A_phase3_slope1, [], [], [], 1); 
[Y1, T1, X1] = lsim(sys_slope1, [], 0:phase3-1, x0_phase3);


plot(selected_dates_phase3a, X1(:,2), 'r', 'LineWidth', 2);
plot(selected_dates_phase3a, X1(:,4), 'k', 'LineWidth', 2);




phase3 = 3; 
selected_dates_phase3a = dates(92:94);
x0_phase3 = [0.874624; 0.135701; 0; 0.00244247]; 

A_phase3_slope1 = [.993 0 0 0;
            .007 .999984 0 0;
            0 0 1 0;
            0 .000016 0 1];


sys_slope1 = ss(A_phase3_slope1, [], [], [], 1); 
[Y1, T1, X1] = lsim(sys_slope1, [], 0:phase3-1, x0_phase3);


plot(selected_dates_phase3a, X1(:,2), 'r', 'LineWidth', 2);
plot(selected_dates_phase3a, X1(:,4), 'k', 'LineWidth', 2);


phase3 = 5; 
selected_dates_phase3a = dates(94:98);
x0_phase3 = [0.874624; 0.147898; 0; 0.00244247]; 

A_phase3_slope1 = [.983 0 0 0;
            .017 .999984 0 0;
            0 0 1 0;
            0 .000016 0 1];


sys_slope1 = ss(A_phase3_slope1, [], [], [], 1); 
[Y1, T1, X1] = lsim(sys_slope1, [], 0:phase3-1, x0_phase3);


plot(selected_dates_phase3a, X1(:,2), 'r', 'LineWidth', 2);
plot(selected_dates_phase3a, X1(:,4), 'k', 'LineWidth', 2);



phase3 = 9; 
selected_dates_phase3a = dates(98:106);
x0_phase3 = [0.874624; 0.205862; 0; 0.00244247]; 

A_phase3_slope1 = [.999 0 0 0;
            .001 .999984 0 0;
            0 0 1 0;
            0 .000016 0 1];


sys_slope1 = ss(A_phase3_slope1, [], [], [], 1); 
[Y1, T1, X1] = lsim(sys_slope1, [], 0:phase3-1, x0_phase3);


plot(selected_dates_phase3a, X1(:,2), 'r', 'LineWidth', 2);
plot(selected_dates_phase3a, X1(:,4), 'k', 'LineWidth', 2);
title('COVID Cases & Deaths in St. Louis During Omicron Variant');
xlabel('Date');
ylabel('Rate for STL Population');
legend('Modeled Infection Rate', 'Modeled Death Rate', 'Infection Rate', 'Death Rate');
grid on;
datetick('x', 'mmm dd yy', 'keepticks');
hold off;








%%%AFTER OMICRON PHASE%%%%%%
figure;
phase4 = 7; 
selected_dates_phase4 = dates(106:158);

selected_dates_phase4a = dates(106:112);
x0_phase4 = [0.874624; 0.213465; 0; 0.00244247]; 

A_phase4_slope1 = [.9991 0 0 0;
            .0008 .999984 0 0;
            0 0 1 0;
            0 .000016 0 1];


sys_slope1 = ss(A_phase4_slope1, [], [], [], 1); 
[Y1, T1, X1] = lsim(sys_slope1, [], 0:phase4-1, x0_phase4);


plot(selected_dates_phase4a, X1(:,2), 'r', 'LineWidth', 2);
hold on;
plot(selected_dates_phase4a, X1(:,4), 'k', 'LineWidth', 2);


plot(selected_dates_phase4, normalized_cases(106:158), '--r', 'LineWidth', 2);
plot(selected_dates_phase4, normalized_deaths(106:158), '--k', 'LineWidth', 2);




phase4 = 16; 
selected_dates_phase4a = dates(112:127);
x0_phase4 = [0.874624; 0.217708; 0; 0.00244247]; 

A_phase4_slope1 = [.997 0 0 0;
            .003 .999984 0 0;
            0 0 1 0;
            0 .000016 0 1];


sys_slope1 = ss(A_phase4_slope1, [], [], [], 1); 
[Y1, T1, X1] = lsim(sys_slope1, [], 0:phase4-1, x0_phase4);


plot(selected_dates_phase4a, X1(:,2), 'r', 'LineWidth', 2);
hold on;
plot(selected_dates_phase4a, X1(:,4), 'k', 'LineWidth', 2);






phase4 = 13; 
selected_dates_phase4a = dates(127:139);
x0_phase4 = [0.874624; 0.256194; 0; 0.00244247]; 

A_phase4_slope1 = [.9985 0 0 0;
            .0015 .999984 0 0;
            0 0 1 0;
            0 .000016 0 1];


sys_slope1 = ss(A_phase4_slope1, [], [], [], 1); 
[Y1, T1, X1] = lsim(sys_slope1, [], 0:phase4-1, x0_phase4);


plot(selected_dates_phase4a, X1(:,2), 'r', 'LineWidth', 2);
hold on;
plot(selected_dates_phase4a, X1(:,4), 'k', 'LineWidth', 2);






phase4 = 20; 
selected_dates_phase4a = dates(139:158);
x0_phase4 = [0.874624; 0.271757; 0; 0.00244247]; 

A_phase4_slope1 = [.999 0 0 0;
            .001 .999984 0 0;
            0 0 1 0;
            0 .000016 0 1];


sys_slope1 = ss(A_phase4_slope1, [], [], [], 1); 
[Y1, T1, X1] = lsim(sys_slope1, [], 0:phase4-1, x0_phase4);


plot(selected_dates_phase4a, X1(:,2), 'r', 'LineWidth', 2);
hold on;
plot(selected_dates_phase4a, X1(:,4), 'k', 'LineWidth', 2);


title('COVID Cases & Deaths in St. Louis After Omicron Variant');
xlabel('Date');
ylabel('Rate for STL Population');
legend('Modeled Infection Rate', 'Modeled Death Rate', 'Infection Rate', 'Death Rate');
grid on;
datetick('x', 'mmm dd yy', 'keepticks');
hold off;






%%WHAT IF SCENARIO (25% CASE REDUCTION IN CASES & DEATHS DURING OMICRON
%%WAVE)

figure;
selected_dates_phase5 = dates(85:106);
phase5 = 22;
plot(selected_dates_phase5, normalized_cases(85:106), '--r', 'LineWidth', 2);
hold on;
plot(selected_dates_phase5, normalized_deaths(85:106), '--k', 'LineWidth', 2);



%REAL DATA FOR END OF OMICRON HAS 0.21 (POPULATION FRACTION/NORMALIZED VALUE)
%INFECTED AND 0.0031(POPULATION FRACTION/NORMALIZED VALUE) DEAD. WE MUST
%REDUCE BOTH BY 25% (SO MULTIPLY THESE VALUES BY .75) AND THAT IS WHERE END
%VALUES WILL BE.

EndVal_of_Infected = 0.213465;
EndVal_of_Dead = 0.00313678;

%REDUCE 25%;

WhatIf_Infected = 0.75 * EndVal_of_Infected;
WhatIf_Dead = 0.75 * EndVal_of_Dead;


format = 'What if Value for Infected (where the tuned model will end) is %8.3f \n';
fprintf(format,WhatIf_Infected);


format = 'What if Value for Dead (where the tuned model will end) is %8.3f \n';
fprintf(format,WhatIf_Dead);


x0_phase5 = [0.874624; 0.125376; 0; 0.00244247]; 

A_phase5_slope1 = [.99815 0 0 0;
            .00195 .99999999 0 0;
            0 0 1 0;
            0 .00000001 0 1];


sys_slope1 = ss(A_phase5_slope1, [], [], [], 1); 
[Y1, T1, X1] = lsim(sys_slope1, [], 0:phase5-1, x0_phase5);
plot(selected_dates_phase5, X1(:,2), 'r', 'LineWidth', 2);
plot(selected_dates_phase5, X1(:,4), 'k', 'LineWidth', 2);



title('COVID Cases & Deaths in St. Louis What If Scenario');
xlabel('Date');
ylabel('Rate for STL Population');
legend('Actual Data for Case Rate', 'Actual Data for Death Rate', '"What If" Infected" Rate', '"What If" Deceased Rate');
grid on;
datetick('x', 'mmm dd yy', 'keepticks');
hold off;
