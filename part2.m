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

num_days = 100; 

% Allocate
sys = ss(A, [], [], [], 1); % Ts = 1
[Y, T, X] = lsim(sys, [], 0:num_days-1, x0);

% Step 1: Load the data from the 'COVID_STL.mat' file
load('COVID_STL.mat');

% Look at first 100 days
selected_dates = dates(1:100);

% Step 2: Normalize cases and deaths by population
normalized_cases = cases_STL / POP_STL;
normalized_deaths = deaths_STL / POP_STL;

% % calculate recovered and susceptible based on the given data
susceptible_dotted = 1 - normalized_cases(1:100) - normalized_deaths(1:100); % Population fraction - normalize_cases - normalize_deaths
recovered_dotted = normalized_cases(1:100) - normalized_deaths(1:100); % normalized_cases - normalized_deaths

% Single plot
figure;

% Use selected_dates for the x-axis
plot(selected_dates, cumsum(X(:,2)), 'r', 'LineWidth', 2);
hold on;
%plot(selected_dates, cumsum(X(:,3)), 'g', 'LineWidth', 2);
plot(selected_dates, cumsum(X(:,4)), 'k', 'LineWidth', 2);

% Normalized COVID Cases and Deaths in St. Louis for first 100 days
plot(selected_dates, normalized_cases(1:100), '--r', 'LineWidth', 2); 
plot(selected_dates, normalized_deaths(1:100), '--k', 'LineWidth', 2);

% recovered and susceptible
%plot(selected_dates, recovered_dotted, '--g', 'LineWidth', 2);

% Plot
title('Comparison: Epidemic Dynamics and COVID Cases/Deaths in St. Louis (First 100 days)');
xlabel('Date');
ylabel('Population Fraction/Normalized Value');
legend('Infected', 'Deceased', 'Normalized Cases', 'Normalized Deaths');
grid on;
datetick('x', 'mmm dd', 'keepticks');  % This will format x-axis with month and day
hold off;

% plot all the data in a new figure
figure;

% use 'dates' for the x-axis based on the entire dataset
plot(dates, normalized_cases, '--r', 'LineWidth', 2); 
hold on;
plot(dates, normalized_deaths, '--k', 'LineWidth', 2);


% plot
title('COVID Cases, Deaths, Susceptible, and Recovered in St. Louis (All Days)');
xlabel('Date');
ylabel('Population Fraction/Normalized Value');
legend('Normalized Cases', 'Normalized Deaths', 'Susceptible', 'Recovered');
grid on;
datetick('x', 'mmm dd', 'keepticks');  % format x-axis with month and day
hold off;
