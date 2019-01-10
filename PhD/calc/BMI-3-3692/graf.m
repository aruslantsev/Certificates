% function graf(E1, E2, G12, nu12, thr, dg)
E1 = 90;
E2 = 80;
G12 = 10; % 3.5 3.5 
nu12 = 0.04;
thr = 3; % 3 3
dg = 1.8;
set(0,'DefaultTextFontSize',15,'DefaultTextFontName','Helvetica');
set(0,'DefaultAxesFontSize',15,'DefaultAxesFontName','Helvetica');
pause on
O11(E1, E2, G12, nu12, thr, dg);
pause
O24(E1, E2, G12, nu12, thr, dg);
pause
O31(E1, E2, G12, nu12, thr, dg);
pause
O41(E1, E2, G12, nu12, thr, dg);
