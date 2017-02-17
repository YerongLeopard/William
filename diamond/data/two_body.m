function []=two_body(RMdata, varargin)
if true == RMdata & nargin>2
    RMidx=varargin(:);
else if nargin >1
    name =varargin{1};RMidx=7;
    else
        name='CCmd'; RMidx=7;        
    end
end
DATA = xlsread('diamond_data.xlsx',name);

LatticeC = DATA(:, 1);
QM = DATA(:, 2);
QMph =DATA(:, 3);
X6S_original = DATA(:, 4); X6S_optimized = DATA(:, 5);
LJ_original =DATA(:, 6); LJ_optimized = DATA(:, 7);
X6_original = DATA(:, 8); X6_optimized = DATA(:, 9);
EXP1_optimized = DATA(:, 10);
EXP2_optimized = DATA(:, 11);
EXPfull_optimized = DATA(:, 12);

if true == RMdata
    LatticeC=LatticeC([1:RMidx-1,RMidx+1:end]);
    QM=QM([1:RMidx-1,RMidx+1:end]);
    QMph=QMph([1:RMidx-1,RMidx+1:end]);
    X6S_original= X6S_original([1:RMidx-1,RMidx+1:end]);X6S_optimized=X6S_optimized([1:RMidx-1,RMidx+1:end]);
    X6_original=X6_original([1:RMidx-1,RMidx+1:end]);X6_optimized=X6_optimized([1:RMidx-1,RMidx+1:end]);
    EXP1_optimized=EXP1_optimized([1:RMidx-1,RMidx+1:end]);
    EXP2_optimized=EXP2_optimized([1:RMidx-1,RMidx+1:end]);
    EXPfull_optimized=EXPfull_optimized([1:RMidx-1,RMidx+1:end]);
end

xx = 6.1: 0.01: 7.1; %intrapolation range

figure; hold on;
x_search = LatticeC(8):0.00001:LatticeC(5);

plotQM = plot (LatticeC, QM, 'sk','MarkerSize',10);
yy = spline(LatticeC,QM,xx); plot(xx, yy, '--k');
y_search =  spline(LatticeC, QM, x_search);
x_min_QM = x_search(find(y_search == min(y_search)));

plotQMph = plot (LatticeC, QMph, 'ok','MarkerSize',10);
yy = spline(LatticeC,QMph,xx); plot(xx, yy, '--k');
y_search =  spline(LatticeC, QMph, x_search);
x_min_PN = x_search(find(y_search == min(y_search)));

% plotX6S_original = plot(LatticeC , X6S_original, 'xb','MarkerSize',10); plotX6S_optimized = plot(LatticeC , X6S_optimized, '*b','MarkerSize',10);
% yy = spline(LatticeC,X6S_original,xx); plot(xx, yy, '-b');
% yy = spline(LatticeC,X6S_optimized,xx); plot(xx, yy, '-b');
% plotLJ_original = plot(LatticeC , LJ_original, 'xg','MarkerSize',10); plotLJ_optimized = plot(LatticeC , LJ_optimized, '*g','MarkerSize',10);
% yy = spline(LatticeC,LJ_original,xx); plot(xx, yy, '-g');
% yy = spline(LatticeC,LJ_optimized,xx); plot(xx, yy, '-g');
% plotX6_original = plot(LatticeC , X6_original, 'xr','MarkerSize',10); 
plotX6_optimized = plot(LatticeC , X6_optimized, '*r','MarkerSize',10);
% yy = spline(LatticeC,X6_original,xx); plot(xx, yy, '-r');
% yy = spline(LatticeC,X6_optimized,xx); plot(xx, yy, '-r');


plotEXP1_optimized = plot(LatticeC , EXP1_optimized, 'b*','MarkerSize',10);
yy = spline(LatticeC,EXP1_optimized,xx); plot(xx, yy, 'b-');

% plotEXP2_optimized = plot(LatticeC , EXP2_optimized, 'g*','MarkerSize',10);
% yy = spline(LatticeC,EXP2_optimized,xx); plot(xx, yy, 'g-');

plotEXPfull_optimized = plot(LatticeC , EXPfull_optimized, 'k*','MarkerSize',10);
yy = spline(LatticeC,EXPfull_optimized,xx); plot(xx, yy, 'k-.');
h = legend([plotQM, ... 
    plotQMph, ...
    plotX6_optimized, ... 
    plotEXP1_optimized, ...
    plotEXPfull_optimized], ...
    ['QM: $C_{opt}=$' num2str(x_min_QM) '$\AA$'], ...
    ['QM + phonons : $C_{opt}=$' num2str(x_min_PN) '$\AA$'], ...
    'X6\_optimized', ...
    '$\textbf{Z}\exp(\textbf{A}r)$    $\textbf{C}_6$,$R_0$', ...
    '$\textbf{Z}\exp(\textbf{A}r)\cdot\exp(-\textbf{C}r^\textbf{n}+\textbf{D}r)$   $\textbf{C}_6$,$R_0$' ...
    );
%ylim = [-9.38 -9.31];
plot([x_min_QM x_min_QM], ylim, 'k-.');
plot([x_min_PN x_min_PN], ylim, 'k-.');


set(h, 'fontsize', 20);
set(h, 'Location', 'Best');
set(h,'interpreter','latex');

h = xlabel('layer distance/ $\AA$');
set(h,'interpreter','latex');
set(h, 'fontsize', 20);
set(h, 'fontweight', 'bold');
h = ylabel('Energy difference/ $kcal/ mol$');
set(h,'interpreter','latex');
set(h, 'fontsize', 20);
set(h, 'fontweight', 'bold');