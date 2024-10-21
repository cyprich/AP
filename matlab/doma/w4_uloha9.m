clear
format short

t = linspace(0, 7, 8);
f = [0, 0.2, 1, 3, 6, 11, 18, 25]

% treba najst vhodnu jednoparametricku regresnu funkciu
% vyskusam ze y(t) = c*t^n kde n = 0, 1, 2, 3, 4,...?

b0 = t.^0;
c0 = (f*b0')/(b0*b0');
fp0 = c0 * b0;
e0 = sqrt(sum((f - fp0).^2)) / length(f)

b1 = t.^1;
c1 = (f*b1')/(b1*b1');
fp1 = c1 * b1;
e1 = sqrt(sum((f - fp1).^2)) / length(f)

b2 = t.^2;
c2 = (f*b2')/(b2*b2');
fp2 = c2 * b2;
e2 = sqrt(sum((f - fp2).^2)) / length(f)

b3 = t.^3;
c3 = (f*b3')/(b3*b3');
fp3 = c3 * b3;
e3 = sqrt(sum((f - fp3).^2)) / length(f)

hold on
plot(t, f, "-", "DisplayName", "f", "LineWidth", 2.5)
plot(t, fp0, ":", "DisplayName", "fp0")
plot(t, fp1, "-.", "DisplayName", "fp1")
plot(t, fp2, "--", "DisplayName", "fp2")
plot(t, fp3, "-", "DisplayName", "fp3")
hold off
grid on
legend
