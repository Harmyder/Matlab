function A = SymShur2_Apply(A, p, q)
    assert(size(A,1) == size(A,2));
    assert(p < q);
    [c, s] = SymSchur2(A, p, q);
    S = eye(size(A,1));
    S(p,p) = c;
    S(q,q) = c;
    S(p,q) = s;
    S(q,p) = -s;
    A = S' * A * S;
    
end

