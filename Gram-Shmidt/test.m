[U,X] = qr(randn(80)); % randn() use the normal distribution.
[V,X] = qr(randn(80));
S = diag(2 .^ (-1:-1:-80)); % .^ means element-wise exponentiation.
A = U*S*V

[Qc,Rc] = clgs(A); % Here we are only interested in the R, but
[Qs,Rs] = stgs(A); % you might also check norm(Q’*Q-eye(80)).
[Q,R] = qr(A);
x = diag(Rc); % This is a way to collect the diagonal entries
y = diag(Rs); % into a vector -- can you find a better way?
z = abs(diag(R)); % qr() does not guarantee a postive diagonal.

abscissae=1:1:80;
plot(abscissae,log2(x),'+',abscissae,log2(y),'o',abscissae,log2(z),'*');
legend('clgs', 'stgs', 'qr');
