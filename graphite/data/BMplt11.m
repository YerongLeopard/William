disp ('11');
A = 2.4671554423831878;
surrounding = 3:17;

%%%%%%%%%%%%%%%%%%%%%%%%%
DATA11 = xlsread('data.xlsx','data11');
dim = size(DATA11);

idx = find(DATA11(:,5));
idx_nst = intersect(surrounding, idx);

F0 = DATA11(:, 3);

%% model function


BMfitF = @(FBV, V)( ...
    FBV(1)+ ...
    9./16.* FBV(2)*FBV(4)* (... 
            ((FBV(4)./V).^(2./3.)-1).^3. * FBV(3) + ...
            ((FBV(4)./V).^(2./3.)-1).^2. .*(6- 4*(FBV(4)./V).^(2./3.)) ...
                           ) ...
    );

BMfitP = @(BV, V)( ...
    1.5*BV(1)* ...
    ((BV(3)./V)^(7./3.)- (BV(3)./V)^(5./3.))* ...
    (1 + 0.75*(BV(2)-4) * ((BV(3)./V)^ (2./3.) - 1)) ...
);

LatticeC = DATA11(:,1);
Volume = LatticeC.*A*A*sqrt(3)/8, nstVoume = Volume(surrounding) ;
QME = DATA11(:,2);


%%%%%%%%%%%% ENERGY %%%%%%%%%%

figure; hold on;
title('Grimme');

plot(LatticeC, QME, 'b*');
plot(LatticeC(idx), F0(idx), 'r*');
%LatticeC
%QME

xx = 2.5:0.05:8.;
xxvol = xx*A*A*sqrt(3)/8;
beta0 = [-9.3062    0.2469   10.9828    9.0445 ];
% opts = statset('MaxIter',9000, 'TolFun', 1e-30);
opts = statset('TolFun', 1e-100);

%%%
%%% whole fit
%%%
LatticeC = DATA11(:,1);
Volume = LatticeC.*A*A*sqrt(3)/8;
QME = DATA11(:,2);

beta = nlinfit(Volume, QME, BMfitF,beta0, opts);
optC_full_qme = beta(4)/A/A/sqrt(3)*8.;

disp(sprintf('Optimal Lattice Constant C (full QME) : %.4f', optC_full_qme));
% BMfitF(beta0, Volume);
% plot(xlim, [beta(1) beta(1)]);
% plot([optC optC], ylim);
plot(xlim, [beta(1) beta(1)],'k.-.', [optC_full_qme optC_full_qme], ylim , 'k.-.');
fit_full_QME = plot(xx, BMfitF(beta, xxvol),'r--');

% LatticeC(idx)
% size(F0)
beta = nlinfit(Volume(idx), F0(idx), BMfitF, beta0, opts);
optC_full_f0 = beta(4)/A/A/sqrt(3)*8.;
disp(sprintf('Optimal Lattice Constant C (full F0): %.4f', optC_full_f0));
plot(xlim, [beta(1) beta(1)],'k.-.', [optC_full_f0 optC_full_f0], ylim , 'k.-.');
fit_full_F0 = plot(xx, BMfitF(beta, xxvol),'r-');


%%%
%%% nearest fit
%%%
%LatticeC = nst12(:,1);
%Volume = LatticeC.*A*A*sqrt(3)/8;
% QME = nst12(:,2);
beta = nlinfit(Volume(idx), QME(idx), BMfitF,beta0, opts);
optC_nst_qme = beta(4)/A/A/sqrt(3)*8.;

disp(sprintf('Optimal Lattice Constant C (nst QME): %.4f', optC_nst_qme));
% BMfitF(beta0, Volume);
% plot(xlim, [beta(1) beta(1)]);
% plot([optC optC], ylim);
plot(xlim, [beta(1) beta(1)],'k.-.', [optC_nst_qme optC_nst_qme], ylim , 'k.-.');
%plot([6.87, 6.87], ylim);
fit_nst_QME = plot(xx, BMfitF(beta, xxvol),'b--');
% size(F0(idx_nst))
% size(Volume(idx_nst))

beta = nlinfit(Volume(idx_nst), F0(idx_nst), BMfitF, beta0, opts);
optC_nst_f0 = beta(4)/A/A/sqrt(3)*8.;
disp(sprintf('Optimal Lattice Constant C (nst F0): %.4f', optC_nst_f0));
plot(xlim, [beta(1) beta(1)],'k.-.', [optC_nst_f0 optC_nst_f0], ylim , 'k.-.');
fit_nst_F0 = plot(xx, BMfitF(beta, xxvol),'b-');

% beta = nlinfit(Volume(idx), F0, BMfitF, beta0, opts);
% optC_nst = beta(4)/A/A/sqrt(3)*8.;
% disp(sprintf('Optimal Lattice Constant C (nst F0): %.4f', optC_nst));

h = legend([fit_nst_F0, fit_full_F0, fit_nst_QME, fit_full_QME], ...
    ['F(0K): $c_{opt}$(nst) = ' num2str(optC_full_f0) '$\AA$'], ...
    ['F(0K): $c_{opt}$(full) = ' num2str(optC_full_f0) '$\AA$'], ...
    ['QME: $c_{opt}$(nst) = ' num2str(optC_nst_qme) '$\AA$'], ...
    ['QME: $c_{opt}$(full) = ' num2str(optC_full_qme) '$\AA$'] ...
);
set(h, 'interpreter', 'latex');
set(h, 'fontsize', 15);
h = xlabel('Lattice constant c/ $\AA$');
set(h,'interpreter','latex');
h = ylabel('Energy/ $eV$ per atom');
set(h,'interpreter','latex');
