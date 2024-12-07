clear; close all;

import = readmatrix("matlabized_data2.csv");
t_full = import(:, 1)';
f_full = import(:, 2)';
l = length(f_full);  % pocet dat

figure; hold on; grid on; xlim([1 l])
plot(t_full, f_full, "-")

% function fp = f_ma(f, n)  % funkcia na vypocet AR(n), parametre su (data, n), vrati hodnotu fp
%     l = length(f);
% 
%     for i = 1:(n/2 + 1)
%         fprintf("---%d---\n", l)
%         disp(n/2+i)
%         disp(l-(n/2-i))
%         disp(n/2-i)
%         disp(l-(n/2+i))
% 
%         b{i} = f(n/2+i: l-(n/2-i));
%         b{i*2} = f((n/2-i): l-(n/2+i));
%     end
% 
%     for i = 1:n
%         B(i) = b{i};
%     end
% 
%     c = (f*B')*(B*B')^(-1);
%     fp = c*B;
% 
% end


% -------------------- MA(2) --------------------
f = f_full(2: l-2);
ma_2_t = t_full(2: l-2);

b1 = f_full(3: l-1);
b2 = f_full(1: l-3);
B = [b1; b2];

c = (f*B')*(B*B')^(-1);
ma_2_std = c*B;

% -------------------- MA(4) --------------------
f = f_full(4: l-4);
ma_4_t = t_full(4: l-4);

b1 = f_full(3: l-5);
b2 = f_full(2: l-6);
b3 = f_full(5: l-3);
b4 = f_full(6: l-2);
B = [b1; b2; b3; b4];

c = (f*B')*(B*B')^(-1);
ma_4_std = c*B;

% -------------------- MA(6) --------------------
f = f_full(6: l-6);
ma_6_t = t_full(6: l-6);

b1 = f_full(5: l-7);
b2 = f_full(4: l-8);
b3 = f_full(3: l-9);
b4 = f_full(7: l-5);
b5 = f_full(8: l-4);
b6 = f_full(9: l-3);
B = [b1; b2; b3; b4];

c = (f*B')*(B*B')^(-1);
ma_6_std = c*B;


figure; hold on; grid on; xlim([1, l]); legend;
plot(t_full, f_full, '-', DisplayName="Povodne data");
plot(ma_2_t, ma_2_std, '-', LineWidth=1.5,DisplayName="Standardna metoda MA(2)");

figure; hold on; grid on; xlim([1, l]); legend;
plot(t_full, f_full, '-', DisplayName="Povodne data");
plot(ma_2_t, ma_2_std,'--', DisplayName="Standardna metoda MA(2)");
plot(ma_4_t, ma_4_std,'-', LineWidth=1.5, DisplayName="Standardna metoda MA(4)");

figure; hold on; grid on; xlim([1, l]); legend;
plot(t_full, f_full, '-', DisplayName="Povodne data");
plot(ma_2_t, ma_2_std,'--', DisplayName="Standardna metoda MA(2)");
plot(ma_4_t, ma_4_std,'--', DisplayName="Standardna metoda MA(4)");
plot(ma_6_t, ma_6_std,'-', LineWidth=1.5, DisplayName="Standardna metoda MA(6)");




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
    filename = sprintf('zadanie6obrazky/figure_%d.png', i); 
    
    % Save the figure as PNG with specified resolution
    print(fig, filename, '-dpng', ['-r', num2str(resolution)]);
end

close all
