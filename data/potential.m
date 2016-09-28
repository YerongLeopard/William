

X6poten = @(para, rho)( ...
    para(1)/(para(2) - 6.)* ...
    (6 * exp(para(2).*(1 - rho)) - para(2)./(rho.^6)) ...
);


X6potenNB = @(para, rho)( ...
    para(1)/(para(2) - 6.)* ...
    (6 * exp(para(2).*(1 - rho))) ...
);

X6Spoten = @(para, rho)( ...
    para(1) /(para(2) - 6.)* ...
    (6./para(3)* exp((para(3) * para(2)).*(1 - rho)) - para(2)./(rho.^6)) ...
);

fitFUNC1 = @(para, rho)(para(1)* exp(para(2).*rho +para(3))); % A exp (x R + B)


rr = 3.2:0.01: 6;
rrf = 3.2:2: 6;




rho = rr./3.7727;
rhof = rrf/3.7727;
beta0 = [0.0661 , 16.0944];

beta_ = [14.5646  -16.0944   10.1790];
yNB = X6potenNB(beta0, rhof);

opts = statset('MaxIter',9000);
betaf = nlinfit(rhof, yNB, fitFUNC1, beta_, opts);
disp(betaf);



y = X6poten(beta0, rho);
yNB = X6potenNB(beta0, rho);
rhos = rr./3.7750;
beta1 = [0.0623 , 16.0944 , 1.1];

ys = X6Spoten(beta1, rhos);
% kappa = 6*beta1(2)*(beta1(2)*beta1(3)- 7.)/ (beta1(2)-6.);



%vpasolve(4*x^4 + 3*x^3 + 2*x^2 + x + 5 == 0, x)
figure; hold on;
plotX6 = plot(rr, y, 'r.');
% plotX6S= plot(rr, ys, 'b.');
plotX6NB= plot(rr, yNB, 'b.');
yNB = fitFUNC1(betaf, rho);
 plot(rr, yNB, 'g--');


plot(xlim, [-0.0661 -0.0661], 'k-');
plot(xlim, [-0.0623 -0.0623], 'k-');

plot([3.7750 3.7750], ylim, 'k-');
plot([3.7727 3.7727], ylim, 'k-');
h = legend([plotX6, plotX6NB], 'X6', 'X6NB');

% value = X6Spoten(beta1, 1)

%axis([3 6 -0.1 0.1]);

% 102.4 * 10.0944/6/16.0944+7)/16.0944
% syms x;
% eqn = 87.0 == 6*x*(x-7)/(x-6)
% solx = vpasolve(eqn, x);
% disp(solx)
