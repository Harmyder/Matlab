% reduced QR-decomposition

classdef QR
    methods (Static)
        function [Q, R] = Classical(A)
            [m, n] = size(A);
            CheckInput(m, n);

            Q = A;
            % We don't know size(R) at the moment,
            % because we don't know rank(A)
            for c = 1 : n
                for q = 1 : c - 1
                    R(q, c) = Q(:, q)' * A(:, c);
                    Q(:, c) = Q(:, c) - R(q, c) * Q(:, q);
                end
                % We can use minus sign for R_cc as well
                R(c, c) = norm(Q(:, c)); 
%                if R(c, c) > SDK.NamedValues.EPSILON
                    Q(:, c) = Q(:, c) / R(c, c);
%                end
            end
        end
        
        function [Q, R] = Modified(A)
            [m, n] = size(A);
            CheckInput(m, n);

            Q = A;
            % We don't know size(R) at the moment,
            % because we don't know rank(A)
            for q = 1 : n
                R(q, q) = norm(Q(:, q));
%                if R(q, q) > SDK.NamedValues.EPSILON
                    Q(:, q) = Q(:, q) / R(q, q);
                    for c = q + 1 : n
                        R(q, c) = Q(:, q)' * Q(:, c);
                        Q(:, c) = Q(:, c) - R(q, c) * Q(:, q);
                    end
%                end
            end
        end
        
        function [W,R]=house(A)
            m=size(A,1);
            n=size(A,2);
            W=zeros(m,n);
            for k=1:n
                x=A(k:m,k);
                e1=eye(m-k+1,1);
                if (x(1)==0) 
                    coef=1;
                else
                    coef=sign(x(1));
                end
                W(k:m,k)=coef*norm(x,2)*e1+x;
                W(k:m,k)=W(k:m,k)/norm(W(k:m,k),2);
                A(k:m,k:n)=A(k:m,k:n)-2*W(k:m,k)*((W(k:m,k))'*A(k:m,k:n));
            end
            R=triu(A,0);
        end

        function Q=formQ(W)
            m=size(W,1);
            Q=zeros(m,m);
            for i=1:m
                e=zeros(m,1);
                e(i)=1;
                Q(:,i)=SDK.Algorithms.QR.formQx(W,e);
            end
        end

        function a=formQx(W,vect)
            m=size(W,1);
            n=size(W,2);
            for k=n:-1:1
                vect(k:m)=vect(k:m)-2*W(k:m,k)*((W(k:m,k))'*vect(k:m));
            end
            a=vect;
        end
    
        function [Q, R] = Householder(A)
            [W,R]=SDK.Algorithms.QR.house(A);
            Q=SDK.Algorithms.QR.formQ(W);
        end
        
    end
    
    end

function CheckInput(m, n)
    assert(m >= n, 'Number of rows less then number of columns');
end
