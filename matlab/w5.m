clear
format short

t = [0, 1, 2, 3, 4];
f = [8 4 2 1 0.5];

b0 = t.^0;
b1 = t.^1;
b2 = t.^2;

B = [ b0
    b1
    b2 ];

A = B*B';
a = f*B';
c = (f*B') * (B*B')^(-1);
% c = (7.8429   -4.0857    0.5714)

fp = c*B;

tt = linspace(0, 4, 10000);
% y = c*.tt

% plot(t, f, "-", t, fp, "-", tt, fp, "-")
% plot(t, f, "-", t, fp, "-")
grid on
hold on

% ----------------------- y = a * e^(bt) ----------------
% lny = lna + b*t 
% lny = c0 + c1*t

flin = log(f);  % zlinearizovane f

b0 = t.^0;
b1 = t.^1;

B = [b0
    b1];

A = B*B';
b = f*B';

c = (flin*B')*(B*B')^(-1);
% c = (2.0794   -0.6931)

% c0 = ln a  =>  a = e^c0

a = exp(c(1));
% b = c(2);

y = a*exp(c(2)*tt);
plot(t, f, "-", tt, y, "-")


hold off
