clear; close all; format short;
f_full = [135.5 135.78 135.88 135.76 135.95 136.14 137.72 137.56 138.26 137.95 137.0 136.62 138.75 137.64 138.22 139.85 138.76 139.07 139.58 138.42 134.61 137.43 137.82 136.0 135.47 136.04 137.0 138.6 140.41 136.83 139.79 143.24 144.12 141.77 140.66 142.38 143.5 142.59 142.58 138.82 140.58 139.08 140.45 137.66 137.14 135.94 135.63 134.94 136.44 135.97 136.96 134.45 134.15 131.67 133.36 132.5 132.9 131.63 130.39 131.05 132.18 132.82 132.99 132.18 133.2 129.22 130.29 130.49 129.9 129.08 128.53 128.21 127.72 126.87 127.09 126.05 127.74 127.3 126.5 128.49 126.72 127.65 127.39 126.64 128.74 129.12 129.99 130.47 127.09 125.27 126.16 127.43 125.95 127.15 128.08 128.14 127.54 127.65 129.2 135.47 134.27 133.2 131.28 131.61 131.21 132.88 132.48 136.93 137.9 138.0 136.17 135.32 137.02 135.68 135.58 135.63 137.73 137.77 138.4 139.5 141.01 140.22 141.21 139.91 ];
l = length(f_full); % dlzka (pocet hodnot) dat
t_full = linspace(1, l, l);
figure; hold on; grid on; xlim([1 124]); title("Dáta - hodnoty akcií spoločnosti EA"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]"); plot(t_full, f_full, "-", DisplayName="Dáta");

% ----------------------- standardna MA ---------------------------
% MA(2)
for i = 1:l
    if i == 1 || i == l
        ma2_std(i) = NaN;
    else
        ma2_std(i) = (f_full(i-1) + f_full(i+1)) / 2;
    end
end

% MA(4)
for i = 1:l 
    if i <= 2 || i >= l-1
        ma4_std(i) = NaN;
    else
        ma4_std(i) = (f_full(i-2) + f_full(i-1) + f_full(i+1) + f_full(i+2)) / 4;
    end
end

% MA(6)
for i = 1:l
    if i <= 3 || i >= l-2
        ma6_std(i) = NaN;
    else
        ma6_std(i) = (f_full(i-3) + f_full(i-2) + f_full(i-1) + f_full(i+1) + f_full(i+2) + f_full(i+3)) / 6;
    end
end

figure; hold on; grid on; xlim([1 124]); legend; title("Filtrácia pomocou štandardnej metódy MA(2)"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]"); plot(t_full, f_full, DisplayName="Dáta"); plot(t_full, ma2_std, LineWidth=1.5, DisplayName="Štandardná MA(2)");
figure; hold on; grid on; xlim([1 124]); legend; title("Filtrácia pomocou štandardnej metódy MA(4)"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]"); plot(t_full, f_full, DisplayName="Dáta"); plot(t_full, ma2_std, DisplayName="Štandardná MA(2)"); plot(t_full, ma4_std, LineWidth=1.5, DisplayName="Štandardná MA(4)");
figure; hold on; grid on; xlim([1 124]); legend; title("Filtrácia pomocou štandardnej metódy MA(6)"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]"); plot(t_full, f_full, DisplayName="Dáta"); plot(t_full, ma2_std, DisplayName="Štandardná MA(2)"); plot(t_full, ma4_std, DisplayName="Štandardná MA(4)"); plot(t_full, ma6_std, LineWidth=1.5, DisplayName="Štandardná MA(6)");

% ----------------------- adaptabilna MA ---------------------------
% MA(2)
fz = f_full(2: l-1);
b1 = f_full(3: l);
b2 = f_full(1: l-2);
B = [b1; b2];
c = (fz * B') * (B * B')^(-1);
ma2_adapt = c*B;

% MA(4)
fz = f_full(3: l-2);
b1 = f_full(4: l-1);
b2 = f_full(5: l);
b3 = f_full(2: l-3);
b4 = f_full(1: l-4);
B = [b1; b2; b3; b4];
c = (fz * B') * (B * B')^(-1);
ma4_adapt = c*B;

% MA(6)
fz = f_full(4: l-3);
b1 = f_full(5: l-2);
b2 = f_full(6: l-1);
b3 = f_full(7: l);
b4 = f_full(3: l-4);
b5 = f_full(2: l-5);
b6 = f_full(1: l-6);
B = [b1; b2; b3; b4; b5; b6];
c = (fz * B') * (B * B')^(-1);
ma6_adapt = c*B;

% -------------------- chyby -------------------- 
e_ma2_std = sqrt(sum((f_full(2:l-1) - ma2_std(2:l-1)).^2)) / (l-2);
e_ma4_std = sqrt(sum((f_full(3:l-2) - ma4_std(3:l-2)).^2)) / (l-4);
e_ma6_std = sqrt(sum((f_full(4:l-3) - ma6_std(4:l-3)).^2)) / (l-6);
e_ma2_adapt = sqrt(sum((f_full(2:l-1) - ma2_adapt).^2)) / (l-2);
e_ma4_adapt = sqrt(sum((f_full(3:l-2) - ma4_adapt).^2)) / (l-4);
e_ma6_adapt = sqrt(sum((f_full(4:l-3) - ma6_adapt).^2)) / (l-6);

figure; hold on; grid on; xlim([1 124]); legend; title("Filtrácia pomocou adaptabilnej metódy MA(2)"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]"); plot(t_full, f_full, DisplayName="Dáta"); plot(t_full(2:l-1), ma2_adapt, LineWidth=1.5, DisplayName="Adaptabilná MA(2)");
figure; hold on; grid on; xlim([1 124]); legend; title("Filtrácia pomocou adaptabilnej metódy MA(4)"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]"); plot(t_full, f_full, DisplayName="Dáta"); plot(t_full(2:l-1), ma2_adapt, DisplayName="Adaptabilná MA(2)"); plot(t_full(3:l-2), ma4_adapt, LineWidth=1.5, DisplayName="Adaptabilná MA(4)");
figure; hold on; grid on; xlim([1 124]); legend; title("Filtrácia pomocou adaptabilnej metódy MA(6)"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]"); plot(t_full, f_full, DisplayName="Dáta"); plot(t_full(2:l-1), ma2_adapt, DisplayName="Adaptabilná MA(2)"); plot(t_full(3:l-2), ma4_adapt, DisplayName="Adaptabilná MA(4)"); plot(t_full(4:l-3), ma6_adapt, LineWidth=1.5, DisplayName="Adaptabilná MA(6)");
figure; hold on; grid on; xlim([1 124]); legend; title("Porovnanie štandardnej a adaptabilnej metódy MA(2)"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]"); plot(t_full, f_full, DisplayName="Dáta"); plot(t_full, ma2_std, LineWidth=1.5, DisplayName="Štandardná MA(2)"); plot(t_full(2:l-1), ma2_adapt, LineWidth=1.5, DisplayName="Adaptabilná MA(2)");
figure; hold on; grid on; xlim([1 124]); legend; title("Porovnanie štandardnej a adaptabilnej metódy MA(4)"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]"); plot(t_full, f_full, DisplayName="Dáta"); plot(t_full, ma4_std, LineWidth=1.5, DisplayName="Štandardná MA(4)"); plot(t_full(3:l-2), ma4_adapt, LineWidth=1.5, DisplayName="Adaptabilná MA(4)");
figure; hold on; grid on; xlim([1 124]); legend; title("Porovnanie štandardnej a adaptabilnej metódy MA(6)"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]"); plot(t_full, f_full, DisplayName="Dáta"); plot(t_full, ma6_std, LineWidth=1.5, DisplayName="Štandardná MA(6)"); plot(t_full(4:l-3), ma6_adapt, LineWidth=1.5, DisplayName="Adaptabilná MA(6)");

% ----------------------- AR(1) ---------------------------
okno = [5 10 15 20]; 
c = {};

index_listu = 1;
for n = okno
    fz = f_full(1: end-n+1);
    b = f_full(n: end);
    c{index_listu} = (fz * b') / (b * b');
    ar1{index_listu} = c{index_listu} * b;
    index_listu = index_listu + 1;
end 

for n = 1:index_listu-1
    figure; hold on; grid on; xlim([1 124]); legend; title(sprintf("Kĺzavý autoregresný koeficient AR(1) pre veľkosť okna %d", okno(n))); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]"); plot(t_full, f_full, DisplayName="Dáta"); plot(t_full(okno(n): end), ar1{n}, LineWidth=1.5, DisplayName=sprintf("Dáta * koeficient %.4f", c{n}));
end

% close all; % zavrie vsetky otvorene obrazky (figures)
