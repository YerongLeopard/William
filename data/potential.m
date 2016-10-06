

X6poten = @(para, rho)( ...
    para(1)/(para(2) - 6.)* ...
    (6 * exp(para(2).*(1 - rho)) - para(2)./(rho.^6)) ...
);

% para = 0.1383 3.7934 13.1999
X6potenNB = @(para, rho)( ...
    para(1)/(para(2) - 6.)* ...
    (6 * exp(para(2).*(1 - rho))) ...
);

X6Spoten = @(para, rho)( ...
    para(1) /(para(2) - 6.)* ...
    (6./para(3)* exp((para(3) * para(2)).*(1 - rho)) - para(2)./(rho.^6)) ...
);

X6potenLG = @(para, rho)( ...
     - para(1)/(para(2)-6)*para(2)./(rho.^6) ...
);

standardLGpart = @(para, rr)( ...
    -para(1)./(rr.^6 + para(2)^6));

fitFUNC1 = @(para, r)(para(1)* exp(para(2).*r)); % A exp (x R) Note this function uses r rather than \rho


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
y = X6poten(beta0, rho);
yNB = X6potenNB(beta0, rho);
plotX6 = plot(rr, y, 'r.');
y1 = X6potenLG(beta0, rho); %DEBUG
plot(rr, y1, 'k-.'); % DEBUG


% plotX6S= plot(rr, ys, 'b.');
plotX6NB= plot(rr, yNB, 'b*');


%%% fitting
rhof = rrf/3.7934;
beta_ = [2.3321 -0.9895];
yNB = X6potenNB(beta0, rhof);

opts = statset('MaxIter',90000);

betaf = nlinfit(rrf, yNB, fitFUNC1, beta_, opts);
% betaf = [0 0 0] % DEBUG
disp(betaf);


%%% potential VOP


y2 = standardLGpart([684.95, 3.85], rr); % DEBUG

value1 = X6poten((beta0), 1) % the lowest energy for X6 potential
value2 = standardLGpart([1601.1619, 3.85], 3.7934) % attractive energy for standard LG part
yNB = fitFUNC1(betaf, rr);
plot_fit = plot(rr, yNB, 'g.-');
test1 = plot(rr, y2, 'r-.'); % DEBUG


y2 = standardLGpart([1601.1619, 3.85], rr); % DEBUG
test2 = plot(rr, y2, 'r--'); % DEBUG
% test = standardLGpart([684.95, 3.85], 3.5)

plot(xlim, [0 0], 'k --');
plot(xlim, [value1 value1], 'k--');
plot(xlim, [value2 value2], 'k--');

plot([3.7934 3.7934], ylim, 'k--');


h = legend([plotX6,...
    plotX6NB, ...
    plot_fit, ...
    test1, ...
    test2], ...
    'X6', ...
    'X6NB', ...
    '$$Z\exp(Ar)$$', ...
    'LG part:original $$C_6$$', ...
    'LG part:optimizd $$C_6$$');
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
