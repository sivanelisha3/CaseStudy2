clear;
close all;

x_t = [0.75 0.10 0.10 0.05];

A = [.95 .04 .3 0;
    .05 .85 0 0;
    0 .1 .7 0;
    0 .01 0 1];

% initial condition: 
x0 = [1; 0; 0; 0]; 

num_days = 100; 

X = zeros(4, num_days);
X(:,1) = x0;

% Directly calculate using matrix power
for t = 2:num_days
    At = A^t;
    X(:,t) = At * x0;
end

% plot
figure;
plot(1:num_days, X(1,:), 'b', 'LineWidth', 2); hold on;
plot(1:num_days, X(2,:), 'r', 'LineWidth', 2);
plot(1:num_days, X(3,:), 'g', 'LineWidth', 2);
plot(1:num_days, X(4,:), 'k', 'LineWidth', 2);
legend('Susceptible', 'Infected', 'Recovered', 'Deceased');
xlabel('Days');
ylabel('Population Fraction');
title('Epidemic Dynamics Over Time');
grid on;
