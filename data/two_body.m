DATA = xlsread('data.xlsx','CCmd');
%dim = size(DATA);
LatticeC = DATA(:, 1);
QM = DATA(:, 2);
xx = 3: 0.01: 3.6; %intrapolation range
X6S_original = DATA(:, 3); X6S_optimized = DATA(:, 4);
LJ_original =DATA(:, 5); LJ_optimized = DATA(:, 6);
% disp(X6S_optimized)% DEBUG
X6_original = DATA(:, 7); X6_optimized = DATA(:, 8);
EXP1_optimized = DATA(:, 9);
EXP2_optimized = DATA(:, 10);
EXPfull_optimized = DATA(:, 11);
CC= LatticeC / 2;
figure; hold on;
plotQM = plot (CC, QM, 'ok','MarkerSize',10);


% plotX6S_original = plot(CC , X6S_original, 'xb','MarkerSize',10); plotX6S_optimized = plot(CC , X6S_optimized, '*b','MarkerSize',10);
% yy = spline(CC,X6S_original,xx); plot(xx, yy, '-b');
% yy = spline(CC,X6S_optimized,xx); plot(xx, yy, '-b');
% plotLJ_original = plot(CC , LJ_original, 'xg','MarkerSize',10); plotLJ_optimized = plot(CC , LJ_optimized, '*g','MarkerSize',10);
% yy = spline(CC,LJ_original,xx); plot(xx, yy, '-g');
% yy = spline(CC,LJ_optimized,xx); plot(xx, yy, '-g');
plotX6_original = plot(CC , X6_original, 'xr','MarkerSize',10); plotX6_optimized = plot(CC , X6_optimized, '*r','MarkerSize',10);
yy = spline(CC,X6_original,xx); plot(xx, yy, '-r');
yy = spline(CC,X6_optimized,xx); plot(xx, yy, '-r');

plotEXP1_optimized = plot(CC , EXP1_optimized, 'b*','MarkerSize',10);
yy = spline(CC,EXP1_optimized,xx); plot(xx, yy, 'b-');

plotEXP2_optimized = plot(CC , EXP2_optimized, 'g*','MarkerSize',10);
yy = spline(CC,EXP2_optimized,xx); plot(xx, yy, 'g-');

plotEXPfull_optimized = plot(CC , EXPfull_optimized, 'k*','MarkerSize',10);
yy = spline(CC,EXPfull_optimized,xx); plot(xx, yy, 'k-.');
h = legend([plotQM, ... 
    plotX6_original, plotX6_optimized, ... 
    plotEXP1_optimized, ...
    plotEXP2_optimized, ...
    plotEXPfull_optimized], ...
    'QM', ...
    'X6\_original', 'X6\_optimized', ...
    '$$\textbf{Z}\exp(\textbf{A}r)$$    $$\textbf{C}_6$$,$$R_0$$', ...
    '$$Z\exp(Ar)\cdot\exp(-\textbf{C}r^2+\textbf{D})$$   $$C_6$$,$$R_0$$', ...
    '$$\textbf{Z}\exp(\textbf{A}r)\cdot\exp(-\textbf{C}r^2+\textbf{D})$$   $$\textbf{C}_6$$,$$R_0$$' ...
    );
%     plotX6S_original, plotX6S_optimized,
%     plotLJ_original, plotLJ_optimized
%     'X6S\_original', 'X6S\_optimized',
%     'LJ\_original', 'LJ\_optimized',
set(h, 'fontsize', 15);
set(h, 'Location', 'BestOutside');
set(h,'interpreter','latex');

h = xlabel('layer distance/ $\AA$');
set(h,'interpreter','latex');
set(h, 'fontsize', 20);
set(h, 'fontweight', 'bold');
h = ylabel('Energy difference/ $kcal/ mol$');
set(h,'interpreter','latex');
set(h, 'fontsize', 20);
set(h, 'fontweight', 'bold');