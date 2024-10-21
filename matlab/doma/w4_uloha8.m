clear 
format short

% y(t) = a + bt + ct^2 + ct^3 + ct^4

t = linspace(0, 4, 5);
f = [0, 0.5, 1, 4, 8];

b0 = t.^0;
b1 = t.^1;
b2 = t.^2;
b3 = t.^3;
b4 = t.^4;

A = [b0*b0' b1*b0' b2*b0' b3*b0' b4*b0'
    b0*b1' b1*b1' b2*b1' b3*b1' b4*b1'
    b0*b2' b1*b2' b2*b2' b3*b2' b4*b2'
    b0*b3' b1*b3' b2*b3' b3*b3' b4*b3'
    b0*b4' b1*b4' b2*b4' b3*b4' b4*b4'];

a = [f*b0' 
    f*b1' 
    f*b2'
    f*b3'
    f*b4'];

c = A\a;
c0 = c(1);
c1 = c(2);
c2 = c(3);
c3 = c(4);
c4 = c(5);

fp = c0*b0 + c1*b1 + c2*b2 + c3*b3 + c4*b4;
rozdiel = f - fp;
nadruhu = rozdiel.^2;
suma = sum(nadruhu);
e = sqrt(suma);
chyba = e / 5;

plot(t, f, "-", t, fp, "-")
grid on
