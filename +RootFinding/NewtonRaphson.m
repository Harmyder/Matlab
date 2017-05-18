function [x, exitflag, output] = NewtonRaphson(fun, x0, options)
    funwrapper = @(x) fun_wrapper(fun, x);
    
    exitflag = 1;
    
    TOLX = optimget(options, 'TolX');
    TOLFUN = optimget(options, 'TolFun');
    MAXITER = optimget(options, 'MaxIter');
    DISPLAY = strcmpi('iter', optimget(options, 'Display'));
    ALPHA = 1e-4;
    MIN_LAMBDA = 0.1;
    MAX_LAMBDA = 0.5;

    if DISPLAY
        fprintf('\n%10s %12s\n', 'Niter', 'Step')
        fmtstr = '%10d %12.4g\n';
        printout = @(n, dx)fprintf(fmtstr, n, dx);
    end
    
    x = x0;
    [F, J] = funwrapper(x);
    f = F' * F;
    niter = 0;
    lambda = 1;
    not_done = true;
    while (not_done)
        niter = niter + 1;
        
        if lambda == 1
            dx = -J \ F;
            if any(isnan(dx)) || any(isinf(dx))
                exitflag = -1;
                break;
            end
            g = F' * J;
            slope = g * dx;
            xold = x;
            fold = f;
        end

        x = xold + dx * lambda;
        [F, J] = funwrapper(x);
        f = F' * F;
        
        lambda1 = lambda;
        if f > fold + ALPHA * slope * lambda;
            if lambda == 1 
                lambda = -slope / 2 / (f - fold - slope);
            else
                A = 1 / (lambda1 - lambda2);
                B = [1 / lambda1^2, -1 / lambda2^2; -lambda2 / lambda1^2, lambda1 / lambda2^2];
                C = [f - fold - lambda1 * slope; f2 - fold - lambda2 * slope];
                coeff = num2cell(A * B * C);
                [a, b] = coeff{:};
                if a == 0
                    lambda = -slope / 2 / b;
                else
                    discriminant = b^2 - 3 * a * slope;
                    if discriminant < 0
                        lambda = MAX_LAMBDA * lambda;
                    elseif b <= 0
                        lambda = (-b + sqrt(discriminant)) / 3 / a;
                    else
                        lambda = -slope / (b + sqrt(discriminant));
                    end
                end
            end
        elseif isnan(f) || isinf(f)
            lambda = MAX_LAMBDA * lambda;
        else 
            lambda = 1;            
        end
        
        if lambda < 1
            lambda2 = lambda1;
            lambda = max(lambda, MIN_LAMBDA * lambda1);
        end
        
        stepnorm = norm(dx);
        if DISPLAY 
            printout(niter, stepnorm);
        end
        
        resnorm = norm(F);
        
        not_done = ...
            (niter < MAXITER) && ...
            (stepnorm >= TOLX) && ...
            (resnorm > TOLFUN || lambda < 1); % check function tolerance, but if backtracking
    end
    
    output.niter = niter;
    output.stepsize = dx;
    if niter >= MAXITER
        exitflag = 0;
        output.message = 'Number of iterations exceeded OPTIONS.MAXITER.';
    elseif exitflag == -1
        output.message = 'Matrix may be singular. Step was NaN or Inf.';
    else
        output.message = 'Normal exit.';
    end
end

function [F, J] = fun_wrapper(fun, x)
    try
        [F, J] = fun(x);
    catch
        F = fun(x);
        J = Jacobian(fun, x);
    end
end

function J = Jacobian(fun, x)
    dx = eps^(1/3);
    n = numel(fun(x));
    m = numel(x);
    J = zeros(n,m);
    for j = 1:m
        delta = zeros(n, 1);
        delta(j) = delta(j) + dx;
        dF = fun(x+delta) - fun(x-delta);
        J(:,j) = dF / dx / 2;
    end
end