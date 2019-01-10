function [Eps] = nonlinear_deform(Alpha, H_r, E1, E2, G12, nu12, thr, dg, Sigma)

syms x
nu21 = nu12 * E2 / E1;

%Sig = Sigma / 1000;
Sig = Sigma;
%thr = thr / 1000;

MM = size(Sig, 2);
NN = length(H_r);

g11 = E1 / (1 - nu12 * nu21);
g12 = nu21 * E1 / (1 - nu12 * nu21);
g22 = E2 / (1 - nu12 * nu21);
g66 = G12;

G12_0 =  [g11 g12 0; g12 g22 0; 0 0 g66];
G0 = [1 0 0; 0 1 0; 0 0 0.2];
if (dg == 0)
    f = 0*1.8 * heaviside(x - thr);
end
if (dg == 1)
    thr = 0.05;
    f = heaviside(x - thr) * (1.3*(x - thr))^0.7; 
end

G0xy = zeros (3, 3);
G = zeros (3, 3);
C = cos(Alpha * pi / 180);
S = sin(Alpha * pi / 180);
for i = 1:1:NN
    T = [C(i)^2 S(i)^2 -2*C(i)*S(i); S(i)^2 C(i)^2 2*C(i)*S(i); S(i)*C(i) -S(i)*C(i) C(i)^2-S(i)^2];
    G0xy = G0xy + T * G12_0 * T' * H_r(i);
    G = G + T * G0 * T' * H_r(i);
end

S0xy = inv(G0xy);
A = G0xy \ G;
[R, D] = eig (A);
S_xy = R * diag([(1 / (1 - D(1, 1) * f)) (1 / (1 - D(2, 2) * f)) (1 / (1 - D(3, 3) * f))]) * inv(R) * S0xy;

% Layer with max shear stress
n = 0;
a = 45;
for i = Alpha
  if i ~= 0
    if (abs(abs(i) - 45) < a)
	 a = abs(abs(i) - 45);
	 n = i;
    end
  end
end
for j=1:1:MM
    C1 = cos(n * pi / 180);
    S1 = sin(n * pi / 180);
    T1 = [C1^2 S1^2 -2*C1*S1; S1^2 C1^2 2*C1*S1; S1*C1 -S1*C1 C1^2-S1^2];
    s = inv(T1) * (T1 * G12_0 * inv(T1) * inv(G0xy) * Sig(:,j)); % Stress in layer
    s_t(j) = sqrt(s(1)^2 + s(2)^2 + s(3)^2 + 0.5*abs(s(1)*s(2)) + 2*abs(s(2)*s(3)) + 2*abs(s(3)*s(1))); % ~Shear stress :)
end
s_t(MM)

Eps = zeros(3, length(Sig));
for i=2:1:MM
    Eps(:, i) = Eps(:, i - 1) + subs(S_xy, x, s_t(i)) * (Sig(:, i) - Sig(:, i - 1));
end
