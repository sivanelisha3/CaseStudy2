clear;
close all;

%%%%%%%%% Part 1 Data Fit %%%%%%%%%
x_t = [0.75 0.10 0.10 0.05];

A = [.9997 .05 .3 0;
    .00045 .75 0 0;
    0 .1999 .7 0;
    0 .0001 0 1];

% initial condition: 
x0 = [1; 0; 0; 0]; 

phase1 = 68; 

% Allocate
sys = ss(A, [], [], [], 1); % Ts = 1
[Y, T, X] = lsim(sys, [], 0:phase1-1, x0);

% Step 1: Load the data from the 'COVID_STL.mat' file
load('COVID_STL.mat');

% normalizing cases and deaths by population
normalized_cases = cases_STL / POP_STL;
normalized_deaths = deaths_STL / POP_STL;

% % calculate recovered and susceptible based on the given data
susceptible_dotted = 1 - normalized_cases(1:68) - normalized_deaths(1:68); % Population fraction - normalize_cases - normalize_deaths
recovered_dotted = normalized_cases(1:68) - normalized_deaths(1:68); % normalized_cases - normalized_deaths





%%%DATA FROM DAYS BEFORE FIRST PHASE%%%%%
selected_dates_phase1 = dates(1:68);

% Single plot
figure;

% Use selected_dates for the x-axis
plot(selected_dates_phase1, cumsum(X(:,2)), 'r', 'LineWidth', 2);
hold on;
%plot(selected_dates, cumsum(X(:,3)), 'g', 'LineWidth', 2);
plot(selected_dates_phase1, cumsum(X(:,4)), 'k', 'LineWidth', 2);


% Normalized COVID Cases and Deaths in St. Louis for first 68 weeks
plot(selected_dates_phase1, normalized_cases(1:68), '--r', 'LineWidth', 2); 
plot(selected_dates_phase1, normalized_deaths(1:68), '--k', 'LineWidth', 2);


% Plot
title('COVID Cases & Deaths in St. Louis Before First Phase');
xlabel('Date');
ylabel('Population Fraction/Normalized Value');
legend('Infected', 'Deceased', 'Normalized Cases', 'Normalized Deaths');
grid on;
datetick('x', 'mmm dd yy', 'keepticks');  
hold off;








%%%FIRST PHASE%%%%%
figure;

phase2 = 18; 

% Look at first 100 days
selected_dates_phase2 = dates(68:85);

A_phase2 = [.9997 .05 .3 0;
            .00045 .75 0 0;
            0 .1999 .7 0;
            0 .0001 0 1];

% Initial conditions for the second phase
x0_phase2 = [0.8; 0.1; 0.05; 0.05];

% Create the system for the second phase
sys_phase2 = ss(A_phase2, [], [], [], 1); % Ts = 1

% Simulate the system for the second phase
[Y, T, X] = lsim(sys_phase2, [], 0:phase2-1, x0_phase2);

% Plot normalized cases and deaths for the second phase
plot(selected_dates_phase2, cumsum(X(:,2)), 'r', 'LineWidth', 2);
hold on;
plot(selected_dates_phase2, cumsum(X(:,4)), 'k', 'LineWidth', 2);
plot(selected_dates_phase2, normalized_cases(68:85), '--r', 'LineWidth', 2);
plot(selected_dates_phase2, normalized_deaths(68:85), '--k', 'LineWidth', 2);

title('COVID Cases & Deaths in St. Louis Second Phase');
xlabel('Date');
ylabel('Population Fraction/Normalized Value');
legend('Infected', 'Deceased', 'Normalized Cases', 'Normalized Deaths');
grid on;
datetick('x', 'mmm dd yy', 'keepticks');
hold off;



%%%SECOND PHASE%%%%%

% IMPLEMENT 5 SEPARATE SLOPES FOR ONE MODEL

% plot all the data in a new figure
figure;

phase3 = 74; 

selected_dates_phase3 = dates(85:158);

x0_slope1_phase3 = [0.874624; 0.125376; 0; 0]; 
% 
% x0_slope2_phase3 = [0.86263; 0.13737; 0; 0];
% 
% x0_slope3_phase3 = [0.819666; 0.180334; 0; 0];

% define the A matrices for each of the 4 slopes
A_phase3_slope1 = [.99851    0  .3 0;
                   .00159 .001   0 0;
                    0     .9989 .7 0;
                    0     .0001  0 1];
A_phase3_slope2 = [.99851    0  .3  0;
                   .00159 .9998 .4  0;
                    0     .0001 .3  0;
                    0     .0001  0  1]; 
A_phase3_slope3 = [.999955  .4  .4  0;
                   .000045 .5   0  0;
                    0    .1999    .6  0;
                    0    .0001     0  1];
A_phase3_slope4 = [.99955  0   .4 0;
                   .00045 .9    .3 0;
                    0    .1999  .3 0;
                    0    .0001   0 1]; 
A_phase3_slope5 = [.9998    0  .02   0;
                   .0012 .0001   0  0;
                    0     .9998 .98   0;
                    0     .0001  0   1];

% define the time intervals for each slope
t_phase3_slope1 = 85:92; 
t_phase3_slope2 = 92:95;
t_phase3_slope3 = 95:107;
t_phase3_slope4 = 107:118;
t_phase3_slope5 = 118:158;

% create the system for each slope
sys_slope1 = ss(A_phase3_slope1, [], [], [], 1); 
sys_slope2 = ss(A_phase3_slope2, [], [], [], 1);
sys_slope3 = ss(A_phase3_slope3, [], [], [], 1);
sys_slope4 = ss(A_phase3_slope4, [], [], [], 1);
sys_slope5 = ss(A_phase3_slope5, [], [], [], 1);

% simulate the system for each slope
[Y1, T1, X1] = lsim(sys_slope1, [], t_phase3_slope1, x0_slope1_phase3);
[Y2, T2, X2] = lsim(sys_slope2, [], t_phase3_slope2, X1(end,:));
[Y3, T3, X3] = lsim(sys_slope3, [], t_phase3_slope3, X2(end,:));
[Y4, T4, X4] = lsim(sys_slope4, [], t_phase3_slope4, X3(end,:));
[Y5, T5, X5] = lsim(sys_slope5, [], t_phase3_slope5, X4(end,:));

% combine results
X5 = X5(1:end-4, :);
X_combined = [X1; X2; X3; X4; X5];
selected_dates_phase3_combined = [selected_dates_phase3(1:length(t_phase3_slope1)), selected_dates_phase3(length(t_phase3_slope1)+1:length(t_phase3_slope1)+length(t_phase3_slope2)), selected_dates_phase3(length(t_phase3_slope1)+length(t_phase3_slope2)+1:length(t_phase3_slope1)+length(t_phase3_slope2)+length(t_phase3_slope3)), selected_dates_phase3(length(t_phase3_slope1)+length(t_phase3_slope2)+length(t_phase3_slope3)+1:length(t_phase3_slope1)+length(t_phase3_slope2)+length(t_phase3_slope3)+length(t_phase3_slope4)), selected_dates_phase3(length(t_phase3_slope1)+length(t_phase3_slope2)+length(t_phase3_slope3)+length(t_phase3_slope4)+1:end)];
% plot combined results
plot(selected_dates_phase3_combined, cumsum(X_combined(:,2)), 'r', 'LineWidth', 2);
hold on;
plot(selected_dates_phase3_combined, cumsum(X_combined(:,4)), 'k', 'LineWidth', 2);
plot(selected_dates_phase3, normalized_cases(85:158), '--r', 'LineWidth', 2);
plot(selected_dates_phase3, normalized_deaths(85:158), '--k', 'LineWidth', 2);

title('COVID Cases & Deaths in St. Louis Third Phase');
xlabel('Date');
ylabel('Population Fraction/Normalized Value');
legend('Infected', 'Deceased', 'Normalized Cases', 'Normalized Deaths');
grid on;
datetick('x', 'mmm dd yy', 'keepticks');
hold off;
