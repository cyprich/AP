clear
close all

% nacitanie dat zo suboru
import = readmatrix("matlabized_data2.csv");
t = import(:, 1);
f = import(:, 2);

t = t';
f = f';

function srandicky_do_grafu(nadpis)
    grid on
    title(nadpis)
    xlim([1 124])
    xlabel("Počet dní od 1. 1. 2024")
    ylabel("Hodnota akcie [$]")
    legend
    hold off
end


figure
plot(t, f, "-", DisplayName="Hodnoty akcií")
srandicky_do_grafu("Dáta - hodnoty akcií spoločnosti EA")

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


% ------------ polynomicka regresia Q1 --------------------

B = [ b0; b1 ];
A = [ b0*b0'  b1*b0'
      b0*b1'  b1*b1' ];
a = [f*b0'; f*b1'];

c = A\a;
fp1 = c'*B;

figure
hold on
plot(t, f, "-", DisplayName="Hodnoty akcií")
plot(t, fp1, "-", DisplayName="Polynóm 1. stupňa")
srandicky_do_grafu("Polynomická regresia - polynóm 1. stupňa")


% ------------ polynomicka regresia Q2 --------------------

B = [ b0; b1; b2 ];
A = [ b0*b0'  b1*b0' b2*b0'
      b0*b1'  b1*b1' b2*b1'
      b0*b2'  b1*b2' b2*b2'];
a = [f*b0'; f*b1'; f*b2'];

c = A\a;
fp2 = c'*B;

figure
hold on
plot(t, f, "-", DisplayName="Hodnoty akcií")
plot(t, fp1, ":", DisplayName="Polynóm 1. stupňa")
plot(t, fp2, "-", DisplayName="Polynóm 2. stupňa")
srandicky_do_grafu("Polynomická regresia - polynóm 1. a 2. stupňa")

% ------------ polynomicka regresia Q3 --------------------

B = [ b0; b1; b2; b3 ];
A = [ b0*b0'  b1*b0' b2*b0' b3*b0'
      b0*b1'  b1*b1' b2*b1' b3*b1'
      b0*b2'  b1*b2' b2*b2' b3*b2'
      b0*b3'  b1*b3' b2*b3' b3*b3'];
a = [f*b0'; f*b1'; f*b2'; f*b3'];

c = A\a;
fp3 = c'*B;

figure
hold on
plot(t, f, "-", DisplayName="Hodnoty akcií")
plot(t, fp1, ":", DisplayName="Polynóm 1. stupňa")
plot(t, fp2, "--", DisplayName="Polynóm 2. stupňa")
plot(t, fp3, "-", DisplayName="Polynóm 3. stupňa")
srandicky_do_grafu("Polynomická regresia - polynóm 1. až 3. stupňa")

% ------------ polynomicka regresia Q4 --------------------

B = [ b0; b1; b2; b3; b4 ];
A = [ b0*b0'  b1*b0' b2*b0' b3*b0' b4*b0'
      b0*b1'  b1*b1' b2*b1' b3*b1' b4*b1'
      b0*b2'  b1*b2' b2*b2' b3*b2' b4*b2'
      b0*b3'  b1*b3' b2*b3' b3*b3' b4*b3'
      b0*b4'  b1*b4' b2*b4' b3*b4' b4*b4'];
a = [f*b0'; f*b1'; f*b2'; f*b3'; f*b4'];

c = A\a;
fp4 = c'*B;

figure
hold on
plot(t, f, "-", DisplayName="Hodnoty akcií")
plot(t, fp1, ":", DisplayName="Polynóm 1. stupňa")
plot(t, fp2, ":", DisplayName="Polynóm 2. stupňa")
plot(t, fp3, "--", DisplayName="Polynóm 3. stupňa")
plot(t, fp4, "-", DisplayName="Polynóm 4. stupňa")
srandicky_do_grafu("Polynomická regresia - polynóm 1. až 4. stupňa")

% ------------ polynomicka regresia Q5 --------------------

B = [ b0; b1; b2; b3; b4; b5 ];
A = [ b0*b0'  b1*b0' b2*b0' b3*b0' b4*b0' b5*b0'
      b0*b1'  b1*b1' b2*b1' b3*b1' b4*b1' b5*b1'
      b0*b2'  b1*b2' b2*b2' b3*b2' b4*b2' b5*b2'
      b0*b3'  b1*b3' b2*b3' b3*b3' b4*b3' b5*b3'
      b0*b4'  b1*b4' b2*b4' b3*b4' b4*b4' b5*b4'
      b0*b5'  b1*b5' b2*b5' b3*b5' b4*b5' b5*b5'];
a = [f*b0'; f*b1'; f*b2'; f*b3'; f*b4'; f*b5'];

c = A\a;
fp5 = c'*B;

figure
hold on
plot(t, f, "-", DisplayName="Hodnoty akcií")
plot(t, fp4, ":", DisplayName="Polynóm 4. stupňa")
plot(t, fp5, "-", DisplayName="Polynóm 5. stupňa")
srandicky_do_grafu("Polynomická regresia - polynóm 4. a 5. stupňa")

% ------------ polynomicka regresia Q6 --------------------

B = [ b0; b1; b2; b3; b4; b5; b6 ];
A = [ b0*b0'  b1*b0' b2*b0' b3*b0' b4*b0' b5*b0' b6*b0'
      b0*b1'  b1*b1' b2*b1' b3*b1' b4*b1' b5*b1' b6*b1'
      b0*b2'  b1*b2' b2*b2' b3*b2' b4*b2' b5*b2' b6*b2'
      b0*b3'  b1*b3' b2*b3' b3*b3' b4*b3' b5*b3' b6*b3'
      b0*b4'  b1*b4' b2*b4' b3*b4' b4*b4' b5*b4' b6*b4'
      b0*b5'  b1*b5' b2*b5' b3*b5' b4*b5' b5*b5' b6*b5'
      b0*b6'  b1*b6' b2*b6' b3*b6' b4*b6' b5*b6' b6*b6'];
a = [f*b0'; f*b1'; f*b2'; f*b3'; f*b4'; f*b5'; f*b6'];

c = A\a;
fp6 = c'*B;

figure
hold on
plot(t, f, "-", DisplayName="Hodnoty akcií")
plot(t, fp5, ":", DisplayName="Polynóm 5. stupňa")
plot(t, fp6, "-b", DisplayName="Polynóm 6. stupňa")
srandicky_do_grafu("Polynomická regresia - polynóm 5. a 6. stupňa")

% ------------ polynomicka regresia Q7 --------------------

B = [ b0; b1; b2; b3; b4; b5; b6; b7 ];
A = [ b0*b0'  b1*b0' b2*b0' b3*b0' b4*b0' b5*b0' b6*b0' b7*b0'
      b0*b1'  b1*b1' b2*b1' b3*b1' b4*b1' b5*b1' b6*b1' b7*b1'
      b0*b2'  b1*b2' b2*b2' b3*b2' b4*b2' b5*b2' b6*b2' b7*b2'
      b0*b3'  b1*b3' b2*b3' b3*b3' b4*b3' b5*b3' b6*b3' b7*b3'
      b0*b4'  b1*b4' b2*b4' b3*b4' b4*b4' b5*b4' b6*b4' b7*b4'
      b0*b5'  b1*b5' b2*b5' b3*b5' b4*b5' b5*b5' b6*b5' b7*b5'
      b0*b6'  b1*b6' b2*b6' b3*b6' b4*b6' b5*b6' b6*b6' b7*b6'
      b0*b7'  b1*b7' b2*b7' b3*b7' b4*b7' b5*b7' b6*b7' b7*b7'];
a = [f*b0'; f*b1'; f*b2'; f*b3'; f*b4'; f*b5'; f*b6'; f*b7'];

c = A\a;
fp7 = c'*B;

figure
hold on
plot(t, f, "-", DisplayName="Hodnoty akcií")
plot(t, fp5, ":", DisplayName="Polynóm 5. stupňa")
plot(t, fp6, "--b", DisplayName="Polynóm 6. stupňa")
plot(t, fp7, "-", DisplayName="Polynóm 7. stupňa")
srandicky_do_grafu("Polynomická regresia - polynóm 5. až 7. stupňa")

% ------------ polynomicka regresia Q8 --------------------

B = [ b0; b1; b2; b3; b4; b5; b6; b7; b8 ];
A = [ b0*b0'  b1*b0' b2*b0' b3*b0' b4*b0' b5*b0' b6*b0' b7*b0' b8*b0'
      b0*b1'  b1*b1' b2*b1' b3*b1' b4*b1' b5*b1' b6*b1' b7*b1' b8*b1'
      b0*b2'  b1*b2' b2*b2' b3*b2' b4*b2' b5*b2' b6*b2' b7*b2' b8*b2'
      b0*b3'  b1*b3' b2*b3' b3*b3' b4*b3' b5*b3' b6*b3' b7*b3' b8*b3'
      b0*b4'  b1*b4' b2*b4' b3*b4' b4*b4' b5*b4' b6*b4' b7*b4' b8*b4'
      b0*b5'  b1*b5' b2*b5' b3*b5' b4*b5' b5*b5' b6*b5' b7*b5' b8*b5'
      b0*b6'  b1*b6' b2*b6' b3*b6' b4*b6' b5*b6' b6*b6' b7*b6' b8*b6'
      b0*b7'  b1*b7' b2*b7' b3*b7' b4*b7' b5*b7' b6*b7' b7*b7' b8*b7'
      b0*b8'  b1*b8' b2*b8' b3*b8' b4*b8' b5*b8' b6*b8' b7*b8' b8*b8'];
a = [f*b0'; f*b1'; f*b2'; f*b3'; f*b4'; f*b5'; f*b6'; f*b7'; f*b8'];

c = A\a;
fp8 = c'*B;

figure
hold on
plot(t, f, "-", DisplayName="Hodnoty akcií")
plot(t, fp5, ":", DisplayName="Polynóm 5. stupňa")
plot(t, fp6, ":b", DisplayName="Polynóm 6. stupňa")
plot(t, fp7, "--", DisplayName="Polynóm 7. stupňa")
plot(t, fp8, "-", DisplayName="Polynóm 8. stupňa")
srandicky_do_grafu("Polynomická regresia - polynóm 5. až 8. stupňa")

figure
hold on
plot(t, f, "-", DisplayName="Hodnoty akcií")
plot(t, fp8, "-", DisplayName="Polynóm 8. stupňa")
srandicky_do_grafu("Polynomická regresia - polynóm 8. stupňa")




% ########################  druha cast  ############################




% ------------------------ bez Q7 ---------------------------------------
B = [ b0; b1; b2; b3; b4; b5; b6; b8 ];
A = [ b0*b0'  b1*b0' b2*b0' b3*b0' b4*b0' b5*b0' b6*b0' b8*b0'
      b0*b1'  b1*b1' b2*b1' b3*b1' b4*b1' b5*b1' b6*b1' b8*b1'
      b0*b2'  b1*b2' b2*b2' b3*b2' b4*b2' b5*b2' b6*b2' b8*b2'
      b0*b3'  b1*b3' b2*b3' b3*b3' b4*b3' b5*b3' b6*b3' b8*b3'
      b0*b4'  b1*b4' b2*b4' b3*b4' b4*b4' b5*b4' b6*b4' b8*b4'
      b0*b5'  b1*b5' b2*b5' b3*b5' b4*b5' b5*b5' b6*b5' b8*b5'
      b0*b6'  b1*b6' b2*b6' b3*b6' b4*b6' b5*b6' b6*b6' b8*b6'
      b0*b8'  b1*b8' b2*b8' b3*b8' b4*b8' b5*b8' b6*b8' b8*b8'];
a = [f*b0'; f*b1'; f*b2'; f*b3'; f*b4'; f*b5'; f*b6'; f*b8'];

c = A\a;
fpx7 = c'*B;

figure
hold on
plot(t, f, "-", DisplayName="Hodnoty akcií")
plot(t, fp8, ":", DisplayName="Polynóm 8. stupňa")
plot(t, fpx7, "-", DisplayName="Bez bez zložky x^7")
srandicky_do_grafu("Polynomická regresia - Polynóm 8. stupňa bez zložky x^7")

% ------------------------ bez Q6 ---------------------------------------

B = [ b0; b1; b2; b3; b4; b5; b8 ];
A = [ b0*b0'  b1*b0' b2*b0' b3*b0' b4*b0' b5*b0' b8*b0'
      b0*b1'  b1*b1' b2*b1' b3*b1' b4*b1' b5*b1' b8*b1'
      b0*b2'  b1*b2' b2*b2' b3*b2' b4*b2' b5*b2' b8*b2'
      b0*b3'  b1*b3' b2*b3' b3*b3' b4*b3' b5*b3' b8*b3'
      b0*b4'  b1*b4' b2*b4' b3*b4' b4*b4' b5*b4' b8*b4'
      b0*b5'  b1*b5' b2*b5' b3*b5' b4*b5' b5*b5' b8*b5'
      b0*b8'  b1*b8' b2*b8' b3*b8' b4*b8' b5*b8' b8*b8'];
a = [f*b0'; f*b1'; f*b2'; f*b3'; f*b4'; f*b5'; f*b8'];

c = A\a;
fpx6 = c'*B;

figure
hold on
plot(t, f, "-", DisplayName="Hodnoty akcií")
plot(t, fp8, ":", DisplayName="Polynóm 8. stupňa")
plot(t, fpx7, "--", DisplayName="Polynóm 8. stupňa bez zložky x^7")
plot(t, fpx6, "-", DisplayName="Polynóm 8. stupňa bez zložky x^6")
srandicky_do_grafu("Polynomická regresia - Polynóm 8. stupňa bez zložky x^7 a x^6")


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
    filename = sprintf('zadanie3obrazky/figure_%d.png', i); 
    
    % Save the figure as PNG with specified resolution
    print(fig, filename, '-dpng', ['-r', num2str(resolution)]);
end

