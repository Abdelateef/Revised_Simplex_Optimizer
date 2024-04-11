% Define the inequalities
x = linspace(0, 5, 100); % Create a range of x values
ineq1 = 4 - 2*x; % 2x1 + x2 <= 4 => x2 <= 4 - 2x1
ineq2 = (5 - x)/2; % x1 + 2x2 <= 5 => x2 <= (5 - x1)/2

% Find points of intersection
A = [2, 1; 1, 2]; % Coefficients matrix
B = [4; 5]; % Right-hand side vector
intersection_points = linsolve(A, B);

% Plot the inequalities
figure;
plot(x, ineq1, 'r', 'LineWidth', 2); % Plotting 2x1 + x2 <= 4 in red
hold on;
plot(x, ineq2, 'b', 'LineWidth', 2); % Plotting x1 + 2x2 <= 5 in blue
ylim([0, 5]); % Set y-axis limits
xlim([0, 5]); % Set x-axis limits
xlabel('x_1');
ylabel('x_2');
title('Example 1');

% Highlight the correct feasible region
x_fill = linspace(0, min(2,5)); % x-values for filling the feasible region
y_fill = min(4 - 2*x_fill, (5 - x_fill)/2); % y-values for filling
fill([x_fill, 0], [y_fill, 0], 'g', 'FaceAlpha', 0.3); % Fill the correct feasible region in green

% Mark points of intersection
scatter(intersection_points(1, 1), intersection_points(2, 1), 100, 'k', 'filled');

% Add contour plot for Z = 2x1 + 3x2 with dashed lines
[X, Y] = meshgrid(linspace(0, 5, 100), linspace(0, 5, 100));
Z = 2*X + 3*Y;
contour(X, Y, Z, 20, 'k--', 'LineWidth', 1.5); % Dashed contour plot in black

legend('2x_1 + x_2 \leq 4', 'x_1 + 2x_2 \leq 5', 'Feasible Region', 'Z = 2x_1 + 3x_2', 'Intersection Points');
grid on;
