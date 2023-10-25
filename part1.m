clear;
close all;

% parameters
beta = 0.3;  % transmission rate
gamma = 0.1;  % recovery rate
mu = 0.01;  % mortality rate
sigma = 0.02;  % rate of recovered individuals becoming susceptible again
n = 1000;  % total population
i0 = 10;  % initial infected individuals
s0 = n - i0;  % initial susceptible individuals
r0 = 0;  % initial recovered individuals
d0 = 0;  % initial deceased individuals

% time settings
tmax = 200;  % max time
dt = 1;  % time step
t = 0:dt:tmax;

% initialize vectors
s = zeros(1, length(t));
i = zeros(1, length(t));
r = zeros(1, length(t));
d = zeros(1, length(t));

s(1) = s0;
i(1) = i0;
r(1) = r0;
d(1) = d0;

% implement the modified sird model with reinfections
for j = 2:length(t)
    ds = (-beta * s(j-1) * i(j-1) / n + sigma * r(j-1)) * dt;
    di = (beta * s(j-1) * i(j-1) / n - gamma * i(j-1) - mu * i(j-1)) * dt;
    dr = (gamma * i(j-1) - sigma * r(j-1)) * dt;
    dd = mu * i(j-1) * dt;

    s(j) = s(j-1) + ds;
    i(j) = i(j-1) + di;
    r(j) = r(j-1) + dr;
    d(j) = d(j-1) + dd;
end

% plot the results
figure;
plot(t, s, '-g', 'LineWidth', 2);
hold on;
plot(t, i, '-r', 'LineWidth', 2);
plot(t, r, '-b', 'LineWidth', 2);
plot(t, d, '-k', 'LineWidth', 2);
xlabel('time (days)');
ylabel('population');
legend('susceptible', 'infected', 'recovered', 'deceased');
title('sird model with reinfections simulation');
grid on;
