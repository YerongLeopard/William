DATA= xlsread('data.xlsx','precision');

LatticeC = DATA(:,1);

lowQME    = DATA(:,2);
lowF0     = DATA(:,4);

mediumQME = DATA(:,5);
mediumF0  = DATA(:,7);

highQME   = DATA(:,8);
highF0    = DATA(:,10);

figure; hold on;
xx = 6: 0.01: 7.2; %intrapolation range

plot_lowQME    = plot(LatticeC,   lowQME, 'rs');
yy = spline(LatticeC, lowQME, xx); plot(xx, yy, '-r');
plot_lowF0     = plot(LatticeC,    lowF0, 'ro');
yy = spline(LatticeC, lowF0, xx); plot(xx, yy, '-r');

plot_mediumQME = plot(LatticeC,mediumQME, 'bs');
yy = spline(LatticeC, mediumQME, xx); plot(xx, yy, '-b');
plot_mediumF0  = plot(LatticeC, mediumF0, 'bo');
yy = spline(LatticeC, mediumF0, xx); plot(xx, yy, '-b');

plot_highQME   = plot(LatticeC,  highQME, 'ks');
yy = spline(LatticeC, highQME, xx); plot(xx, yy, '-k');
plot_highF0    = plot(LatticeC,   highF0, 'ko');
yy = spline(LatticeC, highQME, xx); plot(xx, yy, '-k');

 h = legend([plot_lowQME, plot_lowF0, ...
             plot_mediumQME, plot_mediumF0, ...
             plot_highQME, plot_highF0], ...
     ['F(0K): $c_{opt}$(nst) = ' num2str(optC_nst_f0) '$\AA$'], ...
     ['F(0K): $c_{opt}$(full) = ' num2str(optC_full_f0) '$\AA$'], ...
     ['QME: $c_{opt}$(nst) = ' num2str(optC_nst_qme) '$\AA$'], ...
     ['QME: $c_{opt}$(full) = ' num2str(optC_full_qme) '$\AA$'], ...
     ['QME: $c_{opt}$(full) = ' num2str(optC_full_qme) '$\AA$'], ...
     ['QME: $c_{opt}$(full) = ' num2str(optC_full_qme) '$\AA$'] ...
 );

set(h, 'interpreter', 'latex');
set(h, 'fontsize', 15);
h = xlabel('Lattice constant c/ $\AA$');
set(h,'interpreter','latex');
h = ylabel('Energy/ $eV$ per atom');
set(h,'interpreter','latex');