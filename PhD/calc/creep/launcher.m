function launcher

clear all

Alpha=[0 90 47 -47];
H_m = [0.3 0.3 0.2 0.2];

E1 = 126.0;
E2 = 11;
G12 = 6.6;
nu12 = 0.28;

thr = 20;
dg = 2;

Sigma = [0  10  20  30  40  50  60  70  80  90 100 110 120 130 140 150 160 170 180 190 200 210 220 230 240 250 260 270 280 290 300 310 320 330 340 350 360 370 380 390 400;
         0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0;
         0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0];
[Eps] = nonlinear_deform(Alpha, H_m, E1, E2, G12, nu12, thr, dg, Sigma);

plot(Eps(1, :)*100, Sigma(1, :), 'k-', Eps(2, :)*100, Sigma(1, :), 'k-', [Eps(1, 1) Eps(1, size(Eps, 2))]*100, [Sigma(1, 1), Sigma(1, size(Sigma, 2))], 'r-', [Eps(2, 1) Eps(2, size(Eps, 2))]*100, [Sigma(1, 1), Sigma(1, size(Sigma, 2))], 'r-')
ylabel('\sigma_x, MPa')
xlabel('\epsilon_y, \epsilon_x, %')
grid on

dE1 = 1 - (Eps(1, 2) - Eps(1, 1)) / (Eps(1, size(Eps, 2)) - Eps(1, size(Eps, 2) - 1));
dE2 = 1 - (Eps(2, 2) - Eps(2, 1)) / (Eps(2, size(Eps, 2)) - Eps(2, size(Eps, 2) - 1));
fprintf ('dE1 = %6.2f%%\ndE2 = %6.2f%%\n', dE1*100, dE2*100);
