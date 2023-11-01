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
% plot all the data in a new figure
figure;

phase3 = 74; 

% Look at phase 3
selected_dates_phase3 = dates(85:158);


% Define a new A matrix for the third phase (adjust values as needed)
A_phase3 = [.9997 .05 .3 0;
            .00045 .75 0 0;
            0 .1999 .7 0;
            0 .0001 0 1];

% Initial conditions for the third phase
x0_phase3 = [1; 0; 0; 0];

% Create the system for the third phase
sys_phase3 = ss(A_phase3, [], [], [], 1); % Ts = 1

% Simulate the system for the third phase
[Y, T, X] = lsim(sys_phase3, [], 0:phase3-1, x0_phase3);

% Plot normalized cases and deaths for the third phase
plot(selected_dates_phase3, cumsum(X(:,2)), 'r', 'LineWidth', 2);
hold on;
plot(selected_dates_phase3, cumsum(X(:,4)), 'k', 'LineWidth', 2);
plot(selected_dates_phase3, normalized_cases(85:158), '--r', 'LineWidth', 2);
plot(selected_dates_phase3, normalized_deaths(85:158), '--k', 'LineWidth', 2);

title('COVID Cases & Deaths in St. Louis Third Phase');
xlabel('Date');
ylabel('Population Fraction/Normalized Value');
legend('Infected', 'Deceased', 'Normalized Cases', 'Normalized Deaths');
grid on;
datetick('x', 'mmm dd yy', 'keepticks');
hold off;