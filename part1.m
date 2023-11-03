clear;
close all;

% System matrix
A = [.95 .04 .3 0;
     .05 .85 0 0;
     0 .1 .7 0;
     0 .01 0 1];

% No input -- B is a zero matrix
B = zeros(4,1); 

% C is an identity matrix
C = eye(4); 

% D is zero
D = zeros(4,1);

% Sample time is 1 day
sample_time = 1;

% Create state-space object
sys = ss(A, B, C, D, sample_time);

% Initial condition: 
x0 = [1; 0; 0; 0]; 

% Time vector
num_days = 100; 
t = 0:num_days-1; 

u = zeros(num_days, 1);

% Simulate the system
[Y, T, X] = lsim(sys, u, t, x0);

% Plot
figure;
plot(T, X(:,1), 'b', 'LineWidth', 2); hold on;
plot(T, X(:,2), 'r', 'LineWidth', 2);
plot(T, X(:,3), 'g', 'LineWidth', 2);
plot(T, X(:,4), 'k', 'LineWidth', 2);
legend('Susceptible', 'Infected', 'Recovered', 'Deceased');
xlabel('Days');
ylabel('Population Fraction');
title('Epidemic Dynamics Over Time');
grid on;
