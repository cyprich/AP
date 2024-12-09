clear
close all

% nacitanie dat zo suboru
import = readmatrix("matlabized_data2.csv");
cut = 113;
t_full = import(:, 1)';
f_full = import(:, 2)';

t = t_full(1:cut);
f = f_full(1:cut);

tt = linspace(1, cut, 10000);
tt_full = linspace(1, length(f_full), length(tt));

% ------------------ slide 1 --------------------
figure;
hold on; 
grid on;
plot(t_full, f_full, "--", color=[0 0.4470 0.7410], LineWidth=0.25, DisplayName="Odstránené dáta");
plot(t, f, "-b", color=[0 0.4470 0.7410], DisplayName="Dáta");
title("Dáta - hodnoty akcií spoločnosti EA")
xlabel("Počet dní od 1. 1. 2024")
ylabel("Hodnota akcie [$]")
xlim([1, 124]);
xline(cut, "--k", HandleVisibility="off")
xticks(unique([xticks(), cut]));
legend;

% ------------------ slide 2 --------------------

n = 6;  % velkost polynomu 

for i = 1:n+1;
    b{i} = t.^(i-1);
    B(i, :) = b{i};
    BB(i, :) = tt.^(i-1);
    a(i) = f*b{i}';
end

for i=1:n+1
    for j = 1:n+1
        A(i, j) = b{i} * b{j}';
    end
end

c = A\a';
fp = c'*B;
fpp = c'*BB;

figure;
hold on; 
grid on;
plot(t, f, "-", DisplayName="Dáta");
plot(t, fp, "", DisplayName=sprintf("Aproximácia polynómom %d. stupňa", n));
title(sprintf("Regresia polynómom %d. stupňa", n))
xlabel("Počet dní od 1. 1. 2024")
ylabel("Hodnota akcie [$]")
xlim([1, cut]);
legend;

% ------------------ slide 3 --------------------
f_old = f;
f = f - fp;  % centrovane data

figure;
hold on;
grid on;
plot(t, (f_old - mean(f_old)), "--", LineWidth=0.25, DisplayName="Pôvodné dáta");
plot(t, f, "-", DisplayName="Dáta bez globálneho trendu");
xlim([1, cut]);
title("Dáta s odstráneným globálnym trendom");
xlabel("Počet dní od 1. 1. 2024")
legend;

% ------------------ slide 4 --------------------
N = length(f);
for n = 1:N
    for k = 1:N
        H(n,k) = cos((n-1) * (k-1) * 2*pi / N) + 1i * sin((n-1) * (k-1) * 2*pi / N);
    end
end

c_h = f * H^(-1);
ca_h = abs(c_h);  % amplitudove spektrum

for i = 1:(length(ca_h)/2)+10
    ca2(i, 1) = ca_h(i);
    ca2(i, 2) = i-1;
end

figure;
hold on;
grid on;
plot(t, ca_h, "-")
title("Amplitúdové spektrum")
xlim([1, cut]);
xlabel("Počet dní od 1. 1. 2024");
xline((cut + 2)/2, "--k", LineWidth=0.125)

% ------------------ slide 5 --------------------
% y(t) = 2a * cos ((2pi/N) * nt) - 2b * sin ((2pi/N) * nt)

najvyznamnejsie = [6 8 5 26 16]; % indexy najvyznamnejsich koeficientov (indexovane od 1)

y{1} = 2 * real(c_h(6)) * cos((2*pi/N) * 5 * tt) - 2 * imag(c_h(6)) * sin((2 * pi / N) * 5 * tt);
for i = 2:length(najvyznamnejsie)
    k = najvyznamnejsie(i);
    y{i} = y{i - 1} + 2 * real(c_h(k)) * cos((2*pi/N) * (k-1) * tt) - 2 * imag(c_h(k)) * sin((2 * pi / N) * (k-1) * tt);
end


for i = 1:length(y)
    figure;
    hold on;
    grid on;
    plot(t, f, "-k", DisplayName="Dáta");
    title("Harmonické funkcie");
    xlabel("Počet dní od 1. 1. 2024");
    xlim([1 cut]);
    
    j = 1;
    while j < i
        plot(tt, y{j}, "--", DisplayName=sprintf("%d. harmonická funkcia", j));
        j = j+1;
    end
    plot(tt, y{i}, "-", LineWidth=1.5, DisplayName=sprintf("%d. harmonická funkcia", i));
    legend;
end

% ------------------ slide 6 --------------------

for i = 1:length(c)
    B_full(i, :) = tt_full.^(i - 1);
end
fpp_full = c'* B_full;

N_full = length(f_full);
y_full = 0;
for i = 1:length(najvyznamnejsie)
    k = najvyznamnejsie(i);
    y_full = y_full + 2 * real(c_h(k)) * cos((2*pi/N_full) * (k-1) * tt_full) - 2 * imag(c_h(k)) * sin((2 * pi / N_full) * (k-1) * tt_full);
end

final = fpp_full + y_full;
final = final - mean(final);

figure;
hold on
grid on
plot(t_full, (f_full- mean(f_full)), "-", DisplayName="Dáta")
plot(tt_full, final, "-", DisplayName="Celková regresná funkcia", LineWidth=1.5)
xlim([1, length(f_full)]);
xline(cut, "--k", HandleVisibility="off")
xticks(unique([xticks(), cut]));
title("Regresná funkcia");
xlabel("Počet dní od 1. 1. 2024");
legend

% ----------------------- exportovanie obrazkov ---------------------------
resolution = 300;
width = 10; % inches
height = 5; % inches

figHandles = findall(groot, 'Type', 'figure');  % list of all open figure handles
figHandles = flip(figHandles);

% Loop through each figure and save it as a PNG
for i = 1:length(figHandles)
    fig = figHandles(i);
    
    % Set the figure's PaperPosition (this controls the output size)
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0 0 width height]; % [left bottom width height]
    
    % Create the filename with figure number
    filename = sprintf('zadanie5obrazky/figure_%d.png', i); 
    
    % Save the figure as PNG with specified resolution
    print(fig, filename, '-dpng', ['-r', num2str(resolution)]);
end

close all
