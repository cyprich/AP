clear; close all;
import = readmatrix("matlabized_data2.csv");
f_full = import(:, 2)';
t_full = import(:, 1)';
F = reshape(f_full(1:121), 11, 11);  % premeni data na 11x11 maticu
F = (F') - mean((F'));  % vycentrovana a transponovana matica

figure; hold on; grid on; legend; xlim([1 121]); title("Dáta - hodnoty akcií spoločnosti EA"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]"); 
plot(t_full, f_full, DisplayName="Pôvodné dáta"); 

figure; hold on; grid on; legend(Location="northeastoutside"); title("Rozdelené dáta"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]"); xlim([1 121]); 
for i = 1:11
    plot(linspace(i*11-10, i*11, 11), f_full(i*11-10: i*11), LineWidth=1.25, DisplayName=sprintf("%d. časť dát", i))
    xline(i*11, "--", HandleVisibility="off");
end

figure; hold on; grid on; legend(Location="northeastoutside"); title("Rozdelené dáta v jednom grafe");
for i = 1:11
    plot(F(i, :), DisplayName=sprintf("%d. časť dát", i));
end

% ------------------ kovariancna matica --------------------
R = cov(F);
writematrix(R, "zadanie7_kovariancna_matica.xlsx")

% for i = 1:30
%     figure; hold on; title("Kovariančná matica"); xlabel("X"); ylabel("Y"), zlabel("Z")
%     surf(R);
%     view(i*12, 45);
% end

% ------------------- vlastne cisla -----------------------
[U, S, V] = svd(R);
vlastne_cisla = diag(S);

figure, grid on; hold on; title("Spektrum vlastných čísel")
plot(vlastne_cisla);

% ---------------- karhunen-loeve baza vlastnych vektorov ----------------
C = F * U;

% ------------------------- pohlady v1v2 v1v3 v2v3 ------------------------
figure; hold on; grid on; title("Zobrazenie v rovine v1v2"); xlabel('v1'); ylabel('v2');
plot(C(:, 1), C(:, 2), ".", MarkerSize=16);

figure; hold on; grid on; title("Zobrazenie v rovine v1v3"); xlabel('v1'); ylabel('v3');
plot(C(:, 1), C(:, 3), ".", MarkerSize=16);

figure; hold on; grid on; title("Zobrazenie v rovine v2v3"); xlabel('v2'); ylabel('v3');
plot(C(:, 2), C(:, 3), ".", MarkerSize=16);

info1 = (vlastne_cisla(1) + vlastne_cisla(2)) / sum(vlastne_cisla);
info2 = (vlastne_cisla(1) + vlastne_cisla(3)) / sum(vlastne_cisla);
info3 = (vlastne_cisla(2) + vlastne_cisla(3)) / sum(vlastne_cisla);

% ---------------- najpodobnejsie a najvzdialenejsie spektra -------------

% Výpočet euklidovských vzdialeností medzi spektrami
n = size(C, 2);

for i = 1:n
    for j = 1:n
        vzdialenosti(i, j) = norm(C(:, i) - C(:, j));
    end
end

% vypocet min/max vzdialenosti
[min_vzdialenost, min_i] = min(vzdialenosti(vzdialenosti > 0));
[max_vzdialenost, max_i] = max(vzdialenosti(:)); 
% indexy min/max oblasti
[min_1, min_2] = ind2sub([n n], find(vzdialenosti == min_vzdialenost, 1));
[max_1, max_2] = ind2sub([n n], find(vzdialenosti == max_vzdialenost, 1));



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
    filename = sprintf('zadanie7obrazky/figure_%d.png', n); 
    
    % Save the figure as PNG with specified resolution
    print(fig, filename, '-dpng', ['-r', num2str(resolution)]);
end

close all;
