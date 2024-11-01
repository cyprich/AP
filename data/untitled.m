clear
close all % zavrie vsetky predchadzajuce otvore okna (figures)

% casovy vektor a data
t = linspace(1, 124, 124);
f = [ 135.5 135.78 135.88 135.76 135.95 136.14 137.72 137.56 138.26 137.95 137.0 136.62 138.75 137.64 138.22 139.85 138.76 139.07 139.58 138.42 134.61 137.43 137.82 136.0 135.47 136.04 137.0 138.6 140.41 136.83 139.79 143.24 144.12 141.77 140.66 142.38 143.5 142.59 142.58 138.82 140.58 139.08 140.45 137.66 137.14 135.94 135.63 134.94 136.44 135.97 136.96 134.45 134.15 131.67 133.36 132.5 132.9 131.63 130.39 131.05 132.18 132.82 132.99 132.18 133.2 129.22 130.29 130.49 129.9 129.08 128.53 128.21 127.72 126.87 127.09 126.05 127.74 127.3 126.5 128.49 126.72 127.65 127.39 126.64 128.74 129.12 129.99 130.47 127.09 125.27 126.16 127.43 125.95 127.15 128.08 128.14 127.54 127.65 129.2 135.47 134.27 133.2 131.28 131.61 131.21 132.88 132.48 136.93 137.9 138.0 136.17 135.32 137.02 135.68 135.58 135.63 137.73 137.77 138.4 139.5 141.01 140.22 141.21 139.91 ];

% popisy osi, nadpis (podla parametra) a podobne "srandicky" do grafu :)
function srandicky_do_grafu(nadpis)
grid on
title(nadpis)
xlim([1 124])
xlabel("Počet dní od 1. 1. 2024")
ylabel("Hodnota akcie [$]")
legend
hold off
end

% bazicke vektory
b0 = t.^0;
b1 = t.^1;
b2 = t.^2;
b3 = t.^3;
b4 = t.^4;
b5 = t.^5;
b6 = t.^6;
b7 = t.^7;
b8 = t.^8;

% polynom Q8 pre vykreslenie do grafu
B = [ b0; b1; b2; b3; b4; b5; b6; b7; b8 ];
A = [ b0*b0' b1*b0' b2*b0' b3*b0' b4*b0' b5*b0' b6*b0' b7*b0' b8*b0'
b0*b1' b1*b1' b2*b1' b3*b1' b4*b1' b5*b1' b6*b1' b7*b1' b8*b1'
b0*b2' b1*b2' b2*b2' b3*b2' b4*b2' b5*b2' b6*b2' b7*b2' b8*b2'
b0*b3' b1*b3' b2*b3' b3*b3' b4*b3' b5*b3' b6*b3' b7*b3' b8*b3'
b0*b4' b1*b4' b2*b4' b3*b4' b4*b4' b5*b4' b6*b4' b7*b4' b8*b4'
b0*b5' b1*b5' b2*b5' b3*b5' b4*b5' b5*b5' b6*b5' b7*b5' b8*b5'
b0*b6' b1*b6' b2*b6' b3*b6' b4*b6' b5*b6' b6*b6' b7*b6' b8*b6'
b0*b7' b1*b7' b2*b7' b3*b7' b4*b7' b5*b7' b6*b7' b7*b7' b8*b7'
b0*b8' b1*b8' b2*b8' b3*b8' b4*b8' b5*b8' b6*b8' b7*b8' b8*b8'];
a = [f*b0'; f*b1'; f*b2'; f*b3'; f*b4'; f*b5'; f*b6'; f*b7'; f*b8'];

c8 = A\a;
fp8 = c8'*B;

figure
hold on
plot(t, f, "-", DisplayName="Hodnoty akcií")
plot(t, fp8, "-", DisplayName="Pôvodný polynóm 8. stupňa")
srandicky_do_grafu("Pôvodný polynóm 8. stupňa")

% ########################################################################
% premenne B, A, a som nepotreboval viac krat, tak som ich vzdy prepisoval
% novou premennou, aby to bolo prehladnejsie a menej premennych

% ---------------------------- bez Q7 -------------------------------------
B = [ b0; b1; b2; b3; b4; b5; b6; b8 ];
A = [ b0*b0' b1*b0' b2*b0' b3*b0' b4*b0' b5*b0' b6*b0' b8*b0'
b0*b1' b1*b1' b2*b1' b3*b1' b4*b1' b5*b1' b6*b1' b8*b1'
b0*b2' b1*b2' b2*b2' b3*b2' b4*b2' b5*b2' b6*b2' b8*b2'
b0*b3' b1*b3' b2*b3' b3*b3' b4*b3' b5*b3' b6*b3' b8*b3'
b0*b4' b1*b4' b2*b4' b3*b4' b4*b4' b5*b4' b6*b4' b8*b4'
b0*b5' b1*b5' b2*b5' b3*b5' b4*b5' b5*b5' b6*b5' b8*b5'
b0*b6' b1*b6' b2*b6' b3*b6' b4*b6' b5*b6' b6*b6' b8*b6'
b0*b8' b1*b8' b2*b8' b3*b8' b4*b8' b5*b8' b6*b8' b8*b8'];
a = [f*b0'; f*b1'; f*b2'; f*b3'; f*b4'; f*b5'; f*b6'; f*b8'];

cx7 = A\a; % koeficienty
fpx7 = cx7'*B; % polynom bez x^7
ex7 = sqrt(sum((f - fpx7).^2)); % celkova chyba
% ex7/length(f) % priemerna chyba na jedno meranie

figure
hold on
plot(t, f, "-", DisplayName="Hodnoty akcií")
plot(t, fp8, "--", DisplayName="Pôvodný polynóm 8. stupňa")
plot(t, fpx7, "-", DisplayName="Bez bez zložky x^7", LineWidth=1.25)
srandicky_do_grafu("Polynomická regresia - Polynóm 8. stupňa bez zložky x^7")

% ------------------------ bez Q6 ---------------------------------------

B = [ b0; b1; b2; b3; b4; b5; b8 ];
A = [ b0*b0' b1*b0' b2*b0' b3*b0' b4*b0' b5*b0' b8*b0'
b0*b1' b1*b1' b2*b1' b3*b1' b4*b1' b5*b1' b8*b1'
b0*b2' b1*b2' b2*b2' b3*b2' b4*b2' b5*b2' b8*b2'
b0*b3' b1*b3' b2*b3' b3*b3' b4*b3' b5*b3' b8*b3'
b0*b4' b1*b4' b2*b4' b3*b4' b4*b4' b5*b4' b8*b4'
b0*b5' b1*b5' b2*b5' b3*b5' b4*b5' b5*b5' b8*b5'
b0*b8' b1*b8' b2*b8' b3*b8' b4*b8' b5*b8' b8*b8'];
a = [f*b0'; f*b1'; f*b2'; f*b3'; f*b4'; f*b5'; f*b8'];

cx6 = A\a;
fpx6 = cx6'*B;
ex6 = sqrt(sum((f - fpx6).^2));
% ex6/length(f)
figure
hold on
plot(t, f, "-", DisplayName="Hodnoty akcií")
plot(t, fp8, "--", DisplayName="Pôvodný polynóm 8. stupňa")
plot(t, fpx7, "--", DisplayName="Polynóm 8. stupňa bez zložky x^7")
plot(t, fpx6, "-", DisplayName="Polynóm 8. stupňa bez zložiek x^6 a x^7", LineWidth=1.25)
srandicky_do_grafu("Polynomická regresia - Polynóm 8. stupňa bez zložiek x^6 a x^7")

% ------------------------ bez Q5 ---------------------------------------

B = [ b0; b1; b2; b3; b4; b8 ];
A = [ b0*b0' b1*b0' b2*b0' b3*b0' b4*b0' b8*b0'
b0*b1' b1*b1' b2*b1' b3*b1' b4*b1' b8*b1'
b0*b2' b1*b2' b2*b2' b3*b2' b4*b2' b8*b2'
b0*b3' b1*b3' b2*b3' b3*b3' b4*b3' b8*b3'
b0*b4' b1*b4' b2*b4' b3*b4' b4*b4' b8*b4'
b0*b8' b1*b8' b2*b8' b3*b8' b4*b8' b8*b8'];
a = [f*b0'; f*b1'; f*b2'; f*b3'; f*b4'; f*b8'];

cx5 = A\a;
fpx5 = cx5'*B;
ex5 = sqrt(sum((f - fpx5).^2));
% ex5/length(f)

figure
hold on
plot(t, f, "-", DisplayName="Hodnoty akcií")
plot(t, fp8, "--", DisplayName="Pôvodný polynóm 8. stupňa")
plot(t, fpx7, "--", DisplayName="Polynóm 8. stupňa bez zložky x^7")
plot(t, fpx6, "--", DisplayName="Polynóm 8. stupňa bez zložiek x^6 a x^7")
plot(t, fpx5, "-", DisplayName="Polynóm 8. stupňa bez zložiek x^5 až x^7", LineWidth=1.25)
srandicky_do_grafu("Polynomická regresia - Polynóm 8. stupňa bez zložiek x^5 až x^7")

% close all % zavrie vsetky otvorene okna (figures)
