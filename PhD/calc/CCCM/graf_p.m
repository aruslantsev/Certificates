% function graf(E1, E2, G12, nu12, thr, dg)
E1 = 2.0;
E2 = E1/1.07;
G12 = E1/10; 
nu12 = 0.3;
thr = 3; % 3 3
dg = 1;
set(0,'DefaultTextFontSize',15,'DefaultTextFontName','Helvetica');
set(0,'DefaultAxesFontSize',15,'DefaultAxesFontName','Helvetica');
pause on
p15(E1, E2, G12, nu12, thr, dg);
pause
p30(E1, E2, G12, nu12, thr, dg);
pause
p45(E1, E2, G12, nu12, thr, dg);
pause
p60(E1, E2, G12, nu12, thr, dg);
