Alpha = [0 90 45 -45]
H_r = [0.25 0.25 0.25 0.25]


E1 = 126;
E2 = 11;
G12 = 6.6;
nu12 = 0.28;
nu21 = nu12 * E2 / E1;

g11 = E1 / (1 - nu12 * nu21);
g12 = nu21 * E1 / (1 - nu12 * nu21);
g22 = E2 / (1 - nu12 * nu21);
g66 = G12;

G12_0 =  [g11 g12 0; g12 g22 0; 0 0 g66];
G0 = [0 0 0; 0 0 0; 0 0 1/2];


G0xy = zeros (3, 3);
G = zeros (3, 3);
C = cos(Alpha * pi / 180);
S = sin(Alpha * pi / 180);
for i = 1:1:length(Alpha)
    T = [C(i)^2 S(i)^2 -2*C(i)*S(i); S(i)^2 C(i)^2 2*C(i)*S(i); S(i)*C(i) -S(i)*C(i) C(i)^2-S(i)^2];
    G0xy = G0xy + T * G12_0 * T' * H_r(i);
    G = G + T * G0 * T' * H_r(i);
end;
Gxx = G0xy(1, 1)
Gxxf = G(1, 1)
G0xy
G
A=inv(G0xy)*G;
[R,D]=eig(A)
inv(R)
inv(G0xy)