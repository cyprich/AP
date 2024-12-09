clear; close all; cut = 113;
f_full = [135.5 135.78 135.88 135.76 135.95 136.14 137.72 137.56 138.26 137.95 137.0 136.62 138.75 137.64 138.22 139.85 138.76 139.07 139.58 138.42 134.61 137.43 137.82 136.0 135.47 136.04 137.0 138.6 140.41 136.83 139.79 143.24 144.12 141.77 140.66 142.38 143.5 142.59 142.58 138.82 140.58 139.08 140.45 137.66 137.14 135.94 135.63 134.94 136.44 135.97 136.96 134.45 134.15 131.67 133.36 132.5 132.9 131.63 130.39 131.05 132.18 132.82 132.99 132.18 133.2 129.22 130.29 130.49 129.9 129.08 128.53 128.21 127.72 126.87 127.09 126.05 127.74 127.3 126.5 128.49 126.72 127.65 127.39 126.64 128.74 129.12 129.99 130.47 127.09 125.27 126.16 127.43 125.95 127.15 128.08 128.14 127.54 127.65 129.2 135.47 134.27 133.2 131.28 131.61 131.21 132.88 132.48 136.93 137.9 138.0 136.17 135.32 137.02 135.68 135.58 135.63 137.73 137.77 138.4 139.5 141.01 140.22 141.21 139.91 ];
t_full = linspace(1, length(f_full), length(f_full));
t = t_full(1:cut);
f = f_full(1:cut);
tt = linspace(1, cut, 10000);
tt_full = linspace(1, length(f_full), length(tt));

figure; hold on;  grid on; plot(t_full, f_full, "--", color=[0 0.4470 0.7410], LineWidth=0.25, DisplayName="Odstránené dáta"); plot(t, f, "-b", color=[0 0.4470 0.7410], DisplayName="Dáta"); title("Dáta - hodnoty akcií spoločnosti EA"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]"); xlim([1, 124]); xline(cut, "--k", HandleVisibility="off"); xticks(unique([xticks(), cut])); legend;
% ------------------------------------ slide 2 --------------------------------------
n = 6; % velkost polynomu 
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
figure; hold on; grid on; plot(t, f, "-", DisplayName="Dáta"); plot(t, fp, "", DisplayName=sprintf("Aproximácia polynómom %d. stupňa", n)); title(sprintf("Regresia polynómom %d. stupňa", n)); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]"); xlim([1, cut]); legend;
% ------------------------------------ slide 3 --------------------------------------
f_old = f;
f = f - fp; % centrovane data
figure; hold on; grid on; plot(t, (f_old - mean(f_old)), "--", LineWidth=0.25, DisplayName="Pôvodné dáta"); plot(t, f, "-", DisplayName="Dáta bez globálneho trendu"); xlim([1, cut]); title("Dáta s odstráneným globálnym trendom"); xlabel("Počet dní od 1. 1. 2024"); legend;
% ------------------------------------ slide 4 --------------------------------------
N = length(f);
for n = 1:N
    for k = 1:N
        H(n,k) = cos((n-1) * (k-1) * 2*pi / N) + 1i * sin((n-1) * (k-1) * 2*pi / N);
    end
end
c_h = f * H^(-1);  % spektrum
ca_h = abs(c_h); % amplitudove spektrumfigure; hold on; grid on; plot(t, ca_h, "-"); title("Ampliúdové spektrum"); xlim([1, cut]); xlabel("Počet dní od 1. 1. 2024"); xline((cut + 2)/2, "--k", LineWidth=0.125);
% ------------------------------------ slide 5 --------------------------------------
najvyznamnejsie = [6 8 5 26 16]; % indexy najvyznamnejsich koeficientov (indexovane od 1)
y{1} = 2 * real(c_h(6)) * cos((2*pi/N) * 5 * tt) - 2 * imag(c_h(6)) * sin((2 * pi / N) * 5 * tt);
for i = 2:length(najvyznamnejsie)
    k = najvyznamnejsie(i);
    y{i} = y{i - 1} + 2 * real(c_h(k)) * cos((2*pi/N) * (k-1) * tt) - 2 * imag(c_h(k)) * sin((2 * pi / N) * (k-1) * tt);
end
for i = 1:length(y)
    figure; hold on; grid on; plot(t, f, "-k", DisplayName="Dáta"); title("Harmonické funkcie"); xlabel("Počet dní od 1. 1. 2024"); xlim([1 cut]);
    j = 1;
    while j < i
        plot(tt, y{j}, "--", DisplayName=sprintf("%d. harmonická funkcia", j));
        j = j+1;
    end
    plot(tt, y{i}, "-", LineWidth=1.5, DisplayName=sprintf("%d. harmonická funkcia", i)); legend;
end
% ------------------------------------ slide 6 --------------------------------------
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
figure; hold on; grid on; plot(t_full, (f_full- mean(f_full)), "-", DisplayName="Dáta"); plot(tt_full, final, "-", DisplayName="Celková regresná funkcia", LineWidth=1.5); xlim([1, length(f_full)]); xline(cut, "--k", HandleVisibility="off"); xticks(unique([xticks(), cut])); title("Regresná funkcia"); xlabel("Počet dní od 1. 1. 2024"); legend; % close all % zavrie vsetky otvorene grafy (figures)


