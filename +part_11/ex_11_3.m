classdef ex_11_3
    % Exercise 11.3
    
    properties
        m = 50;
        n = 12;
    end
    
    methods
        function obj = ex_11_3()
            t = linspace(0, 1, obj.m);
            A = vander(t);
            A = fliplr(A);
            A = A(:, 1:obj.n);
            b = transpose(cos(4 * t));
            
            solns = zeros(obj.n, 6);
            
            % ls by MATLAB's \
            solns(:,1) = (A' * A)\(A' * b);
            
            % ls by modified GS
            [Q, R] = SDK.Algorithms.QR.Modified(A);
            solns(:,2) = R \ (Q' * b);

            % ls by house GS
            [Q, R] = SDK.Algorithms.QR.Householder(A);
            solns(:,3) = R \ (Q' * b);

            % ls by MATLAB qr
            [Q, R] = qr(A, 0);
            solns(:,4) = R \ (Q' * b);
            
            % ls by MATLAB \
            solns(:,5) = A \ b;
            
            % ls by MATLAB svd
            [U, E, V] = svd(A);
            solns(:,6) = (E * V') \ (U' * b);
            
            solns
            

        end
    end
    
end

