clear
format short

t = linspace(0, 4, 5);  % = [0, 1, 2, 3, 4]
f = [0, 0.5, 1, 4, 8];

b1 = t;
c1 = (f * b1') / (b1 * b1');
fp1 = c1 * b1;
e1 = sqrt(sum((f - fp1).^2));
ch1 = e1 / 5;

b2 = t.^2;
c2 = (f * b2') / (b2 * b2');
fp2 = c2 * b2;
e2 = sqrt(sum((f - fp2).^2));
ch2 = e2 / 5;

b3 = t.^3;
c3 = (f * b3') / (b3 * b3');
fp3 = c3 * b3;
e3 = sqrt(sum((f - fp3).^2));
ch3 = e3 / 5;

bx = t.^2;
cx = (f * bx') / (bx * bx');
fpx = cx * bx;

plot(t, f, "-b", t, fp1, ":", t, fp2, ":", t, fp3, ":", t, fpx, "-r");
grid on;
