function K = KTBC( type, n, isSparse )
%KTBC generates four n*n matrices

if nargin < 3
    isSparse = 0;
end
  
if isSparse == 0
    K = toeplitz([2 -1 zeros(1, n-2)]);
else
    e=ones(n,1);
    K=spdiags([-e,2*e,-e],-1:1,n,n);
end

switch type
    case 'K'
    case 'T'
        K(1,1)=1;
    case 'B'
        K(1,1)=1;
        K(n,n)=1;
    case 'C'
        K(1,n)=-1;
        K(n,1)=-1;
    otherwise 
        error('Unknown matrix type.');
end

end

