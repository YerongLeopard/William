DATA= xlsread('data.xlsx','precision');
LatticeC = DATA(:,1);

lowQME    = DATA(:,2);
lowF0     = DATA(:,4);

mediumQME = DATA(:,5);
mediumF0  = DATA(:,7);

highQME   = DATA(:,8);
highF0    = DATA(:,10);

figure; hold on;
plot_lowQME    = plot(LatticeC,   lowQME, 'rs');
plot_lowF0     = plot(LatticeC,    lowF0, 'ro');

plot_mediumQME = plot(LatticeC,mediumQME, 'bs');
plot_mediumF0  = plot(LatticeC, mediumF0, 'bo');

plot_highQME   = plot(LatticeC,  highQME, 'ks');
plot_highF0    = plot(LatticeC,   highF0, 'ko');

