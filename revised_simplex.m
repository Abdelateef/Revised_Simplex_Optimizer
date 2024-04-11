% The revised_simplex function takes four input parameters:
%   f: Coefficients of the objective function to be maximized or minimized
%   A: Coefficient matrix for the system of constraints
%   b: Right-hand side vector of the constraints
%   obj: String specifying the optimization type ("max" for maximization, "min" for minimization)

% The function internally converts the maximization problem into a minimization problem,
% adds slack variables to handle inequalities, and initializes the basic feasible solution.
% The function prints the optimal solution vector X_B and the optimal objective function value z.
% Ensure that the input follows the standard form of linear programming problems.
% The function also handles unbounded problems and reports if the problem is unbounded.

% Output:
% The function will display the optimal solution vector X_B and the optimal objective function value z.

function revised_simplex(f, A, b,obj)
    [m, n] = size(A);
    if obj=="max"
        c=-f;
    elseif obj == "min"
        c=f;
    end 
    % Add slack variables
    A = [A, eye(m)];
    c = [c, zeros(1, m)];
    % Initial basic feasible solution
    [m, n] = size(A);
    non_basic_index= 1:(n - m);
    basic_index=(n - m + 1):n;
    C_B = c(:, basic_index);
    B = A(:, basic_index);
    P=A(:, non_basic_index);
    C=c(:, non_basic_index);
    %the solution in each iteration
    invB =inv(B); 
    X_B = invB*b;
    z = C_B * X_B;
    while true
        % Optimality condition
        reduced_costs = C_B * invB * P - C;
        if all(reduced_costs <= 0)
            fprintf('Optimal solution found:\n');
            fprintf('X_B = %s\n', mat2str(X_B));
            fprintf('z = %f\n', -z);
            break;
        end
        % Entering vector
        [~, entering_index] = max(reduced_costs);
        real_entering_index = non_basic_index(entering_index);
        %Feasibility Condition
        P_j = invB * A(:, real_entering_index);
        if all(P_j <= 0)
            fprintf('Problem is unbounded.\n');
            break;
        end
        % Ratio test to find leaving vector
        ratios = X_B ./ P_j;
        [~, leaving_index] = min(ratios(ratios>0));
        real_leaving_index = basic_index(leaving_index);
        % Update basis
        index_to_update_basic_index = find(basic_index == real_leaving_index);
        index_to_update_non_basic_index  = find(non_basic_index == real_entering_index);
        non_basic_index(index_to_update_non_basic_index)=real_leaving_index;
        basic_index(index_to_update_basic_index)=real_entering_index;
        C_B = c(:, basic_index);
        B = A(:, basic_index);
        P=A(:, non_basic_index);
        C=c(:, non_basic_index);
        invB=inv(B);
        X_B = invB*b;
        z = C_B * X_B;
    end
end
