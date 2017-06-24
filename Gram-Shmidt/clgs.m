% Outline of the classical algorithm
%1. Set r_{11} = |a| and q_1 = a_1/r_{11}.
%2. Given q_1, ..., q_{j?1}, construct q_j and r_j as follows:
%(a) Let P be the orthogonal projector onto span\{q_1, ..., q_{j?1}\}.
%(b) Let r_{1j} , ..., r_{j?1,j} be the coordinates of Pa_j .
%(c) Let v = a_j - Pa_j.
%(d) Let r_{jj} = |v|.
%(e) Finally, let q_j = v/r_{jj}.
%3. Repeat step 2 for j = 2, ..., n.

function [Q,R] = clgs(A)
  Q = zeros(size(A));
  R = zeros(size(A));
  
  a1 = A(:,1);
  R(1,1) = sqrt(dot(a1,a1));
  Q(:,1) = a1 / R(1,1);
  
  for i = 2:size(A,2)
    v = A(:,i);
    p = zeros(size(A,2),1);
    for j = 1:i-1
      u = Q(:,j); % u - already unit length
      R(j,i) = dot(v,u);
      p = p + R(j,i) * u;
    end
    v = v - p;
    R(i,i) = sqrt(dot(v,v));
    Q(:,i) = v / R(i,i);
  end
end
