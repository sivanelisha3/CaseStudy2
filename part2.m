% Step 1: Load the data from the 'COVID_STL.mat' file
load('COVID_STL.mat');

% Step 2: Normalize cases and deaths by population
normalized_cases = cases_STL / POP_STL;
normalized_deaths = deaths_STL / POP_STL;

% Step 3: Create a plot of normalized cases and deaths vs. dates on the same figure
figure;
plot(dates, normalized_cases, 'b', 'LineWidth', 2);
hold on;
plot(dates, normalized_deaths, 'r', 'LineWidth', 2);

% Customize the plot
title('Normalized COVID Cases and Deaths in St. Louis');
xlabel('Date');
ylabel('Normalized Cases/Deaths');
legend('Normalized Cases', 'Normalized Deaths');
grid on;


% Display the figure
hold off;
