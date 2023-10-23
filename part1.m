% parameters
beta = 0.3;  % transmission rate
gamma = 0.1;  % tecovery rate
mu = 0.01;  % tortality rate
N = 1000;  % total population
I0 = 10;  % initial infected individuals
S0 = N - I0;  % initial susceptible individuals
R0 = 0;  % initial recovered individuals
D0 = 0;  % initial deceased individuals

% time settings
Tmax = 200;  % max time
dt = 1;  % time step
T = 0:dt:Tmax;

% initialize vectors
S = zeros(1, length(T));
I = zeros(1, length(T));
R = zeros(1, length(T));
D = zeros(1, length(T));

S(1) = S0;
I(1) = I0;
R(1) = R0;
D(1) = D0;

for t = 2:length(T)
    dS = -beta * S(t-1) * I(t-1) / N * dt;
    dI = (beta * S(t-1) * I(t-1) / N - gamma * I(t-1) - mu * I(t-1)) * dt;
    dR = gamma * I(t-1) * dt;
    dD = mu * I(t-1) * dt;

    S(t) = S(t-1) + dS;
    I(t) = I(t-1) + dI;
    R(t) = R(t-1) + dR;
    D(t) = D(t-1) + dD;
end


figure;
plot(T, S, '-b', 'LineWidth', 2);
hold on;
plot(T, I, '-r', 'LineWidth', 2);
plot(T, R, '-g', 'LineWidth', 2);
plot(T, D, '-k', 'LineWidth', 2);
xlabel('Time (days)');
ylabel('Population');
legend('Susceptible', 'Infected', 'Recovered', 'Deceased');
title('SIRD Model Simulation');
grid on;
