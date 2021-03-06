%% Read an image from a file
clear all
clc


%u = imread('testpat_blur2.png');
u = imread('eye.png');
% convert image to double and scale to [0,1]
u = double(u) / (499);

[n,n2] = size(u);
if (n ~= n2)
  error('by default, this only supports square images')
end

figure(1); clf;
%pcolor(u); % try this one too
imagesc(u);
caxis([0 1])
colormap(gray)
axis equal, axis tight

% Grid and initial data:
hx = 1;
hy = 1;
x1d = 0:hx:(n-1);
y1d = 0:hy:(n2-1);
k = 0.1;    % time step (try .5, what happens?)

[x, y] = meshgrid(x1d, y1d);

% initial condition (must be periodic)
u0 = u;

[Dxx, Dyy, Dxc, Dyc, Dxb, Dyb, Dxf, Dyf, Dxyc] = ...
  diff2d_matrices(x1d, y1d, 0, 'p');

numsteps = 10;

v = u0(:);

% Time-stepping:
for m = 1:numsteps
  unew = v + k*(Dxx*v + Dyy*v);
  v = unew;
end

u2 = reshape(v, n, n2);

substr = u-u2;
unsharp_mask = u+ substr;
max_mask = max(unsharp_mask,[],'all');
min_mask = min(unsharp_mask, [],'all');

figure(2); clf;
imagesc(unsharp_mask);
caxis([0 1])
colormap(gray)
axis equal, axis tight


%% Output original and result side-by-side
% You could look at the resulting file with a web browser or image
% viewer
 result = [u  unsharp_mask];
 imwrite(result, 'result_eye.png')

