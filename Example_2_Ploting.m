% Define the new inequalities
x = linspace(0, 5, 100); % Create a range of x values
ineq1 = (24 - 6*x)/4; % 6x1 + 4x2 <= 24 => x2 <= (24 - 6x)/4
ineq2 = (6 - x)/2; % x1 + 2x2 <= 6 => x2 <= (6 - x1)/2
ineq3 = 2*ones(size(x)); % x2 <= 2
ineq4 = (1 + x)/2; % -x1 + 2x2 <= 1 => x2 <= (1 + x)/2

% Find points of intersection for each pair of constraints
intersection_points_1_2 = linsolve([6, 4; 1, 2], [24; 6]);
intersection_points_2_3 = [0 ;0.5];
intersection_points_3_4 = [4; 0];
intersection_points_1_4 = [2.5; 1.75];
intersection_points_1_5 = [0; 0];


% Combine all intersection points
all_intersection_points = unique([intersection_points_1_2, intersection_points_2_3, intersection_points_3_4, intersection_points_1_4,intersection_points_1_5]', 'rows')';

% Calculate the convex hull
k = convhull(all_intersection_points');

% Plot the new inequalities
figure;
plot(x, ineq1, 'r', 'LineWidth', 2); % Plotting 6x1 + 4x2 <= 24 in red
hold on;
plot(x, ineq2, 'b', 'LineWidth', 2); % Plotting x1 + 2x2 <= 6 in blue
plot(x, ineq3, 'g', 'LineWidth', 2); % Plotting x2 <= 2 in green
plot(x, ineq4, 'm', 'LineWidth', 2); % Plotting -x1 + 2x2 <= 1 in magenta

% Highlight the feasible region using convex hull
fill(all_intersection_points(1, k), all_intersection_points(2, k), 'c', 'FaceAlpha', 0.3);

% Mark points of intersection
scatter(all_intersection_points(1, :), all_intersection_points(2, :), 100, 'k', 'filled');

% Add contour plot for Z = 5x1 + 4x2 with dashed lines
[X, Y] = meshgrid(linspace(0, 5, 100), linspace(0, 5, 100));
Z = 5*X + 4*Y;
contour(X, Y, Z, 20, 'k--', 'LineWidth', 1.5); % Dashed contour plot in black

legend('6x_1 + 4x_2 \leq 24', 'x_1 + 2x_2 \leq 6', 'x_2 \leq 2', '-x_1 + 2x_2 \leq 1', 'Feasible Region', 'Z = 5x_1 + 4x_2', 'Intersection Points');
grid on;
