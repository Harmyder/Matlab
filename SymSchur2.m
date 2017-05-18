function [c, s] = SymSchur2(A, p, q)
    if (abs(A(p,q)) > 0.0001)
        r = (A(q, q) - A(p, p)) / (2 * A(p,q));
        if (r <= 0)
            t = 1 / (r + sqrt(1 + r*r));
        else
            t = -1 / (-r + sqrt(1 + r*r));
        end
        c = 1 / sqrt(1 + t*t);
        s = t * c;
    else
        c = 1;
        s = 0;
    end
end

%    0.0010    2.0000
%    2.0000         0