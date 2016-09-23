DATA = xlsread('data.xlsx','CCmd');
%dim = size(DATA);
LatticeC = DATA(:, 1);
QM = DATA(:, 2);
xx = 3: 0.01: 3.6; %intrapolation range
X6S_original = DATA(:, 3); X6S_optimized = DATA(:, 4);
LJ_original =DATA(:, 5); LJ_optimized = DATA(:, 6);
disp(X6S_optimized)% DEBUG

X6_original = DATA(:, 7); X6_optimized = DATA(:, 8);
CC= LatticeC / 2;
figure; hold on;
plotQM = plot (CC, QM, 'ok','MarkerSize',10);
plotX6S_original = plot(CC , X6S_original, 'xb','MarkerSize',10); plotX6S_optimized = plot(CC , X6S_optimized, '*b','MarkerSize',10);
yy = spline(CC,X6S_original,xx); plot(xx, yy, '-b');
yy = spline(CC,X6S_optimized,xx); plot(xx, yy, '-b');
plotLJ_original = plot(CC , LJ_original, 'xg','MarkerSize',10); plotLJ_optimized = plot(CC , LJ_optimized, '*g','MarkerSize',10);
yy = spline(CC,LJ_original,xx); plot(xx, yy, '-g');
yy = spline(CC,LJ_optimized,xx); plot(xx, yy, '-g');
plotX6_original = plot(CC , X6_original, 'xr','MarkerSize',10); plotX6_optimized = plot(CC , X6_optimized, '*r','MarkerSize',10);
yy = spline(CC,X6_original,xx); plot(xx, yy, '-r');
yy = spline(CC,X6_optimized,xx); plot(xx, yy, '-r');
h = legend([plotQM, plotX6S_original, plotX6S_optimized, plotX6_original, plotX6_optimized, plotLJ_original, plotLJ_optimized], ...
    'QM', ...
    'X6S\_original', 'X6S\_optimized', ...
    'X6\_original', 'X6\_optimized', ...
    'LJ\_original', 'LJ\_optimized' ...
    );
set(h, 'fontsize', 15);
set(h, 'Location', 'BestOutside');
h = xlabel('layer distance/ $\AA$');
set(h,'interpreter','latex');
set(h, 'fontsize', 20);
set(h, 'fontweight', 'bold');
h = ylabel('Energy difference/ $kcal/ mol$');
set(h,'interpreter','latex');
set(h, 'fontsize', 20);
set(h, 'fontweight', 'bold');