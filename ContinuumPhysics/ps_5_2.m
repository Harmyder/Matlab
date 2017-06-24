classdef ps_5_2
    properties (Constant)
      radius = 5;
    end
   
    methods(Static)
        function [pts, tractions] = calc_sphere_stress(Sigma)
            arrowsPerLength = 0.3;
            pts = []; tractions = [];
            for i = 0:10
                theta = -pi/2+pi*i/10;
                radiusxy = ps_5_2.radius * cos(theta);
                circum = 2*pi*radiusxy;
                arrowsCount = circum*arrowsPerLength;
                for j = 1:arrowsCount
                    phi = 2*pi*j/arrowsCount;
                    n = [cos(theta)*cos(phi), cos(theta)*sin(phi), sin(theta)];
                    tractions = [tractions; (Sigma*n')'];
                    p = ps_5_2.radius * (n);
                    pts = [pts; p];        
                end
            end
        end

        function plot_sphere_stress(pts, tractions)
            [x,y,z] = sphere;
            s = surf((ps_5_2.radius-1)*x, (ps_5_2.radius-1)*y, (ps_5_2.radius-1)*z,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
            alpha(s, 0.5);
            shading interp
            hold on
            quiver3(pts(:,1), pts(:,2), pts(:,3), tractions(:,1), tractions(:,2), tractions(:,3), 'AutoScale', 'off');
            hold off
        end

        function [pts, tractions] = calc_cube_stress(Sigma)
            arrowsPerLength = 0.3;
            pts = []; tractions = [];
            side = ps_5_2.radius * 2;
            stepsCount = side * arrowsPerLength;
            stepSize = side / stepsCount;
            normals = [
                [0,0, 1]
                [0,0,-1]
                [0, 1,0]
                [0,-1,0]
                [ 1,0,0]
                [-1,0,0]
                ];
            for i = 0:stepsCount
                for j = 0:stepsCount
                    for ni = 1:size(normals)
                        n = normals(ni,:);
                        xy = []; z = -1;
                        if (n(1) == 0) xy = [xy; 1]; else z = 1; end
                        if (n(2) == 0) xy = [xy; 2]; else z = 2; end
                        if (n(3) == 0) xy = [xy; 3]; else z = 3; end
                        tractions = [tractions; (Sigma*n')'];
                        p = zeros(1,3);
                        p(xy(1)) = i*stepSize - side/2;
                        p(xy(2)) = j*stepSize - side/2;
                        p(z) = n(z) * side/2;
                        pts = [pts; p];
                    end
                end
            end
        end
        
        function draw_cube(T)
            V=0.5*[ -1 -1 -1; -1 1 -1; 1 1 -1; 1 -1 -1; -1 -1 1; -1 1 1; 1 1 1; 1 -1 1 ];
            S.Vertices = (T*V')';
            S.Faces=[ 1 2 3 4; 5 6 7 8; 1 2 6 5; 2 3 7 6; 3 4 8 7; 1 4 8 5 ];
            S.FaceVertexCData = [ 1 ];
            S.FaceColor = 'flat';
            S.EdgeColor = 'green';
            p = patch(S);
            alpha(p, 0.5);
        end
        
        function plot_cube_stress(pts, tractions)
            ps_5_2.draw_cube(eye(3) * ps_5_2.radius * 2);
            hold on
            quiver3(pts(:,1), pts(:,2), pts(:,3), tractions(:,1), tractions(:,2), tractions(:,3), 'AutoScale', 'off');
            hold off
        end
        
        function pass(S, spi, name)
            % Handle sphere case
            [pts, tractions] = ps_5_2.calc_sphere_stress(S);
            subplot(2,3,spi+0)
            ps_5_2.plot_sphere_stress(pts, tractions);
            title(strcat('Sphere (', name, ')'));
            
            % Handle cube case
            [pts, tractions] = ps_5_2.calc_cube_stress(S);
            subplot(2,3,spi+1)
            ps_5_2.plot_cube_stress(pts, tractions);
            title(strcat('Cube (', name, ')'));
        end
        
        function do()
            figure

            rho = 1;

            % Prepare stress tensor and do first pass
            S = -rho * eye(3);
            ps_5_2.pass(S,1,'a');

            % Prepare stress tensor and do second pass
            S = -rho * ones(3,3);
            ps_5_2.pass(S,4,'b');
        end
    end
end
    