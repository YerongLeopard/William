

X6poten = @(para, rho)( ...
    para(1)/(para(2) - 6.)* ...
    (6 * exp(para(2).*(1 - rho)) - para(2)./(rho.^6)) ...
);

% para = 0.1383 3.7934 13.1999
repX6poten = @(para, rho)( ...
    para(1)/(para(2) - 6.)* ...
    (6 * exp(para(2).*(1 - rho))) ...
);

X6Spoten = @(para, rho)( ...
    para(1) /(para(2) - 6.)* ...
    (6./para(3)* exp((para(3) * para(2)).*(1 - rho)) - para(2)./(rho.^6)) ...
);

atrX6poten = @(para, rho)( ...
     - para(1)/(para(2)-6)*para(2)./(rho.^6) ...
);

atrFUN= @(para, rr)( ...
    -para(1)./(rr.^6 + para(2)^6));

repFUNC1 = @(para, r)(para(1)* exp(para(2).*r + para(3))); % A exp (x R) Note this function uses r rather than \rho
%  Note this function uses r rather than \rho
repFUNC2=  @(para, r)((para(1)* exp(para(2).*r + para(3))) .* (-para(4) .* (r.^para(5)) + para(6).* r) .* para(7)) ; 

rr = 3.2:0.01: 6;
rrf = 3.2:0.001: 6;



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

plotX6 = plot(rr, yy, 'r.');
ya = atrX6poten(beta0, rho); %DEBUG
plot(rr, ya, 'r-'); % DEBUG


% plotX6S= plot(rr, ys, 'b.');
repy = repX6poten(beta0, rho);
plot_repX6= plot(rr, repy, 'r*');


%%% fitting
rhof = rrf/3.7934;
beta_ = [6.3321 -0.9895, 0.0];
repy = repX6poten(beta0, rhof);

opts = statset('MaxIter',90000);

betaf = nlinfit(rrf, repy, repFUNC1, beta_, opts);
% betaf = [0 0 0] % DEBUG
disp(betaf);


%%% potential VOP


yy = atrFUN([684.95, 3.85], rr); % DEBUG

% value1 = X6poten((beta0), 1) % the lowest energy for X6 potential
% value2 = standardLGpart([1601.1619, 3.85], 3.7934) % attractive energy for standard LG part
repy = repFUNC1(betaf, rr);
plot_fit = plot(rr, repy, 'g.-');
test1 = plot(rr, yy, 'r-.'); % DEBUG


yy = atrFUN([998.8719, 3.85], rr); % DEBUG
plot_repEXP2 = plot(rr, yy, 'b--'); % DEBUG
% test = standardLGpart([684.95, 3.85], 3.5)

plot(xlim, [0 0], 'k --');
% plot(xlim, [value1 value1], 'k--');
% plot(xlim, [value2 value2], 'k--');

plot([3.7934 3.7934], ylim, 'k--');


%%% potential VOPfull
full_para = [40.6220 -3.8638  8.6854 -0.3018   0.7171  -0.4959 1];
ry = repFUNC2([40.6220 -3.8638  8.6854 -0.3018   0.7171  -0.4959 1], rr);
plot_repEXP2 = plot(rr ,ry, 'b*');



ay = atrFUN([998.8719 3.85], rr); 
plot_atrEXP2 = plot(rr, ay, 'b-');

yy = ay + ry;
plot_EXP2 = plot(rr, yy, 'b--');

repFUNC2([40.6220 -3.8638  8.6854 -0.3018   0.7171  -0.4959 1], 0.1)

h = legend([plotX6,...
    plot_repX6, ...
    plot_fit, ...
    test1, ...
    plot_atrEXP2], ...
    'X6', ...
    'X6 repulsive part ', ...
    '$$Z\exp(Ar)$$', ...
    'LG part:original $$C_6$$', ...
    'LG part:full fitting');


set(h,'interpreter','latex');
set(h, 'fontsize', 20);

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
