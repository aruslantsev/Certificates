% function graf(E1, E2, G12, nu12, thr, dg)
E1 = 2.6;
E2 = E1/1.07;
G12 = E1/5.5; 
nu12 = 0.2;
thr = 3; % 3 3
dg = 1;
set(0,'DefaultTextFontSize',15,'DefaultTextFontName','Helvetica');
set(0,'DefaultAxesFontSize',15,'DefaultAxesFontName','Helvetica');
comb1(E1, E2, G12, nu12, thr, dg);
