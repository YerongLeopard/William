DATA = dlmread('data.txt', ' ', 1, 0);
%DATA = importdata('data.txt', ' ', 1);
%DATA = dlmread('data.txt');
dim = size(DATA);
DATA = DATA(2:13, 1:dim(2))
A = 2.4671554423831878;
LatticeC = DATA(:,1);
Volume = LatticeC.*A*A*sqrt(3)/8;
F0 = DATA(:,3);

%% test


BMfitF = @(FBV, V)( ...
    FBV(1)+ ...
    9./16.* FBV(2)*FBV(4)* (... 
            ((FBV(4)./V).^(2./3.)-1).^3. * FBV(3) + ...
            ((FBV(4)./V).^(2./3.)-1).^2. .*(6- 4*(FBV(4)./V).^(2./3.)) ...
                           ) ...
    );

figure; hold on;
plot(LatticeC, F0, '*');
xx = 2.5:0.05:8.;
xxvol = xx*A*A*sqrt(3)/8;
beta0 = [-9.3062    0.2469   10.9828    9.0445 ];
% opts = statset('MaxIter',9000, 'TolFun', 1e-30);
opts = statset('TolFun', 1e-100);
beta = nlinfit(Volume, F0, BMfitF,beta0, opts);
optC = beta(4)/A/A/sqrt(3)*8.;
disp(sprintf('Optimal Lattice Constant C : %.4f', optC));
% BMfitF(beta0, Volume);
plot(xlim, [beta(1) beta(1)]);
plot([optC optC], ylim);
ylim
plot(xx, BMfitF(beta, xxvol),'-');