close all
% t = linspace(1, 10, 10);
% f = [25 18 15 12 10 8 6 4 2 1];
t = linspace(1, 4, 4);
f = [25 18 15 12];

grid on;
hold on;
plot(t, f, "-")

b0 = t.^0;
b1 = t.^1;
b2 = t.^2;
B = [b0; b1; b2];

A = [b0*b0' b1*b0' b2*b0'
    b0*b1' b1*b1' b2*b1'
    b0*b2' b1*b2' b2*b2'];
a = [f*b0'; f*b1'; f*b2';];

c = A\a;
fp = c'*B;

plot(t, fp, "-")

% tt = linspace(1, 10, 5000);
tt = linspace(1, 4, 5000);
BB = [tt.^0; tt.^1; tt.^2];
ffp = c'*BB;
plot(tt, ffp, "-")
