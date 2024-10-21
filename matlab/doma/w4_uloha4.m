clear
format short

% y(t) = a + bt

t = linspace(0, 4, 5);
f = [0, 0.5, 1, 4, 8];

b0 = t.^0;
b1 = t.^1;

% c0*(b0 * b0) + c1*(b1*b0) = (f*b0)
% c0*(b0 * b1) + c1*(b1*b1) = (f*b1)
A = [b0*b0' b1*b0'
     b0*b1' b1*b1'];
a = [f*b0'
     f*b1'];

c = A\a;
c0 = c(1);
c1 = c(2);

fp = c0*b0 + c1*b1;
rozdiel = f - fp;
nadruhu = rozdiel.^2;
suma = sum(nadruhu);
e = sqrt(suma);
chyba = e / 5;

plot(t, f, "-k", t, fp, "-r")
grid on
