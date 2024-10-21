clear 
format short

% y(t) = a + bt + ct^2

t = linspace(0, 4, 5);
f = [0, 0.5, 1, 4, 8];

b0 = t.^0;
b1 = t.^1;
b2 = t.^2;

A = [b0*b0' b1*b0' b2*b0'
    b0*b1' b1*b1' b2*b1'
    b0*b2' b1*b2' b2*b2'];

a = [f*b0' 
    f*b1' 
    f*b2'];

c = A\a;
c0 = c(1);
c1 = c(2);
c2 = c(3);

fp = c0*b0 + c1*b1 + c2*b2;
rozdiel = f - fp;
nadruhu = rozdiel.^2;
suma = sum(nadruhu);
e = sqrt(suma);
chyba = e / 5;

plot(t, f, "-", t, fp, "-")
grid on
