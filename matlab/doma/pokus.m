% linearna regresia, polynomicka regresia a mocninova regresia

clear
format short
close all

t = [0 1 2 3 4];
f = [0 0.5 3 9 19];

plot(t, f, "-k", LineWidth=1.5)
grid on
hold on


% kvadraticka
% ------------------- y(t) = c * t^2 -----------------------
b = t.^2;
c = (f*b') / (b*b');
fp = c*b;
e1 = sqrt(sum((f - fp).^2))

%plot(t, fp, "-r")


% kubicka
% ------------------- y(t) = c * t^3 -----------------------
b = t.^3;
c = (f*b') / (b*b');
fp = c*b;
e2 = sqrt(sum((f - fp).^2))

%plot(t, fp, "-b")


% kubicka + konstanta
% ------------------- y(t) = a + c * t^3 -----------------------
b0 = t.^0;
b1 = t.^3;

B = [ b0
      b1 ];

A = [ b0*b0' b1*b0'
      b0*b1' b1*b1' ];

a = [ f*b0'
      f*b1' ];

c = A\a;

fp = c'*B;
e3 = sqrt(sum((f - fp).^2))

%plot(t, fp, "-g")



% kubicka + t^1
% ------------------- y(t) = a + c * t^3 -----------------------
% presnejsie ako samotna predchadzajuca, a uz ide on nuly
b0 = t.^1;
b1 = t.^3;

B = [ b0
      b1 ];

A = [ b0*b0' b1*b0'
      b0*b1' b1*b1' ];

a = [ f*b0'
      f*b1' ];

c = A\a;

fp = c'*B;
e4 = sqrt(sum((f - fp).^2))

%plot(t, fp, "-m")


%{
mocninova regresia
--------------------- y(t) = a * t^b -------------------------

y(t) = a * t^b
lny(t) = ln(a * t^b)
lny(t) = lna + b * ln(t)
lny(t) = c0 + c1 * lnt

c0 = lna
c1 = b

nieco mam zle a nevyzera to tak jak by malo
%}


% vyhodime nulu z dat lebo ln(0) = -inf
tln = t(2:5);
fln = f(2:5);
fln = log(fln);

b0 = tln.^0;
b1 = log(tln);  % v matlabe log() = ln
B = [b0; b1];

A = [b0*b0' b1*b0' ; b0*b1' b1*b1'];
a = [fln*b0' ; fln*b1'];

% c0 = lna; c1 = b  ->  musime prepocitat c(1)
c = A\a;
c(1) = exp(c(1));


fp = c'*B;
plot(tln, fp, "-b")


hold off
