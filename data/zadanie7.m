clear; close all;
import = readmatrix("matlabized_data2.csv");
f_full = import(:, 2)';
t_full = import(:, 1)';
F = reshape(f_full(1:121), 11, 11);  % premeni data na 11x11 maticu
F = F';

figure; hold on; grid on; legend; xlim([1 120]); title("Dáta - hodnoty akcií spoločnosti EA"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]"); 
plot(t_full, f_full, DisplayName="Povodne data"); 

figure; hold on; grid on; legend(Location="northeastoutside"); title("Rozdelene data"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]"); xlim([1 121]); 
for i = 1:11
    plot(linspace(i*11-10, i*11, 11), f_full(i*11-10: i*11), LineWidth=1.25, DisplayName=sprintf("%d. cast dat", i))
    xline(i*11, "--", HandleVisibility="off");
end

figure; hold on; grid on; legend(Location="northeastoutside"); title("Rozdelene data v jednom grafe"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]");
for i = 1:11
    plot(F(i, :), DisplayName=sprintf("%d. cast dat", i));
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
    filename = sprintf('zadanie7obrazky/figure_%d.png', n); 
    
    % Save the figure as PNG with specified resolution
    print(fig, filename, '-dpng', ['-r', num2str(resolution)]);
end

close all;
