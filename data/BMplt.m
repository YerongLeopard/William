DATA = dlmread('data.txt', ' ', 1, 0);
LatticeC = DATA(:,1);
F300 = DATA(:,3);


figure; hold on;
plot (LatticeC, F, '*');