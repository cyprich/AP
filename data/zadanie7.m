clear; close all;
import = readmatrix("matlabized_data2.csv");
f_full = import(:, 2)';
t_full = import(:, 1)';

figure; hold on; grid on; legend; xlim([1 120]); title("Dáta - hodnoty akcií spoločnosti EA"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]");
plot(t_full, f_full, DisplayName="Povodne data")

for i = 0:11
    f{i+1} = f_full(i*10+1: i*10+10);
    t{i+1} = linspace(i*10, i*10+9, 10);
end 

figure; hold on; grid on; legend(Location="northeastoutside"); title("Rozdelene data"); xlabel("Počet dní od 1. 1. 2024"); ylabel("Hodnota akcie [$]");
for i = 1:12
    plot(t{i}, f{i}, LineWidth=1.25, DisplayName=sprintf("%d. cast dat", i));
    xline(i*10, "--", HandleVisibility="off");
end

figure; hold on; grid on; legend(Location="northeastoutside"); title("Rozdelene data - spolu");
for i = 1:12 
    plot(f{i}, LineWidth=1.25, DisplayName=sprintf("%d. cast dat", i));
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
