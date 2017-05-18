% Householder: 
% W - lower triangular, consists of vectors which define successive 
%     reflections,
% R - upper triangular.

classdef HT
    methods (Static)
        function [W, R] = house(A)
            [m,n] = size(A);
            assert(m >= n, 'Wrong input size.');

            R = A;
            W = zeros(m,n);
            for c = 1:n-1
                x = [zeros(1,c-1) R(c:m,c)']';
                W(c,c) = sign(R(c,c)) * norm(x);
                W(:,c) = W(:,c) + x;
                W(:,c) = W(:,c) / norm(W(:,c));
                R(c:m,c:n) = R(c:m,c:n) - 2 * W(c:m,c) * (W(c:m,c)' * R(c:m,c:n));
            end
        end
        function Q = formQ(W)
            [m,n] = size(W);
            assert(m >= n, 'Wrong input size.');
            
            I = eye(m);
            Q = I;
            Qc = zeros(m, n);
            for c = 1:n
                v = W(c:m,c);
                F = 2 * v * v' / (v' * v);
                Qc = blkdiag(eye(c - 1), eye(n - c + 1) - F);
                Q = Q * Qc;
            end
        end
    end
end