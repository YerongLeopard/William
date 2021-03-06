DATA= xlsread('data.xlsx','shift');
ORG= xlsread('data.xlsx', 'CCmd');
LatticeC = DATA(:,1);
phn      = DATA(:,2);
X6       = DATA(:,3);
VopX     = DATA(:,4);
full     = DATA(:,5);

xx = 6.0: 0.01: 7.1; %intrapolation range
x_search = LatticeC(8):0.00001:LatticeC(5);

figure; hold on;


plot_phn    = plot(LatticeC,   phn, 'ko');
y_search =  spline(LatticeC, phn, x_search);
x_min_phn = x_search(find(y_search == min(y_search)))
plot_org    = plot(ORG(:,1), ORG(:,3), 'kx');

plot_X6    = plot(LatticeC,   X6, 'g*');
yy = spline(LatticeC, X6, xx); plot(xx, yy, 'g-');
y_search =  spline(LatticeC, X6, x_search);
x_min_X6 = x_search(find(y_search == min(y_search)))

plot_VopX    = plot(LatticeC,   VopX, 'b*');
yy = spline(LatticeC, VopX, xx); plot(xx, yy, 'b-');
y_search =  spline(LatticeC, VopX, x_search);
x_min_VopX = x_search(find(y_search == min(y_search)))

plot_full    = plot(LatticeC,   full, 'r*');
yy = spline(LatticeC, full, xx); plot(xx, yy, 'r-');
y_search =  spline(LatticeC, full, x_search);
x_min_full = x_search(find(y_search == min(y_search)))

axis([6.0 7.1 ylim]);

% Illustration lines
plot([x_min_phn x_min_phn] , ylim, 'k--');
plot([x_min_X6 x_min_X6] , ylim, 'g--');
plot([x_min_VopX x_min_VopX] , ylim, 'b--');
plot([x_min_full x_min_full] , ylim, 'r--');

h = legend([plot_org,...
    plot_phn, ...
    plot_X6, ...
    plot_VopX, ...
    plot_full], ...
    'Original QM+phn', ...
    ['Shifted QM+phn, reducing c by 0.0733 \AA $c_{opt}$=' num2str(x_min_phn) '$\AA$'], ...
    ['X6 potential $c_{opt}$=' num2str(x_min_X6) '$\AA$'], ...
    ['$\textbf{Z}\exp(\textbf{A}r)$ $\textbf{C}_6$,$R_0$ $c_{opt}$=' num2str(x_min_VopX) '$\AA$'], ...
    ['$\textbf{Z}\exp(\textbf{A}r)\cdot\exp(-\textbf{C}r^\textbf{n}+\textbf{D}r)$ $\textbf{C}_6$,$R_0$ $c_{opt}$=' num2str(x_min_full) '$\AA$']);

set(h,'interpreter','latex');
set(h, 'fontsize', 15);

h = ylabel('Energy difference/ $kcal/ mol$');
set(h,'interpreter','latex');
set(h, 'fontsize', 15);
h = xlabel('Lattice constant c/ $\AA$');
set(h,'interpreter','latex');
set(h, 'fontsize', 15);


