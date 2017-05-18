function Pendulum()
    theta0 = pi/2;
    L = 1;
    g = 9.81;
    dt = 0.01;
    T = 10;
    
%    alpha = g/L*sin(theta)
    u0 = [theta0, 0]';
    f = @(u) [u(2) -g/L * sin(u(1))]';
    
    u = NaN(2, 3);
    u(:,1) = u0;
    u(:,2) = u0 + dt * f(u);
    
    N = T / dt;
    for i = 1:N
        
        u(:,3) = u(:,1) + 2 *dt * f(u(:,2));
        u = circshift(u, [0 -1]);
        
        theta = u(1, 2);
        x = [0 sin(theta) * L];
        y = [0 -cos(theta) * L];
        
        plot(x, y);
        str = sprintf('%0.5g',i * dt);
        axis([-1 1 -1 1]);
        axis square
        legend(str, 'Location', 'northwest');
        drawnow
    end
end