DATA= xlsread('data.xlsx','precision');

LatticeC = DATA(:,1);

lowQME    = DATA(:,2);
lowF0     = DATA(:,4);

mediumQME = DATA(:,5);
mediumF0  = DATA(:,7);

highQME   = DATA(:,8);
highF0    = DATA(:,10);

figure; hold on;
xx = 6.1: 0.01: 7.2; %intrapolation range
x_search = LatticeC(8):0.00001:LatticeC(5);

plot_lowQME    = plot(LatticeC,   lowQME, 'rs');
yy = spline(LatticeC, lowQME, xx); plot(xx, yy, '-r');
y_search =  spline(LatticeC, lowQME, x_search);
x_min_low1 = x_search(find(y_search == min(y_search)))
plot_lowF0     = plot(LatticeC,    lowF0, 'ro');
yy = spline(LatticeC,  lowF0, xx); plot(xx, yy, '-r');
y_search =  spline(LatticeC, lowF0, x_search);
x_min_low2 = x_search(find(y_search == min(y_search)))

plot_mediumQME = plot(LatticeC,mediumQME, 'bs');
yy = spline(LatticeC, mediumQME, xx); plot(xx, yy, '-b');
y_search =  spline(LatticeC, mediumQME, x_search);
x_min_med1 = x_search(find(y_search == min(y_search)))
plot_mediumF0  = plot(LatticeC, mediumF0, 'bo');
yy = spline(LatticeC,  mediumF0, xx);  plot(xx, yy, '-b');
y_search =  spline(LatticeC, mediumF0, x_search);
x_min_med2 = x_search(find(y_search == min(y_search)))

plot_highQME   = plot(LatticeC,  highQME, 'ks');
yy = spline(LatticeC, highQME, xx); plot(xx, yy, '-k');
y_search =  spline(LatticeC, highQME, x_search);
x_min_hig1 = x_search(find(y_search == min(y_search)))
plot_highF0    = plot(LatticeC,   highF0, 'ko');
yy = spline(LatticeC,  highF0, xx); plot(xx, yy, '-k');
y_search =  spline(LatticeC, highF0, x_search);
x_min_hig2 = x_search(find(y_search == min(y_search)))


h = legend([plot_lowQME, plot_lowF0, ...
             plot_mediumQME, plot_mediumF0, ...
             plot_highQME, plot_highF0], ...
             ['QME: $c_{opt}$ = ' num2str(x_min_low1) '$\AA$;' 'SCF cutoff $10^{-6}$ - Plane wave cutoff 600'], ...
             ['F(0K): $c_{opt}$ = ' num2str(x_min_low2) '$\AA$;' 'SCF cutoff $10^{-6}$ - Plane wave cutoff 600'], ...
             ['QME: $c_{opt}$ = ' num2str(x_min_med1) '$\AA$;' 'SCF cutoff $10^{-8}$ - Plane wave cutoff 600'], ...
             ['F(0K): $c_{opt}$ = ' num2str(x_min_med2) '$\AA$;' 'SCF cutoff $10^{-8}$ - Plane wave cutoff 600' ' False phonon'], ...
             ['QME: $c_{opt}$ = ' num2str(x_min_hig1) '$\AA$;' 'SCF cutoff $10^{-8}$ - Plane wave cutoff 800'], ...
             ['F(0K): $c_{opt}$ = ' num2str(x_min_hig2) '$\AA$;' 'SCF cutoff $10^{-8}$ - Plane wave cutoff 800'] ...
 );

set(h, 'interpreter', 'latex');
set(h, 'fontsize', 12);
h = xlabel('Lattice constant c/ $\AA$');
set(h,'interpreter','latex');
h = ylabel('Energy/ $eV$ per atom');
set(h,'interpreter','latex');