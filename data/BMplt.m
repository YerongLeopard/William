DATA = dlmread('data.txt', ' ', 1, 0);
A = 2.4671554423831878;
LatticeC = DATA(:,1);
Volume = LatticeC.*A*A*sqrt(3)/8;
F300 = DATA(:,3);


BMfitF = @(FBV, V)( ...
    FBV(1)+ ...
    9./16.* FBV(2)*FBV(4)* (... 
            ((FBV(4)./V).^(2./3.)-1).^3. * FBV(3) + ...
            ((FBV(4)./V).^(2./3.)-1).^2..*(6- 4*(FBV(4)./V).^(2./3.)) ...
                           ) ...
    );

figure; hold on;
plot(LatticeC, F300, '*');
xx = 4:0.05:8.;
xxvol = xx*A*A*sqrt(3)/8;
beta0 = [-9.1 0. 0. 8.86 ];
opts = statset('MaxIter',9000);
beta = nlinfit(Volume, F300, BMfitF,beta0, opts);
disp(sprintf('Optimal Lattice Constant C : %.4f', beta(4)/A/A/sqrt(3)*8.));
% BMfitF(beta0, Volume);
plot(LatticeC, BMfitF(beta, Volume),'-');