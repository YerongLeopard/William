DATA = dlmread('dta.txt',' ', 1, 0);

LatConstant_c = DATA(:,1);
volume = DATA(:,3);
pressure = DATA(:,4);
Gibbs = DATA(:,6);

figure;  %%%
plot(pressure,LatConstant_c)
xlabel('Pressure/$kB$','Interpreter','latex')
ylabel('Lattice Constant/$\AA$','Interpreter','latex')

figure;  %%%
plot(pressure,volume)
xlabel('Pressure/$kB$','Interpreter','latex')
ylabel('Volume/$cm^3$','Interpreter','latex')

figure;  %%%
plot(pressure,Gibbs)
xlabel('Pressure/$kB$','Interpreter','latex')
ylabel('Gibbs/$(J/mol)$','Interpreter','latex')
