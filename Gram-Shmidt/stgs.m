%1. Set Q = A.
%2. Let r_{jj} = |q_j|.
%3. Replace q_j by q_j/r_{jj}.
%4. Make q_{j+1}, ..., q_n orthogonal to q_j, as follows:
%(a) Let r_{j,k} = <q_k, q_j>, for k = j+1, ..., n.
%(b) Replace q_k by q_k ? r_{jk}q_j , for k = j+1, ..., n.
%5. Repeat steps 2, 3, and 4 for j = 1, ..., n.

function [Q,R] = stgs(A)
  Q = zeros(size(A));
  R = zeros(size(A));
  
  a1 = A(:,1);
  R(1,1) = sqrt(dot(a1,a1));
  Q(:,1) = a1 / R(1,1);
  
  for i = 2:size(A,2)
    v = A(:,i);
    for j = 1:i-1
      u = Q(:,j); % u - already unit length
      R(j,i) = dot(v,u);
      p = R(j,i) * u;
      v = v - p;
    end
    R(i,i) = sqrt(dot(v,v));
    Q(:,i) = v / R(i,i);
  end
end