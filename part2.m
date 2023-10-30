clear;
close all;

%%%%%%%%% Part 1 Data Fit %%%%%%%%%
x_t = [0.75 0.10 0.10 0.05];

A = [.95 .04 .3 0;
    .05 .85 0 0;
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

% Use the original case and death data
cases = cases_STL(1:100);
deaths = deaths_STL(1:100);

% calculate recovered and susceptible based on the raw data
susceptible = POP_STL - cumsum(cases) - cumsum(deaths);
recovered = cumsum(cases) - cumsum(deaths);

% Single plot
figure;

% Epidemic Dynamics Over Time
plot(selected_dates, cumsum(X(:,1)) * POP_STL, 'b', 'LineWidth', 2); hold on; % convert fraction to counts
plot(selected_dates, cumsum(X(:,2)) * POP_STL, 'r', 'LineWidth', 2);
plot(selected_dates, cumsum(X(:,3)) * POP_STL, 'g', 'LineWidth', 2);
plot(selected_dates, cumsum(X(:,4)) * POP_STL, 'k', 'LineWidth', 2);

% COVID Cases and Deaths in St. Louis for first 100 days
plot(selected_dates, cumsum(cases), '--r', 'LineWidth', 2); 
plot(selected_dates, cumsum(deaths), '--k', 'LineWidth', 2);

% recovered and susceptible
plot(selected_dates, susceptible, '--b', 'LineWidth', 2);
plot(selected_dates, recovered, '--g', 'LineWidth', 2);

% Plot
title('Comparison: Epidemic Dynamics and COVID Cases/Deaths in St. Louis (First 100 days)');
xlabel('Date');
ylabel('Cumulative Count');
legend('Susceptible', 'Infected', 'Recovered', 'Deceased', 'Cases', 'Deaths', 'Susceptible Dotted', 'Recovered Dotted');
grid on;
hold off;
