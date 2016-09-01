disp ('12');
A = 2.4664372489959372;
% surrounding = 7:13;
surrounding = 3:17;
%%%%%%%%%%%%%%%%%%%%%%%%%
DATA12 = xlsread('data.xlsx','data12');
dim = size(DATA12);

idx = find(DATA12(:,5));

LatticeC = DATA12(:,1);  Volume = LatticeC*A*A*sqrt(3)/8;
Ener_Corr0 = DATA12(:, 5)
Ener_Corr300 = DATA12(:, 6);

modelFUNC = @(para, V)(para(1) + para(2) * V);


figure; hold on;
title('Helmholtz free energy Correction' )
plot(Volume(idx), Ener_Corr0(idx), 'b*');
beta0 = [0. 0.];
beta = nlinfit(Volume(idx), Ener_Corr0(idx), modelFUNC, beta0);
xxvol = 7.:.5:10.5;
fit0 = plot(xxvol, modelFUNC(beta, xxvol), 'r-');
SLOPE0 = beta(2)

%%%%%%%%%%%%%%%%% 300K %%%%%%%%%%%%%%%%%%

plot(Volume(idx), Ener_Corr300(idx), 'b*');
beta0 = [0. 0.];
beta = nlinfit(Volume(idx), Ener_Corr300(idx), modelFUNC, beta0);
fit300 = plot(xxvol, modelFUNC(beta, xxvol), 'g-');

SLOPE300 = beta(2)

h = legend([fit0, fit300] ,['SLOPE(0K): ' num2str(SLOPE0) ' Gpa/ $\AA^3$'], ['SLOPE(300K): ' num2str(SLOPE300) ' Gpa/ $\AA^3$']);
set(h, 'interpreter', 'latex');
set(h, 'fontsize', 15);
h = xlabel('Volume/ $\AA^3$');
set(h,'interpreter','latex');
h = ylabel('Energy/ $eV$ per atom');
set(h,'interpreter','latex');