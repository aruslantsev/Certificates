function Eps = nonlinear_deform(Alpha, H_r, E1, E2, G12, nu12, thr, dg, Sigma)

syms x
nu21 = nu12 * E2 / E1;

Sig = Sigma / 1000;
thr = thr / 1000;

MM = length(Sig);
NN = length(H_r);

g11 = E1 / (1 - nu12 * nu21);
g12 = nu21 * E1 / (1 - nu12 * nu21);
g22 = E2 / (1 - nu12 * nu21);
g66 = G12;

G12_0 =  [g11 g12 0; g12 g22 0; 0 0 g66];
G0 = [0 0 0; 0 0 0; 0 0 1];
f = dg * heaviside(x - thr);
%f = 2.2 * exp(18 * (x - thr)) * heaviside(x - thr);
G0xy = zeros (3, 3);
G = zeros (3, 3);
C = cos(Alpha * pi / 180);
S = sin(Alpha * pi / 180);
for i = 1:1:NN
    T = [C(i)^2 S(i)^2 -2*C(i)*S(i); S(i)^2 C(i)^2 2*C(i)*S(i); S(i)*C(i) -S(i)*C(i) C(i)^2-S(i)^2];
    G0xy = G0xy + T * G12_0 * T' * H_r(i);
    G = G + T * G0 * T' * H_r(i);
end;

S0xy = inv(G0xy);
A = G0xy \ G;
[R, D] = eig (A);
syms t n
alpha = 1;
beta = 1;
tau = 10;
f = @(t) 172 / 15 * t * heaviside(t) * heaviside(15 - t) + 172 * heaviside(t - 15);
ea = @(t) t^alpha * sum(beta^n * t^(n*(1+alpha)) / gamma(1 + (n + 1) * (1 + alpha)), 0, 100000);
fullfun1 = @(t) 172 / 15 * t * heaviside(t) * heaviside(15 - t) + 172 * heaviside(t - 15) * (tau-t)^alpha * symsum(beta^n * (tau-t)^(n*(1+alpha)) / gamma(1 + (n + 1) * (1 + alpha)), 0, 100000);
D1 = integral(f, 0, tau);
eps =  R * diag([1 + D(1, 1) * k * e_a(mu - D(1, 1))  (1 / (1 - D(2, 2) * f)) (1 / (1 - D(3, 3) * f))]) * inv(R) * S0xy;


