
clear;
close all;

% INITIALIZING POPULATIONS
POPULATION_1 = 10000000;
POPULATION_2 = 5000000;




% LOADING DATA FROM 'COVID_STL.mat' FILE IN ORDER TO USE GIVEN DATES VECTOR
load('COVID_STL.mat');

% PLOT OVER THE SPAN OF COVID-19
selected_dates = dates(1:158);
phase1 = 158;

% MAKING ASSUMPTIONS ABOUT RATES FOR POPULATION 1

% EVERYONE STARTS OUT AS SUSCEPTIBLE
x_POP1 = [1 0 0 0];

% Define the rate of travel from population 1 to population 2 (e.g., 0.01%)
travel_rate = 0.001;

% Define the modified transition matrix for population 1
A_POP1= [0.95*(1-travel_rate) 0 0 0;
         .05 .7*(1-travel_rate) 0 0;
          0 .2 1*(1-travel_rate) 0;
          0 .1 0 1*(1-travel_rate)];

% Allocate
sys = ss(A_POP1, [], [], [], 1);
[Y, T, X] = lsim(sys, [], 0:phase1-1, x_POP1);

% Single plot
figure;

% Use selected_dates for the x-axis
plot(selected_dates, X(:,1), 'b', 'LineWidth', 2);
hold on;
plot(selected_dates, X(:,2), 'r', 'LineWidth', 2);
plot(selected_dates, X(:,3), 'g', 'LineWidth', 2);
plot(selected_dates, X(:,4), 'k', 'LineWidth', 2);

% PLOT
title('COVID Cases & Deaths in Population 1');
xlabel('Date');
ylabel('Population');
legend('Susceptible', 'Infected', 'Recovered', 'Deceased');
grid on;
datetick('x', 'mmm dd yy', 'keepticks');
hold off;

















% MAKING ASSUMPTIONS ABOUT RATES FOR POPULATION 2

% EVERYONE STARTS OUT AS SUSCEPTIBLE
x_POP2 = [1 0 0 0];

% Define the modified transition matrix for population 2
A_POP2= [.97*(1+travel_rate) 0 0 0;
         .03 .7*(1+travel_rate) 0 0;
          0 .25 1*(1+travel_rate) 0;
          0 .05 0 1*(1+travel_rate)];

% Allocate
sys = ss(A_POP2, [], [], [], 1);
[Y, T, X] = lsim(sys, [], 0:phase1-1, x_POP2);

% Single plot
figure;

% Use selected_dates for the x-axis
plot(selected_dates, X(:,1), 'b', 'LineWidth', 2);
hold on;
plot(selected_dates, X(:,2), 'r', 'LineWidth', 2);
plot(selected_dates, X(:,3), 'g', 'LineWidth', 2);
plot(selected_dates, X(:,4), 'k', 'LineWidth', 2);

% PLOT
title('COVID Cases & Deaths in Population 2');
xlabel('Date');
ylabel('Population');
legend('Susceptible', 'Infected', 'Recovered', 'Deceased');
grid on;
datetick('x', 'mmm dd yy', 'keepticks');
hold off;





%%%WHAT IF TRAVEL RESTRICTIONS WERE IMPLEMENTED DURING DELTA VARIANT%%%%%%

selected_dates = dates(68:85);
phase1 = 18;

% EVERYONE STARTS OUT AS SUSCEPTIBLE
x_POP1 = [1 0 0 0];

% LOW TRAVEL RESTRICTIONS DURING FIRST DELTA VARIANT
travel_rate = 0.01;

% Define the modified transition matrix for population 1
A_POP1= [0.95*(1-travel_rate) 0 0 0;
         .05 .65*(1-travel_rate) 0 0;
          0 .335 1*(1-travel_rate) 0;
          0 .015 0 1*(1-travel_rate)];

% Allocate
sys = ss(A_POP1, [], [], [], 1);
[Y, T, X] = lsim(sys, [], 0:phase1-1, x_POP1);

% Single plot
figure;

% Use selected_dates for the x-axis
plot(selected_dates, X(:,1), 'b', 'LineWidth', 2);
hold on;
plot(selected_dates, X(:,2), 'r', 'LineWidth', 2);
plot(selected_dates, X(:,3), 'g', 'LineWidth', 2);
plot(selected_dates, X(:,4), 'k', 'LineWidth', 2);

% PLOT
title('COVID Data during Delta Variant in  Region with low Travel Restrictions');
xlabel('Date');
ylabel('Population');
legend('Susceptible', 'Infected', 'Recovered', 'Deceased');
grid on;
datetick('x', 'mmm dd yy', 'keepticks');
hold off;




%%%WHAT IF TRAVEL RESTRICTIONS WERE IMPLEMENTED DURING OMICRON VARIANT%%%%%%

selected_dates = dates(85:106);
phase1 = 22;

% EVERYONE STARTS OUT AS SUSCEPTIBLE
x_POP1 = [1 0 0 0];

% HIGH TRAVEL RESTRICTIONS DURING OMICRON VARIANT
travel_rate = 0.0001;

% Define the modified transition matrix for population 1
A_POP1= [0.98*(1-travel_rate) 0 0 0;
         .02 .7*(1-travel_rate) 0 0;
          0 .29 1*(1-travel_rate) 0;
          0 .01 0 1*(1-travel_rate)];

% Allocate
sys = ss(A_POP1, [], [], [], 1);
[Y, T, X] = lsim(sys, [], 0:phase1-1, x_POP1);

% Single plot
figure;

% Use selected_dates for the x-axis
plot(selected_dates, X(:,1), 'b', 'LineWidth', 2);
hold on;
plot(selected_dates, X(:,2), 'r', 'LineWidth', 2);
plot(selected_dates, X(:,3), 'g', 'LineWidth', 2);
plot(selected_dates, X(:,4), 'k', 'LineWidth', 2);

% PLOT
title('COVID Data during Omicron Variant in  Region with High Travel Restrictions');
xlabel('Date');
ylabel('Population');
legend('Susceptible', 'Infected', 'Recovered', 'Deceased');
grid on;
datetick('x', 'mmm dd yy', 'keepticks');
hold off;





