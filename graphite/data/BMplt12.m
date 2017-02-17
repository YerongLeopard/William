disp ('12');
A = 2.4664372489959372;
% surrounding = 5:14;
 surrounding = 3:17;
%%%%%%%%%%%%%%%%%%%%%%%%%
DATA12 = xlsread('data.xlsx','data12');
dim = size(DATA12);

idx = find(DATA12(:,5));
idx_nst = intersect(surrounding, idx);
P_idx = find(DATA12(:,4));
P_idx_nst = intersect(surrounding, idx);

LatticeC = DATA12(:,1); Volume = LatticeC.*A*A*sqrt(3)/8;
QME = DATA12(:,2);
F0 = DATA12(:, 3);
Pressure = DATA12(:, 4);
%% model function


BMfitF = @(FBV, V)( ...
    FBV(1)+ ...
    9./16.* FBV(2)*FBV(4)* (... 
            ((FBV(4)./V).^(2./3.)-1).^3. * FBV(3) + ...
            ((FBV(4)./V).^(2./3.)-1).^2. .*(6- 4*(FBV(4)./V).^(2./3.)) ...
                           ) ...
    );

BMfitP = @(BV, V)( ...
    1.5*BV(1).* ...
    ((BV(3)./V).^(7./3.)- (BV(3)./V).^(5./3.)).* ...
    (1 + 0.75*(BV(2)-4).* ((BV(3)./V).^ (2./3.) - 1)) ...
);




%%%%%%%%%%%% ENERGY %%%%%%%%%%

figure; hold on;
title('Becke-Jonson damping : Energy');

plot(LatticeC, QME, 'b*');
plot(LatticeC(idx), F0(idx), 'r*');
%LatticeC
%QME

xx = 2.5:0.05:8.;
xxvol = xx*A*A*sqrt(3)/8;
beta0 = [-9.3062    0.2469   10.9828    9.0445 ];
opts = statset('MaxIter',9000);
%opts = statset('TolFun', 1e-100);

%%%
%%% whole fit
%%%
LatticeC = DATA12(:,1);
Volume = LatticeC.*A*A*sqrt(3)/8;
QME = DATA12(:,2);

beta = nlinfit(Volume, QME, BMfitF, beta0, opts);
optC_full_qme = beta(4)/A/A/sqrt(3)*8.;

disp(sprintf('Optimal Lattice Constant C (full QME) : %.4f', optC_full_qme));
% BMfitF(beta0, Volume);
% plot(xlim, [beta(1) beta(1)]);
% plot([optC optC], ylim);

fit_full_QME = plot(xx, BMfitF(beta, xxvol),'r--');

% LatticeC(idx)
% size(F0)
beta = nlinfit(Volume(idx), F0(idx), BMfitF, beta0, opts);
optC_full_f0 = beta(4)/A/A/sqrt(3)*8.;
disp(sprintf('Optimal Lattice Constant C (full F0): %.4f', optC_full_f0));

fit_full_F0 = plot(xxvol, BMfitF(beta, xxvol),'r-');


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

%plot([6.87, 6.87], ylim);
fit_nst_QME = plot(xx, BMfitF(beta, xx),'b--');
% size(F0(idx_nst))
% size(Volume(idx_nst))

beta = nlinfit(Volume(idx_nst), F0(idx_nst), BMfitF, beta0, opts);
optC_nst_f0 = beta(4)/A/A/sqrt(3)*8.;
disp(sprintf('Optimal Lattice Constant C (nst F0): %.4f', optC_nst_f0));

fit_nst_F0 = plot(xx, BMfitF(beta, xx),'b-');

plot(xlim, [beta(1) beta(1)],'k.-.', [optC_full_qme optC_full_qme], ylim , 'k.-.');
plot(xlim, [beta(1) beta(1)],'k.-.', [optC_full_f0 optC_full_f0], ylim , 'k.-.');
plot(xlim, [beta(1) beta(1)],'k.-.', [optC_nst_qme optC_nst_qme], ylim , 'k.-.');
plot(xlim, [beta(1) beta(1)],'k.-.', [optC_nst_f0 optC_nst_f0], ylim , 'k.-.');
% beta = nlinfit(Volume(idx), F0, BMfitF, beta0, opts);
% optC_nst = beta(4)/A/A/sqrt(3)*8.;
% disp(sprintf('Optimal Lattice Constant C (nst F0): %.4f', optC_nst));

h = legend([fit_nst_F0, fit_full_F0, fit_nst_QME, fit_full_QME], ...
    ['F(0K): $c_{opt}$(nst) = ' num2str(optC_nst_f0) '$\AA$'], ...
    ['F(0K): $c_{opt}$(full) = ' num2str(optC_full_f0) '$\AA$'], ...
    ['QME: $c_{opt}$(nst) = ' num2str(optC_nst_qme) '$\AA$'], ...
    ['QME: $c_{opt}$(full) = ' num2str(optC_full_qme) '$\AA$'] ...
);
% beta
set(h, 'interpreter', 'latex');
set(h, 'fontsize', 15);
h = xlabel('Lattice constant c/ $\AA$');
set(h,'interpreter','latex');
h = ylabel('Energy/ $eV$ per atom');
set(h,'interpreter','latex');


%%
%%     Pressure Plot
%%
%%
SLOPE =   -2.4481e-04;
% SLOPE = -2.7602e-04;
xx = 2.5:0.05:8.;
xxvol = xx*A*A*sqrt(3)/8;

figure; hold on;
title('Becke-Jonson damping : Pressure');

plot(Volume(P_idx), Pressure(P_idx), 'b*');


beta0 =[0.2125   12.8227    8.8689];

%% Full fit
beta_full = nlinfit(Volume(P_idx),Pressure(P_idx), BMfitP, beta0, opts);
fit_full_p = plot(xxvol, BMfitP(beta_full, xxvol),'r-');
syms x
%assume(x < 10);
eqn = BMfitP(beta_full, x) == -SLOPE;
%eqn = BMfitP(beta_nst, x) == 0.;
optV_full = vpasolve(eqn, x, 8.0);
optC_full_p = simplify(optV_full/A/A/sqrt(3)*8.); optC_full_p = double(optC_full_p);
disp(optC_full_p);


% disp(sprintf('Optimal Lattice Constant C (full): %.4f', optC_full_p));

%% Nearest fit
beta_nst = nlinfit(Volume(P_idx_nst),Pressure(P_idx_nst), BMfitP, beta0, opts);
fit_nst_p = plot(xxvol, BMfitP(beta, xxvol),'b-');
% optC_nst_p = beta(3)/A/A/sqrt(3)*8.;
% disp(sprintf('Optimal Lattice Constant C (Nearest): %.4f', optC_nst_p));

syms x
%assume(x < 10);
eqn = BMfitP(beta_nst, x) == -SLOPE;
%eqn = BMfitP(beta_nst, x) == 0.;
optV = vpasolve(eqn, x, 8.0);
optC_nst_p = simplify(optV/A/A/sqrt(3)*8.); optC_nst_p = double(optC_nst_p);
disp(optC_nst_p);
%round(solx,6)

% plot([optC_full_p optC_full_p], ylim, 'k.-.');
% plot([optC_nst_p optC_nst_p], ylim, 'k.-.');
SLP = plot(xlim, [-SLOPE -SLOPE], 'k.-.');

h = legend([fit_nst_p, fit_full_p, SLP], ...
    ['$c_{opt}$(nst) = ' num2str(optC_nst_p) '$\AA$'], ...
    [' $c_{opt}$(full) = ' num2str(optC_full_p) '$\AA$'], ...
    ['Slope=' num2str(-SLOPE) ' Gpa/ $\AA^3$' ] ...
);

set(h, 'interpreter', 'latex');
set(h, 'fontsize', 15);
h = xlabel('Lattice constant c/ $\AA$');
set(h,'interpreter','latex');
h = ylabel('Stess zz/ GPa');
set(h,'interpreter','latex');

