% function graf(E1, E2, G12, nu12, thr, dg)
E1 = 150;
E2 = 4.0;
G12 = 3.3; % 3.5 3.5 
nu12 = 0.316;
thr = 3; % 3 3
dg = 2;
set(0,'DefaultTextFontSize',15,'DefaultTextFontName','Helvetica');
set(0,'DefaultAxesFontSize',15,'DefaultAxesFontName','Helvetica');
pause on
res = 0;
fprintf('OBR 0\n')
PM00_OBR1(E1, E2, G12, nu12, thr, dg);
pause

fprintf('OBR +/-20\n')
res = res + PM20_OBR7(E1, E2, G12, nu12, thr, dg);
pause

fprintf('OBR +/-40\n')
res = res + PM40_OBR13(E1, E2, G12, nu12, thr, dg);
pause

fprintf('OBR +/-50\n')
res = res + PM50_OBR16(E1, E2, G12, nu12, thr, dg);
pause

fprintf('OBR +/-70\n')
res = res + PM70_OBR10(E1, E2, G12, nu12, thr, dg);
pause

fprintf('OBR 90\n')
res = res + PM90_OBR4(E1, E2, G12, nu12, thr, dg);
