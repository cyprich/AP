clear
close all;  % zavrie vsetky predchadzajuce figures

% nacitanie dat zo suboru
import = readmatrix("matlabized_data.csv");
t = import(:, 1);
f = import(:, 2);
% transponovanie vektorov pre pohodlnejsie narabanie s nimi
t = t';
f = f';

figure("Name", "Povodne data", "NumberTitle", "off")
plot(t, f, "-b")
grid on

% ------------------------------------------------------------------------

f_split = cell(1, 4);
t_split = cell(1, 4);

n = length(f) / 4;

for i = 1:4
    f_split{i} = f((i-1)*n+1 : i*n);
    t_split{i} = t((i-1)*n+1 : i*n);
end

figure("Name", "Rozsekane data spolu", "NumberTitle", "off")
hold on
for i = 1:4
    plot(t_split{1}, f_split{i}, "-")
end
grid on


figure("Name", "Rozsekane data normovane, spolu", "NumberTitle", "off")
hold on
for i = 1:4
    plot(t_split{1}, f_split{i} - mean(f_split{i}), "-")
end
grid on

% ------------------------------------------------------------------------
u0 = t_split{1}.^0;
u1 = t_split{1}.^1;
u2 = t_split{1}.^2;
u3 = t_split{1}.^3;
u4 = t_split{1}.^4;
u5 = t_split{1}.^5;

b0 = u0;

c = (u1 * b0') / (b0*b0');
b1 = u1 - c * b0;

c1 = (u2 * b0') / (b0*b0');
c2 = (u2 * b1') / (b1*b1');
b2 = u2 - (c1 * b0 + c2 * b1);

c1 = (u3 * b0') / (b0*b0');
c2 = (u3 * b1') / (b1*b1');
c3 = (u3 * b2') / (b2*b2');
b3 = u3 - (c1 * b0 + c2 * b1 + c3 * b2);

c1 = (u4 * b0') / (b0*b0');
c2 = (u4 * b1') / (b1*b1');
c3 = (u4 * b2') / (b2*b2');
c4 = (u4 * b3') / (b3*b3');
b4 = u4 - (c1 * b0 + c2 * b1 + c3 * b2 + c4 * b3);

c1 = (u5 * b0') / (b0*b0');
c2 = (u5 * b1') / (b1*b1');
c3 = (u5 * b2') / (b2*b2');
c4 = (u5 * b3') / (b3*b3');
c5 = (u5 * b4') / (b4*b4');
b5 = u5 - (c1 * b0 + c2 * b1 + c3 * b2 + c4 * b3 + c5 * b4);

c0 = (f_split{1}*b0') / (b0*b0');
c1 = (f_split{1}*b1') / (b1*b1');
c2 = (f_split{1}*b2') / (b2*b2');
c3 = (f_split{1}*b3') / (b3*b3');
c4 = (f_split{1}*b4') / (b4*b4');
c5 = (f_split{1}*b5') / (b5*b5');

b = {b0, b1, b2, b3, b4, b5};


figure("Name", "Ortonormalna baza", "NumberTitle", "off")
hold on
for i = 1:6
    plot(t_split{1}, b{i}/norm(b{i}), "-")
end
grid on

% ------------------------------------------------------------------------
for i = 1:6
    b{i} = b{1} / norm(b{i});
end

c = {{}}
for i = 1:4
    for j = 1:6
        c{i}{j} = (f_split{i} * b{j}') / (b{j} * b{j}')
    end
end

C = [
    c{1}{1} c{1}{2} c{1}{3} c{1}{4} c{1}{5} c{1}{6}
    c{2}{1} c{2}{2} c{2}{3} c{2}{4} c{2}{5} c{2}{6}
    c{3}{1} c{3}{2} c{3}{3} c{3}{4} c{3}{5} c{3}{6}
    c{4}{1} c{4}{2} c{4}{3} c{4}{4} c{4}{5} c{4}{6}
    ]
