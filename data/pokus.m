% nacitanie dat zo suboru
import = readmatrix("matlabized_data.csv");
t = import(:, 1);
f = import(:, 2);
% transponovanie vektorov pre pohodlnejsie narabanie s nimi
t = t';
f = f';

plot(t, f, '-');
hold on;

b1 = t.^0;
b2 = t.^1;
b3 = t.^2;
b4 = t.^3;

B = [b1
    b2
    b3
    b4];

A = B * B';
a = f * B';

c = (a) * (A)^(-1);

fp = c*B;


plot(t, fp, '-')