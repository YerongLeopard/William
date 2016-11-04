DATA= xlsread('data.xlsx','shift');
ORG= xlsread('data.xlsx', 'CCmd');
LatticeC = DATA(:,1);
phn      = DATA(:,2);
X6       = DATA(:,3);
VopX     = DATA(:,4);
full     = DATA(:,5);

xx = 6.0: 0.01: 7.1; %intrapolation range
x_search = LatticeC(8):0.00001:LatticeC(5);

figure; hold on;


plot_phn    = plot(LatticeC,   phn, 'ko');
y_search =  spline(LatticeC, phn, x_search);
x_min_phn = x_search(find(y_search == min(y_search)))
plot_org    = plot(ORG(:,1), ORG(:,3), 'ks');

plot_X6    = plot(LatticeC,   X6, 'g*');
yy = spline(LatticeC, X6, xx); plot(xx, yy, 'g-');
y_search =  spline(LatticeC, X6, x_search);
x_min_X6 = x_search(find(y_search == min(y_search)))

plot_VopX    = plot(LatticeC,   VopX, 'b*');
yy = spline(LatticeC, VopX, xx); plot(xx, yy, 'b-');
y_search =  spline(LatticeC, VopX, x_search);
x_min_VopX = x_search(find(y_search == min(y_search)))

plot_full    = plot(LatticeC,   full, 'r*');
yy = spline(LatticeC, full, xx); plot(xx, yy, 'r-');
y_search =  spline(LatticeC, full, x_search);
x_min_full = x_search(find(y_search == min(y_search)))

axis([6.0 7.1 ylim]);
