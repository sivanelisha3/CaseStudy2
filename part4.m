clear;
close all;

% Load mock data
load('mockdata2023 (1).mat');

% Number of Days being examined
days = 1:400; 

% Day the pattern changes: vaccine break
phase_change_day = 122; 

% Day the pattern stabilizes
stabilization_day = 244;

% Find the cumulative number of infections
cumulative_infections = cumsum(newInfections);

% SIRDV Model: 5x5 matrix - placeholders for vaccine parameters
x_t = [0.75 0.10 0.10 0.05 0.01]; 

% Vaccinated and Vaccine-Break values. 
vaccinated = 0.01; 
vaccine_break = 0.001; 

% Adjusted A matrix to include vaccinated and vaccine_break
A_phase1 = [.98889       0        .3   0       0;
            .0011      .8         0   0  vaccine_break;
            0           .1999     .7   0       0;
            .00001      .0001      0   1       0;
            vaccinated    0        0   0 1-vaccine_break];

A_phase2 = [.9          0.04      .3       0       0;
            .06         .7         0       0  vaccine_break;
            0            .1       .7       0       0;
            0           .00001     0       1       0;
            vaccinated    0        0       0 1-vaccine_break];

% Phase 3 where infections and deaths level out
A_phase3 = eye(5);

% initial condition: 
x0 = [1; 0; 0; 0; 0]; 

% Make System for Phase 1
sys_phase1 = ss(A_phase1, [], [], [], 1); % Ts = 1

% Simulate Phase 1
[Y1, T1, X1] = lsim(sys_phase1, [], days(1:phase_change_day), x0);

% Last state of phase 1 is initial condition for phase 2
x0_phase2 = X1(end, :);

% Make System for Phase 2
sys_phase2 = ss(A_phase2, [], [], [], 1);

% Simulate Phase 2
[Y2, T2, X2] = lsim(sys_phase2, [], days(phase_change_day+1:end), x0_phase2);


% Combine Phase 1 and Phase 2
X_combined = [X1; X2];

% Plot Simulations
figure;
plot(days, cumulativeDeaths, 'r', 'LineWidth', 1);
hold on;
plot(days, cumulative_infections, 'b', 'LineWidth', 1);
plot(days, cumsum(X_combined(:,2)), 'g--', 'LineWidth', 1); % Infected
plot(days, cumsum(X_combined(:,4)), 'k--', 'LineWidth', 1); % Deceased
hold off;

xlabel('Days');
ylabel('Cumulative Counts');
title('Cumulative Deaths and Infections Over Time');
legend('Cumulative Deaths from mock data', 'Cumulative Infections from mock data', 'Model Infected', 'Model Deceased', 'Location', 'northwest');
grid on;
