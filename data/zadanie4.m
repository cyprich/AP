clear
close all

% Peter Cyprich = 12 pismen
N = 12;

% nacitanie dat zo suboru
import = readmatrix("matlabized_data2.csv");
t = linspace(0, N-1, N);
f = import(1:N, 2);
f = f';
f = f - mean(f);  % centrovanie dat


% zobrazenie dat
plot(t, f, '-', DisplayName="Hodnoty akcii");
grid on
title(sprintf("Povodne data - prvych %d hodnot - vycentrovane", N))
xlim([0 11])

% ---------------------- harmonicka baza + spektra ------------------------

% harmonicka baza
for n = 1:N
    for k = 1:N
        H(n,k) = cos((n-1) * (k-1) * 2*pi / N) + 1i * sin((n-1) * (k-1) * 2*pi / N);
    end
end

c = f * H^(-1);  % spektrum
ca = abs(c);  % amplitudove spektrum

figure
plot(t, ca, "-")
grid on
title("Amplitudove spektrum")
xlim([0 11])

% --------------------------- harmonicke funkcie --------------------------

tt = linspace(0, N-1, 1000);

index = 1;
for X = [1 2 5 3 4 6]
    % y(t) = 2a * cos ((2pi/N) * nt) - 2b * sin ((2pi/N) * nt)

    if index == 1  % iba prva iteracia ked este nepozname predchadzajucu funkciu
        y{1} = c(1) + 2 * real(c(2)) * cos((2*pi/N) * 1 * tt) - 2 * imag(c(2)) * sin((2*pi/N) * 1 * tt);
    elseif index == 6  % posledna iteracia ked treba vysledok podelit dvojkou
        y{6} = y{5} + real(c(7)) * cos((2*pi/N) * 6 * tt);
    else  % normalny beh for loopu
        y{index} = y{index - 1} + 2 * real(c(X + 1)) * cos((2*pi/N) * X * tt) - 2 * imag(c(X + 1)) * sin((2*pi/N) * X * tt);
    end

    figure
    hold on
    grid on

    plot(t, f, "-", DisplayName="Data", LineWidth=1.5)
    for i = 1:(length(y) - 1)
        plot(tt, y{i}, "-", DisplayName=sprintf("%d. najvyznamnejsia harmonicka funkcia", i))
    end
    plot(tt, y{end}, "-", DisplayName=sprintf("%d. najvyznamnejsia harmonicka funkcia", length(y)), LineWidth=1.25)  % podsledny je hrubsi

    title("Harmonicke funkcie")
    xlim([0 11])
    legend(Location="northwest")
    
    index = index + 1;
end

figure
hold on
grid on
plot(t, f, "-o", DisplayName="Data")
plot(tt, y{6}, "-", DisplayName="6. najvyznamnejsia harmonicka funkcia")
title("Harmonicke funkcie - interpolacia")
xlim([0 11])
legend(Location="northwest")


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
    filename = sprintf('zadanie4obrazky/figure_%d.png', i); 
    
    % Save the figure as PNG with specified resolution
    print(fig, filename, '-dpng', ['-r', num2str(resolution)]);
end

close all

c
ca
