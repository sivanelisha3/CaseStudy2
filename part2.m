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

phase2 = 17; 

sys = ss(A, [], [], [], 1); % Ts = 1
[Y, T, X] = lsim(sys, [], 0:phase2-1, x0);

% Look at first 100 days
selected_dates_phase2 = dates(68:85);


% use 'dates' for the x-axis based on the entire dataset
plot(selected_dates_phase2, normalized_cases(68:85), '--r', 'LineWidth', 2); 
hold on;
plot(selected_dates_phase2, normalized_deaths(68:85), '--k', 'LineWidth', 2);

%INSERT THE INFECTED AND DECEASED TUNED MODEL FOR PHASE 1



% plot
title('COVID Cases & Deaths in St. Louis First Phase');
xlabel('Date');
ylabel('Population Fraction/Normalized Value');
legend('Normalized Cases', 'Normalized Deaths'); %EDIT THIS TO INCLUDE THE TWO LINES FOR TUNED MODEL
grid on;
datetick('x', 'mmm dd yy', 'keepticks'); 
hold off;







% plot all the data in a new figure
figure;

phase3 = 73; 

sys = ss(A, [], [], [], 1); % Ts = 1
[Y, T, X] = lsim(sys, [], 0:phase3-1, x0);

% Look at phase 3
selected_dates_phase3 = dates(85:158);


% use 'dates' for the x-axis based on the entire dataset
plot(selected_dates_phase3, normalized_cases(85:158), '--r', 'LineWidth', 2); 
hold on;
plot(selected_dates_phase3, normalized_deaths(85:158), '--k', 'LineWidth', 2);


%INSERT THE INFECTED AND DECEASED TUNED MODEL FOR PHASE 2



% plot
title('COVID Cases & Deaths in St. Louis Second Phase');
xlabel('Date');
ylabel('Population Fraction/Normalized Value');
legend('Normalized Cases', 'Normalized Deaths'); %EDIT THIS TO INCLUDE THE TWO LINES FOR TUNED MODEL
grid on;
datetick('x', 'mmm dd yy', 'keepticks'); 
hold off;
