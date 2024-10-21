% V časoch 0, 1, 3, 4 nadobudol proces f hodnoty 7, 3, 5, 7. 
% Zistite, ktorá z nasledujúcich funkcií (modelov) najlepšie vyjadruje priebeh procesu 
% a aká bude približná hodnota procesu v časoch 2 a 5. 

% y(t)1 = c
% y(t)2 = c*t
% y(t)3 = c * t^2
% y(t)4 = c0 + c1*t
% y(t)5 = c0*t + c1*t^2
% y(t)6 = c0 + c1*e^t


t = [0, 1, 3, 4];
f = [7, 3, 5, 7];

plot(t, f, "-k", LineWidth=2)
hold on


b1 = t.^0;
c1 = (f*b1') / (b1*b1');
fp1 = c1 * b1;
% plot(t, fp1, ":")


b2 = t.^1;
c2 = (f*b2') / (b2*b2');
fp2 = c2 * b2;
% plot(t, fp2, "-.")


b3 = t.^2;
c3 = (f*b3') / (b3 * b3');
fp3 = c3 * b3;
% plot(t, fp3, "--")


b41 = t.^0;
b42 = t.^1;
A4 = [(b41 * b41') (b42 * b41')
    (b41 * b42') (b42 * b42')];
a4 = [(f * b41')
    (f * b42')];
c4 = A4\a4;
fp4 = c4(1) * b41 + c4(2) * b42;
plot(t, fp4, "-")


b51 = t.^1;
b52 = t.^2;
A5 = [(b51 * b51') (b52 * b51')
    (b51 * b52') (b52 * b52')];
a5 = [(f * b51')
    (f * b52')];
c5 = A5\a5;
fp5 = c5(1) * b51 + c5(2) * b52;
plot(t, fp5, "--")


% y(t)6 = c0 + c1*e^t
% ???
