

X6poten = @(para, rho)( ...
    para(1)/(para(2) - 6.)* ...
    (6 * exp(para(2).*(1 - rho)) - para(2)./(rho.^6)) ...
);

% para = 0.1383 3.7934 13.1999
repX6poten = @(para, rho)( ...
    para(1)/(para(2) - 6.)* ...
    (6 * exp(para(2).*(1 - rho))) ...
);

atrX6poten = @(para, rho)( ...
     - para(1)/(para(2)-6)*para(2)./(rho.^6) ...
);

X6Spoten = @(para, rho)( ...
    para(1) /(para(2) - 6.)* ...
    (6./para(3)* exp((para(3) * para(2)).*(1 - rho)) - para(2)./(rho.^6)) ...
);



atrFUN= @(para, rr)( ...
    -para(1)./(rr.^6 + para(2)^6));

repFUNC1 = @(para, r)(para(1)* exp(para(2).*r + para(3))); % A exp (x R) Note this function uses r rather than \rho
%  Note this function uses r rather than \rho
repFUNC=  @(para, r)((para(1)* exp(para(2)*r + para(3))) .* exp(-para(4) * (r.^para(5)) + para(6)* r) * para(7)); 
% test2=  @(para, r)((para(1)*exp(para(2)*r + para(3))).* ( (-para(4) * (r.^para(5)) + para(6)* r) * para(7)); % DEBUG
rr = 3.2:0.001: 6;
rrf = 3.2:0.01: 6;



% disp('finished');
rho = rr./3.7934;





rhos = rr./3.7750;
beta1 = [0.0623 , 16.0944 , 1.1];

ys = X6Spoten(beta1, rhos);
% kappa = 6*beta1(2)*(beta1(2)*beta1(3)- 7.)/ (beta1(2)-6.);



%vpasolve(4*x^4 + 3*x^3 + 2*x^2 + x + 5 == 0, x)
figure; hold on;

%%% potential X6
beta0 = [0.1383 , 13.1999];
yy = X6poten(beta0, rho);
plotX6 = plot(rr, yy, 'r--');


ya = atrX6poten(beta0, rho); 
plot_atrX6 = plot(rr, ya, 'r-'); %

ry = repX6poten(beta0, rho);
plot_repX6= plot(rr, ry, 'r*');

plot(xlim, [0 0], 'k-.');
plot([3.7934 3.7934], ylim, 'r-.');
plot(xlim, [X6poten(beta0, 1) X6poten(beta0, 1)], 'r-.');
plot(xlim, [atrX6poten(beta0, 1) atrX6poten(beta0, 1)], 'r-.');

h = legend([plotX6,...
    plot_repX6, ...
    plot_atrX6], ...
    'X6', ...
    'repulsive part: X6 ', ...
    'LG part: X6 ' ...
);


set(h,'interpreter','latex');
set(h, 'fontsize', 15);

h = xlabel('layer distance/ $\AA$');
set(h,'interpreter','latex');
set(h, 'fontsize', 20);
set(h, 'fontweight', 'bold');

h = ylabel('Energy difference/ $kcal/ mol$');
set(h,'interpreter','latex');
set(h, 'fontsize', 20);
set(h, 'fontweight', 'bold');


% %%% fitting
% rhof = rrf/3.7934;
% beta_ = [6.3321 -0.9895, 0.0];
% ry = repX6poten(beta0, rhof);
% 
% opts = statset('MaxIter',90000);
% 
% betaf = nlinfit(rrf, ry, repFUNC1, beta_, opts);
% yy = repFUNC1(betaf, rr);
% test1 = plot(rr, yy, 'g-.'); % DEBUG



%%% potential VOP single
figure; hold on;
rr2 = 0.5: 0.01: 6;
single_para = [31.5659  -4.0699  8.6854 0 0 0 1];

ry = repFUNC(single_para, rr);
plot_repEXP1 = plot(rr ,ry, 'k*');



ay = atrFUN([1011.5138 3.85], rr); 
plot_atrEXP1 = plot(rr, ay, 'k-');

yy = ay + ry;
plot_EXP1 = plot(rr, yy, 'k--');

plot(xlim, [0 0], 'k-.');
plot([3.7934 3.7934], ylim, 'r-.');

h = legend([plot_EXP1, ...
    plot_repEXP1, ...
    plot_atrEXP1], ...
    'fitted EXP1', ...
    'repulsive part: fitted full EXP2', ...
    'LG part: fitted EXP1' ...
    );


set(h,'interpreter','latex');
set(h, 'fontsize', 15);


h = xlabel('layer distance/ $\AA$');
set(h,'interpreter','latex');
set(h, 'fontsize', 20);
set(h, 'fontweight', 'bold');

h = ylabel('Energy difference/ $kcal/ mol$');
set(h,'interpreter','latex');
set(h, 'fontsize', 20);
set(h, 'fontweight', 'bold');

%%% potential VOPfull
figure; hold on;

rr2 = 0.5: 0.01: 6;
full_para = [40.6220 -3.8638  8.6854 -0.3018   0.7171  -0.4959 1];
ry = repFUNC(full_para, rr);
plot_repEXP2 = plot(rr ,ry, 'b*');



ay = atrFUN([998.8719 3.85], rr); 
plot_atrEXP2 = plot(rr, ay, 'b-');

yy = ay + ry;
plot_EXP2 = plot(rr, yy, 'b--');
plot(xlim, [0 0], 'k-.');
plot([3.7934 3.7934], ylim, 'r-.');
h = legend([plot_EXP2, ...
    plot_repEXP2, ...
    plot_atrEXP2], ...
    'fitted full EXP2', ...
    'repulsive part: fitted full EXP2', ...
    'LG part: full fitted EXP2');


set(h,'interpreter','latex');
set(h, 'fontsize', 15);

%%% horizontal and vertical lines



% h = legend([plotX6,...
%     plot_repX6, ...
%     plot_atrX6, ...
%     test1, ...
%     plot_EXP1, ...
%     plot_repEXP1, ...
%     plot_atrEXP1, ...    
%     plot_EXP2, ...
%     plot_repEXP2, ...
%     plot_atrEXP2], ...
%     'X6', ...
%     'repulsive part: X6 ', ...
%     'LG part: X6 ', ...
%     'LG part: original $$C_6$$ from $$H_2O$$ , initialization', ...
%     'fitted EXP1', ...
%     'repulsive part: fitted full EXP2', ...
%     'LG part: fitted EXP1', ...
%     'fitted full EXP2', ...
%     'repulsive part: fitted full EXP2', ...
%     'LG part: full fitted EXP2');
% 
% 
% set(h,'interpreter','latex');
% set(h, 'fontsize', 15);

h = xlabel('layer distance/ $\AA$');
set(h,'interpreter','latex');
set(h, 'fontsize', 20);
set(h, 'fontweight', 'bold');

h = ylabel('Energy difference/ $kcal/ mol$');
set(h,'interpreter','latex');
set(h, 'fontsize', 20);
set(h, 'fontweight', 'bold');

%axis([3 6 -0.1 0.1]);

% 102.4 * 10.0944/6/16.0944+7)/16.0944
% syms x;
% eqn = 87.0 == 6*x*(x-7)/(x-6)
% solx = vpasolve(eqn, x);
% disp(solx)
