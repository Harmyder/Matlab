% Approximate MATRIX a by 2-norm with matrix B of given rank

function B = NormApprox(A, r)
    [U E V] = svd(A);
    dE = diag(E);
    rankA = rank(E);
    B = diag(dE(1:r));

    B = (padarray(B ,rankA-r,0,'post'));
    B = (padarray(B',rankA-r,0,'post'));
    
    D = size(A) - size(B);
    dm = D(1);
    dn = D(2);

    B = (padarray(B',dm,0, 'post'))';
    B = (padarray(B ,dn,0, 'post'))';
    B = U * B * V;
    
    pcolor(B);
    colormap(gray);    
end