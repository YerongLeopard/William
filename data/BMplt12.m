disp ('12');
A = 2.4664372489959372;

%%%%%%%%%%%%%%%%%%%%%%%%%
DATA12 = xlsread('data.xlsx','data12');
dim = size(DATA12);
nst12 = DATA12(3:13, 1:dim(2));

%% model function


BMfitF = @(FBV, V)( ...
    FBV(1)+ ...
    9./16.* FBV(2)*FBV(4)* (... 
            ((FBV(4)./V).^(2./3.)-1).^3. * FBV(3) + ...
            ((FBV(4)./V).^(2./3.)-1).^2. .*(6- 4*(FBV(4)./V).^(2./3.)) ...
                           ) ...
    );


LatticeC = DATA12(:,1);
Volume = LatticeC.*A*A*sqrt(3)/8;
QME = DATA12(:,2);
figure; hold on;
title('Grimme');

plot(LatticeC, QME, '*');

xx = 2.5:0.05:8.;
xxvol = xx*A*A*sqrt(3)/8;
beta0 = [-9.3062    0.2469   10.9828    9.0445 ];
% opts = statset('MaxIter',9000, 'TolFun', 1e-30);
opts = statset('TolFun', 1e-100);

%%%
%%% whole fit
%%%
LatticeC = DATA12(:,1);
Volume = LatticeC.*A*A*sqrt(3)/8;
QME = DATA12(:,2);

beta = nlinfit(Volume, QME, BMfitF,beta0, opts);
optC_full = beta(4)/A/A/sqrt(3)*8.;

disp(sprintf('Optimal Lattice Constant C (full) : %.4f', optC_full));
% BMfitF(beta0, Volume);
% plot(xlim, [beta(1) beta(1)]);
% plot([optC optC], ylim);
plot(xlim, [beta(1) beta(1)],'k.-.', [optC_full optC_full], ylim , 'k.-.');
fit_full = plot(xx, BMfitF(beta, xxvol),'-');
%%%
%%% nearest fit
%%%
LatticeC = nst12(:,1);
Volume = LatticeC.*A*A*sqrt(3)/8;
QME = nst12(:,2);
beta = nlinfit(Volume, QME, BMfitF,beta0, opts);
optC_nst = beta(4)/A/A/sqrt(3)*8.;

disp(sprintf('Optimal Lattice Constant C (nst): %.4f', optC_nst));
% BMfitF(beta0, Volume);
% plot(xlim, [beta(1) beta(1)]);
% plot([optC optC], ylim);
plot(xlim, [beta(1) beta(1)],'k.-.', [optC_nst optC_nst], ylim , 'k.-.');
fit_nst = plot(xx, BMfitF(beta, xxvol),'-');

h = legend([fit_full, fit_nst],['F(0K): $c_{opt}$(full) = ' num2str(optC_full) '$\AA$'], ['F(0K): $c_{opt}$(nst) = ' num2str(optC_nst) '$\AA$']);
set(h, 'interpreter', 'latex');
set(h, 'fontsize', 15);
h = xlabel('Lattice constant c/ $\AA$');
set(h,'interpreter','latex');
h = ylabel('Energy/ $eV$ per atom');
set(h,'interpreter','latex');
