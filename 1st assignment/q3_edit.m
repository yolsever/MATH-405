%% heat equation approximate solution
% $u_t = u_{xx}$
% on $x \in [0, 1)$ with periodic boundary conditions
% and initial condition of u(x, 0) = sin(2*pi*x)
%% grid
clc
close all
clear all

h_results = [];
error_results = [];
u_exact = @(x,t) exp(-4*pi^2*t)*sin(2*pi*x);


for N = [20 40 80 160 320]
%N = 40;
h = 1/N;
x = 0:h:(1-h);  x = x';
e = ones(size(x));
%% initial condition
u0 = sin(2*pi*x);
% figure(1); clf;
% plot(x, u0, 'r-x')
%% spatial operator
L = spdiags([e -2*e e], [-1 0 1], N, N);
L(1, N) = 1;
L(N, 1) = 1;
L = (1/h^2)*L;
%% time
Tf = 0.25;
k = 0.25*h^2;
numsteps = ceil(Tf/k);
k = Tf/numsteps;
u = u0;
for n=1:(2*numsteps)
  unew = u + k*(L*u);
  u = unew;
%   clf;
%   if (mod(n, 25) == 0 || n == numsteps)  % plot every 25 steps
%     plot(x, u0, 'r-')
%     hold on
%     plot(x, u, 'bx-')
%     title(['n=' num2str(n) ', t=' num2str(k*n)])
%     xlabel('x'); ylabel('u')
%     drawnow
%   end
end

h_results = [h_results h];
error_results = [error_results norm(u - u_exact(x, numsteps*k), inf)];

end

loglog(h_results, error_results)