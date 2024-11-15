clear; close all

N = 12; % Peter Cyprich = 12 znakov
t = linspace(0, N-1, N);
f = [135.5 135.78 135.88 135.76 135.95 136.14 137.72 137.56 138.26 137.95 137.0 136.62];
f = f - mean(f); % centrovanie dat

plot(t, f, '-', DisplayName="Hodnoty akcií"); title(sprintf("Dáta - prvých %d hodnôt - vycentrované", N)); grid on; xlim([0 11]); legend(Location="northwest")

% -------------------------------- harmonicka baza + spektra ----------------------------------
for n = 1:N 
    for k = 1:N
        H(n,k) = cos((n-1) * (k-1) * 2*pi / N) + 1i * sin((n-1) * (k-1) * 2*pi / N);
    end
end

c = f * H^(-1); % spektrum
ca = abs(c); % amplitudove spektrum
ca(7) = ca(7) / 2; % stredny prvok podeleny dvojkou

figure; plot(t, ca, "-"); title("Amplitúdové spektrum"); grid on; xlim([0 11]);

% ------------------------------------- harmonicke funkcie ------------------------------------
tt = linspace(0, N-1, 1000);

index = 1;
for X = [1 2 5 3 4 6] % hodnoty su zoradene podla najvyznamnejsich funkcii
    % y(t) = 2a * cos ((2pi/N) * nt) - 2b * sin ((2pi/N) * nt)
    if index == 1 % prva iteracia; c(1) = 0 (kedze su data vycentrovane)
        y{1} = c(1) + 2 * real(c(2)) * cos((2*pi/N) * 1 * tt) - 2 * imag(c(2)) * sin((2*pi/N) * 1 * tt);
    elseif index == 6 % posledna iteracia, ked treba vysledok podelit dvojkou
        y{6} = y{5} + real(c(7)) * cos((2*pi/N) * 6 * tt);
    else % normalny beh for loopu
        y{index} = y{index - 1} + 2 * real(c(X + 1)) * cos((2*pi/N) * X * tt) - 2 * imag(c(X + 1)) * sin((2*pi/N) * X * tt);
    end

    figure; hold on; grid on; plot(t, f, "-", DisplayName="Dáta", LineWidth=1.5)
    for i = 1:length(y) 
        plot(tt, y{i}, "-", DisplayName=sprintf("%d. najvýznamnejšia harmonická funkcia", i))
    end
    title("Harmonické funkcie"); legend(Location="northwest"); xlim([0 11])
    index = index + 1;
end

% ------------------------------------- graf interpolacie -------------------------------------
figure; hold on; grid on; plot(t, f, "-o", DisplayName="Dáta"); plot(tt, y{6}, "-", DisplayName="6. najvýznamnejšia harmonická funkcia");title("Harmonické funkcie - interpolácia"); legend(Location="northwest"); xlim([0 11])
% close all % zavrie vsetky otvorene okna (grafy)

