function p = lagrange(knots, data)
%LAGRANGE  Plots the Lagrange polynomial interpolant for the
%given DATA at the given KNOTS

p = lagrange_poly(knots, data);

left = min(knots); right = max(knots); range = right - left;
top = max(data); bottom = min(data); height = top - bottom;

x = linspace(left - 0.1*range, right + 0.1*range, 500);
y = polyval(p, x);

%clf
h = gcf();
plot([0.5 4.5], [0 0], 'k-')
hold on
plot(knots, data, 'rx', 'linewidth',4, 'markersize',14)
h = get(h, 'children')
set(h, 'fontsize', 22)
hold on
plot(x, y, 'b-', 'linewidth',3)
xlabel('x')
%xlim([x(1) x(end)])
%ylim([bottom-0.1*height top+0.1*height])
%axis([left-0.1*range,right+0.1*range,bottom-0.1*height,top+0.1*height])
