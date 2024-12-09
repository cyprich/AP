clear; close all;

import = readmatrix("matlabized_data2.csv");
t_full = import(:, 1)';
f_full = import(:, 2)';
l = length(f_full);  % dlzka dat


figure; hold on; grid on; xlim([1 124]); legend; title("Dáta - hodnoty akcií spoločnosti EA"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]");
plot(t_full, f_full, "-", DisplayName="Dáta");

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

figure; hold on; grid on; xlim([1 124]); title("Filtrácia pomocou štandardnej metódy MA(2)"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]");
plot(t_full, f_full, DisplayName="Dáta");
plot(t_full, ma2_std, LineWidth=1.5, DisplayName="Štandardná MA(2)");

figure; hold on; grid on; xlim([1 124]); legend; title("Filtrácia pomocou štandardnej metódy MA(4)"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]");
plot(t_full, f_full, DisplayName="Dáta");
plot(t_full, ma2_std, DisplayName="Štandardná MA(2)");
plot(t_full, ma4_std, LineWidth=1.5, DisplayName="Štandardná MA(4)");

figure; hold on; grid on; xlim([1 124]); legend; title("Filtrácia pomocou štandardnej metódy MA(6)"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]");
plot(t_full, f_full, DisplayName="Dáta");
plot(t_full, ma2_std, DisplayName="Štandardná MA(2)");
plot(t_full, ma4_std, DisplayName="Štandardná MA(4)");
plot(t_full, ma6_std, LineWidth=1.5, DisplayName="Štandardná MA(6)");

% ----------------------- adaptabilna MA ---------------------------
% MA(2)
fz = f_full(2: l-1);
b1 = f_full(3: l);
b2 = f_full(1: l-2);

B = [b1; b2];
c = (fz * B') * (B * B')^(-1);
ma2_adapt = c*B;
fprintf("koeficienty ma2: %d\n", c)

% MA(4)
fz = f_full(3: l-2);
b1 = f_full(4: l-1);
b2 = f_full(5: l);
b3 = f_full(2: l-3);
b4 = f_full(1: l-4);

B = [b1; b2; b3; b4];
c = (fz * B') * (B * B')^(-1);
ma4_adapt = c*B;
fprintf("koeficienty ma4: %d\n", c)

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
fprintf("koeficienty ma6: %d\n", c)

figure; hold on; grid on; xlim([1 124]); legend; title("Filtrácia pomocou adaptabilnej metódy MA(2)"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]");
plot(t_full, f_full, DisplayName="Dáta");
plot(t_full(2:l-1), ma2_adapt, LineWidth=1.5, DisplayName="Adaptabilná MA(2)");

figure; hold on; grid on; xlim([1 124]); legend; title("Filtrácia pomocou adaptabilnej metódy MA(4)"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]");
plot(t_full, f_full, DisplayName="Dáta");
plot(t_full(2:l-1), ma2_adapt, DisplayName="Adaptabilná MA(2)");
plot(t_full(3:l-2), ma4_adapt, LineWidth=1.5, DisplayName="Adaptabilná MA(4)");

figure; hold on; grid on; xlim([1 124]); legend; title("Filtrácia pomocou adaptabilnej metódy MA(6)"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]");
plot(t_full, f_full, DisplayName="Dáta");
plot(t_full(2:l-1), ma2_adapt, DisplayName="Adaptabilná MA(2)");
plot(t_full(3:l-2), ma4_adapt, DisplayName="Adaptabilná MA(4)");
plot(t_full(4:l-3), ma6_adapt, LineWidth=1.5, DisplayName="Adaptabilná MA(6)");

% ---------- MA spolocne ---------- 

figure; hold on; grid on; xlim([1 124]); legend; title("Porovnanie štandardnej a adaptabilnej metódy MA(2)"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]");
plot(t_full, f_full)
plot(t_full, ma2_std, LineWidth=1.5, DisplayName="Štandardná MA(2)");
plot(t_full(2:l-1), ma2_adapt, LineWidth=1.5, DisplayName="Adaptabilná MA(2)");

figure; hold on; grid on; xlim([1 124]); legend; title("Porovnanie štandardnej a adaptabilnej metódy MA(4)"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]");
plot(t_full, f_full)
plot(t_full, ma4_std, LineWidth=1.5, DisplayName="Štandardná MA(4)");
plot(t_full(3:l-2), ma4_adapt, LineWidth=1.5, DisplayName="Adaptabilná MA(4)");

figure; hold on; grid on; xlim([1 124]); legend; title("Porovnanie štandardnej a adaptabilnej metódy MA(6)"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]");
plot(t_full, f_full)
plot(t_full, ma6_std, LineWidth=1.5, DisplayName="Štandardná MA(6)");
plot(t_full(4:l-3), ma6_adapt, LineWidth=1.5, DisplayName="Adaptabilná MA(6)");

% ----------------------- AR(1) ---------------------------
okno = [5 10 15 20];
c = {};
format short;

index_listu = 1;
for n = okno
    fz = f_full(1: end-n+1);
    b = f_full(n: end);
    c{index_listu} = (fz * b') / (b * b');

    ar1{index_listu} = c{index_listu} * b;

    index_listu = index_listu + 1;
end	

for n = 1:index_listu-1
    figure; hold on; grid on; xlim([1 124]); legend; title(sprintf("Kĺzavý autoregresný koeficient AR(1) pre veľkosť okna %d", okno(n))); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]");
    plot(t_full, f_full, DisplayName="Dáta");
    plot(t_full(okno(n): end), ar1{n}, LineWidth=1.5, DisplayName=sprintf("Dáta * koeficient %.4f", c{n}));
end

% ----------------------- exportovanie obrazkov ---------------------------
resolution = 300;
width = 10; % inches
height = 5; % inches

figHandles = findall(groot, 'Type', 'figure');  % list of all open figure handles
figHandles = flip(figHandles);

% Loop through each figure and save it as a PNG
for n = 1:length(figHandles)
    fig = figHandles(n);
    
    % Set the figure's PaperPosition (this controls the output size)
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0 0 width height]; % [left bottom width height]
    
    % Create the filename with figure number
    filename = sprintf('zadanie6obrazky/figure_%d.png', n); 
    
    % Save the figure as PNG with specified resolution
    print(fig, filename, '-dpng', ['-r', num2str(resolution)]);
end

close all;
