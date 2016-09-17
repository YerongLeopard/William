X6poten = @(para, rho)( ...
    para(1)/(para(2) - 6.)* ...
    (6 * exp(para(2).*(1 - rho)) - para(2)./(rho.^6)) ...
);
X6Spoten = @(para, rho)( ...
    para(1) /(para(2) - 6.)* ...
    (6./rho .* exp((para(3) * para(2)).*(1 - rho)) - para(2)./(rho.^6)) ...
);
rr = 3.2:0.01: 6;
rho = rr./3.7727;
beta0 = [0.0661 , 16.0944];
y = X6poten(beta0, rho);

rho = rr./3.7750;
beta1 = [0.0623 , 16.0944 , 1.1];

ys = X6Spoten(beta1, rho);
kappa = 6*beta1(2)*(beta1(2)*beta1(3)- 7.)/ (beta1(2)-6.)
figure; hold on;
plotX6 = plot(rr, y, 'r.');
plotX6S= plot(rr, ys, 'b.');
h = legend([plotX6, plotX6S], 'X6', 'X6S');
axis([3 6 -0.1 0.1]);

(102.4 * 10.0944/6/16.0944+7)/16.0944

% syms x;
% eqn = 87.0 == 6*x*(x-7)/(x-6)
% solx = vpasolve(eqn, x);
% disp(solx)
