DATA = xlsread('data.xlsx','CCmd');
DATAup = xlsread('data.xlsx','up');
DATAdown = xlsread('data.xlsx','down');

QMph =DATA(:, 3);
X6_optimized = DATA(:, 9);
EXP1_optimized = DATA(:, 10);
EXP2_optimized = DATA(:, 11);

Lattice_C = DATAup(:,1);
upQM = DATAup(:,2);
upX6 = DATAup(:,3);
upVopX = DATAup(:,4);

downQM = DATAdown(:,2);
downX6 = DATAdown(:,3);
downVopX = DATAdown(:,4);

xx = 6.1: 0.01: 7.1; %intrapolation range
x_search = LatticeC(8):0.00001:LatticeC(5);

figure; hold on;
plotQM = plot (Lattice_C, QMph, 'ok','MarkerSize',10);
plotQMup = plot (Lattice_C, upQM, 'ok','MarkerSize',10);
plotQMdown = plot (Lattice_C, downQM, 'ok','MarkerSize',10);
y_search =  spline(Lattice_C, QMph, x_search);
x_min_QM = x_search(find(y_search == min(y_search)))

plotX6 = plot(Lattice_C , X6_optimized, '*r','MarkerSize',10);
yy = spline(Lattice_C, X6_optimized, xx); plot(xx, yy, '-r');
plotX6up = plot(Lattice_C , upX6, 'Xr','MarkerSize',10);
yy = spline(Lattice_C, upX6, xx); plot(xx, yy, '-r');
plotX6down = plot(Lattice_C , downX6, 'sr','MarkerSize',10);
yy = spline(Lattice_C, downX6, xx); plot(xx, yy, '-r');

plotVopX = plot(Lattice_C , EXP1_optimized, '*b','MarkerSize',10);
yy = spline(Lattice_C, EXP1_optimized, xx); plot(xx, yy, '-b');
plotVopXup = plot(Lattice_C , upVopX, 'Xb','MarkerSize',10);
yy = spline(Lattice_C, upVopX, xx); plot(xx, yy, '-b');
plotVopXdown = plot(Lattice_C , downVopX, 'sb','MarkerSize',10);
yy = spline(Lattice_C, downVopX, xx); plot(xx, yy, '-b');