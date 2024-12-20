% Generovanie pôvodného časového radu
original_series = rand(1, 100); % napr. náhodné hodnoty
n = 10; % dĺžka čiastočných radov
num_series = floor(length(original_series) / n);

% Vytváranie čiastočných časových radov
partial_series = zeros(num_series, n);
for i = 1:num_series
    partial_series(i, :) = original_series((i-1)*n + 1 : i*n);
end

% Zobrazenie časových radov
figure;
hold on;
for i = 1:num_series
    plot(1:n, partial_series(i, :));
end
xlabel('Časová os t');
ylabel('Hodnoty');
title('Čiastočné časové rady');
hold off;
