clear
close all;  % zavrie vsetky predchadzajuce figures

% nacitanie dat zo suboru
import = readmatrix("matlabized_data2.csv");
t = import(:, 1);
f = import(:, 2);

t = t';
f = f';

n = length(f) / 4;% dlzka jednej častí


function vetikalne_ciary()
    global n f t;  % aby boli variables pristupne vo funkcií    
    % xline(t(n), "--k")
    % xline(t(2*n), "--k")
    % xline(t(3*n), "--k")
    % xline(t(n)+1, "--k")
    % xline(t(2*n)+1, "--k")
    % xline(t(3*n)+1, "--k")
    n = 31;
    xline(n, "--k");
    xline(2*n, "--k");
    xline(3*n, "--k");
    xlim([1, 124])
end



% ------------------------------ Povôdné dáta ----------------------------
figure(NumberTitle="off")
hold on
plot(t, f, "-")
title("Dáta - hodnoty akcií spoločnosti EA")
xlabel("Počet dní od 1. 1. 2024")
ylabel("Hodnota akcie [$]")
xlim([1,124])
vetikalne_ciary()
dummy = plot(NaN, NaN,  "-k", "DisplayName", "Hodnoty akcií");
legend([dummy])



% --------------------------- Dáta rozdelit na 4 častí -------------------------
f_split = cell(1, 4);
t_split = cell(1, 4);
for i = 1:4
    f_split{i} = f((i - 1)*n+1 : i*n);
    t_split{i} = t((i - 1)*n+1 : i*n);
end

% plot jednotlive častí
figure(NumberTitle="off")
title("Porovnanie jednotlivých častí dát")
grid on
hold on
for i = 1:4
    plot(t_split{1}, f_split{i}, "-", "DisplayName", sprintf('%d. časť', i));
end
legend
xlim([1, n])
ylabel("Hodnota akcie [$]")
set(gca, "XTickLabel", [])


% plot jednotlive častí + center
figure(NumberTitle="off")
title("Porovnanie jednotlivých častí dát - vycentrované")
grid on
hold on 
for i = 1:4
    f_split{i} = f_split{i} - mean(f_split{i});
    plot(t_split{1}, f_split{i}, "-", "DisplayName", sprintf('%d. časť', i));
end
legend
xlim([1, n])
ylabel("Relatívna hodnota akcie [$]")
set(gca, "XTickLabel", [])



% -------------- ortonormalna mocninova baza 6 rozmerneho priestoru ------
u0 = t_split{1}.^0;
u1 = t_split{1}.^1;
u2 = t_split{1}.^2;
u3 = t_split{1}.^3;
u4 = t_split{1}.^4;
u5 = t_split{1}.^5;

b0 = u0;

c1 = (u1 * b0') / (b0 * b0');
b1 = u1 - c1*b0;

c20 = (u2 * b0') / (b0 * b0');
c21 = (u2 * b1') / (b1 * b1');
b2 = u2 - (c20*b0 + c21*b1);

c30 = (u3 * b0') / (b0 * b0');
c31 = (u3 * b1') / (b1 * b1');
c32 = (u3 * b2') / (b2 * b2');
b3 = u3 - (c30*b0 + c31*b1 + c32*b2);

c40 = (u4 * b0') / (b0 * b0');
c41 = (u4 * b1') / (b1 * b1');
c42 = (u4 * b2') / (b2 * b2');
c43 = (u4 * b3') / (b3 * b3');
b4 = u4 - (c40*b0 + c41*b1 + c42*b2 + c43*b3);

c50 = (u5 * b0') / (b0 * b0');
c51 = (u5 * b1') / (b1 * b1');
c52 = (u5 * b2') / (b2 * b2');
c53 = (u5 * b3') / (b3 * b3');
c54 = (u5 * b3') / (b3 * b3');
b5 = u5 - (c50*b0 + c51*b1 + c52*b2 + c53*b3 + c54*b4);

b0 = b0/norm(b0);
b1 = b1/norm(b1);
b2 = b2/norm(b2);
b3 = b3/norm(b3);
b4 = b4/norm(b4);
b5 = b5/norm(b5);

b = {b0, b1, b2, b3, b4, b5};

figure(NumberTitle="off")
hold on
grid on
for i = 1:6
    plot(t_split{1}, b{i}, "-", "DisplayName", sprintf("%d-rozmerný podpriestor", i))
end
legend
title("Ortonormálna mocninová báza 6-rozmerného podpriestoru")
xlim([1, n])
set(gca, "XTickLabel", [])


% ------- najst suradnice dat v ortog. mocninovej baze 6D podpriestoru --------
c_10 = (f_split{1} * b0') / (b0 * b0');
c_11 = (f_split{1} * b1') / (b1 * b1');
c_12 = (f_split{1} * b2') / (b2 * b2');
c_13 = (f_split{1} * b3') / (b3 * b3');
c_14 = (f_split{1} * b4') / (b4 * b4');
c_15 = (f_split{1} * b5') / (b5 * b5');

c_20 = (f_split{2} * b0') / (b0 * b0');
c_21 = (f_split{2} * b1') / (b1 * b1');
c_22 = (f_split{2} * b2') / (b2 * b2');
c_23 = (f_split{2} * b3') / (b3 * b3');
c_24 = (f_split{2} * b4') / (b4 * b4');
c_25 = (f_split{2} * b5') / (b5 * b5');

c_30 = (f_split{3} * b0') / (b0 * b0');
c_31 = (f_split{3} * b1') / (b1 * b1');
c_32 = (f_split{3} * b2') / (b2 * b2');
c_33 = (f_split{3} * b3') / (b3 * b3');
c_34 = (f_split{3} * b4') / (b4 * b4');
c_35 = (f_split{3} * b5') / (b5 * b5');

c_40 = (f_split{4} * b0') / (b0 * b0');
c_41 = (f_split{4} * b1') / (b1 * b1');
c_42 = (f_split{4} * b2') / (b2 * b2');
c_43 = (f_split{4} * b3') / (b3 * b3');
c_44 = (f_split{4} * b4') / (b4 * b4');
c_45 = (f_split{4} * b5') / (b5 * b5');


C = [c_10 c_11 c_12 c_13 c_14 c_15
    c_20 c_21 c_22 c_23 c_24 c_25
    c_30 c_31 c_32 c_33 c_34 c_35
    c_40 c_41 c_42 c_43 c_44 c_45]




% ------------ zobrazit postupne vycentrovane Dáta + priemety -----------
b = {b1, b2, b3, b4, b5};


% pre kazde b (priemet do b-rozmerného priestoru)
for i = 1:5
    figure(NumberTitle='off');

    hold on
    grid on
    for j = 1:4
        plot(t_split{j}, f_split{j}, "-b")
        plot(t_split{j}, C(j, i+1) * b{i}, "-r")
    end
    vetikalne_ciary()
    title(sprintf("Priemet dát na bázický vektor %d-rozmerného podpriestoru", i+1))
    xlabel("Počet dní od 1. 1. 2024")
    ylabel("Relatívna hodnota akcie [$]")
    
    dummy1 = plot(NaN, NaN, "-b", "DisplayName", "Povôdné dáta");
    dummy2 = plot(NaN, NaN,  "-r", "DisplayName", sprintf("Priemet v %d-rozmernom priestore", i+1));
    legend([dummy1, dummy2])

    hold off
end




% ---------------------------------------- Aproximácia -----------------

figure(NumberTitle='off');
for i = 1:4
    hold on
    grid on
    for j = 1:4
        plot(t_split{i}, f_split{i}, "-b")
        plot(t_split{i}, C(i, 3) * b{2}, "--r")
        plot(t_split{i}, C(i, 2)*b{1} + C(i, 3)*b{2}, "-k", LineWidth=1.5)
    end
    vetikalne_ciary()
    title("Aproximácia pomocou prvých dvoch najvýznamnejších mocninových trendov")
    xlabel("Počet dní od 1. 1. 2024")
    ylabel("Relatívna hodnota akcie [$]")

    dummy1 = plot(NaN, NaN, "-b", "DisplayName", "Povôdné dáta");
    dummy2 = plot(NaN, NaN,  "--r", "DisplayName", "Priemet na bázický vektor 2-rozmerného priestoru");
    dummy3 = plot(NaN, NaN,  "-k", "LineWidth", 1.5, "DisplayName", "Aproximácia - prvé 2 trendy");
    legend([dummy1, dummy2, dummy3])
    hold off
end

figure(NumberTitle='off');
for i = 1:4
    hold on
    grid on
    for j = 1:4
        plot(t_split{i}, f_split{i}, "-b")
        plot(t_split{i}, C(i, 4) * b{3}, "--r")
        plot(t_split{i}, C(i, 2)*b{1} + C(i, 3)*b{2} + C(i, 4)*b{3}, "-k", LineWidth=1.5)
    end
    vetikalne_ciary()
    title("Aproximácia pomocou prvých troch najvýznamnejších mocninových trendov")
    xlabel("Počet dní od 1. 1. 2024")
    ylabel("Relatívna hodnota akcie [$]")

    dummy1 = plot(NaN, NaN, "-b", "DisplayName", "Povôdné dáta");
    dummy2 = plot(NaN, NaN,  "--r", "DisplayName", "Priemet na bázický vektor 3-rozmerného priestoru");
    dummy3 = plot(NaN, NaN,  "-k", "LineWidth", 1.5, "DisplayName", "Aproximácia - prvé 3 trendy");
    legend([dummy1, dummy2, dummy3])
    ylim([-8, 8])
    hold off
end

figure(NumberTitle='off');
for i = 1:4
    hold on
    grid on
    for j = 1:4
        plot(t_split{i}, f_split{i}, "-b")
        plot(t_split{i}, C(i, 5) * b{4}, "--r")
        plot(t_split{i}, C(i, 2)*b{1} + C(i, 3)*b{2} + C(i, 4)*b{3} + C(i, 5)*b{4}, "-k", LineWidth=1.5)
    end
    vetikalne_ciary()
    title("Aproximácia pomocou prvých štyroch najvýznamnejších mocninových trendov")
    xlabel("Počet dní od 1. 1. 2024")
    ylabel("Relatívna hodnota akcie [$]")

    dummy1 = plot(NaN, NaN, "-b", "DisplayName", "Povôdné dáta");
    dummy2 = plot(NaN, NaN,  "--r", "DisplayName", "Priemet na bázický vektor 4-rozmerného priestoru");
    dummy3 = plot(NaN, NaN,  "-k", "LineWidth", 1.5, "DisplayName", "Aproximácia - prvé 4 trendy");
    legend([dummy1, dummy2, dummy3])
    hold off
end

figure(NumberTitle='off');
for i = 1:4
    hold on
    grid on

    for j = 1:4
        plot(t_split{i}, f_split{i}, "-b")
        plot(t_split{i}, C(i, 6) * b{5}, "--r")
        plot(t_split{i}, C(i, 2)*b{1} + C(i, 3)*b{2} + C(i, 4)*b{3} + C(i, 5)*b{4} + C(i, 6)*b{5}, "-k", LineWidth=1.5)
    end
    vetikalne_ciary()
    title("Aproximácia pomocou prvých piatich najvýznamnejších mocninových trendov")
    xlabel("Počet dní od 1. 1. 2024")
    ylabel("Relatívna hodnota akcie [$]")

    dummy1 = plot(NaN, NaN, "-b", "DisplayName", "Povôdné dáta");
    dummy2 = plot(NaN, NaN,  "--r", "DisplayName", "Priemet na bázický vektor 5-rozmerného priestoru");
    dummy3 = plot(NaN, NaN,  "-k", "LineWidth", 1.5, "DisplayName", "Aproximácia - prvých 5 trendov");
    legend([dummy1, dummy2, dummy3])
    hold off
end

figure(NumberTitle='off');
for i = 1:4
    hold on
    grid on
    for j = 1:4
        plot(t_split{i}, f_split{i}, "-b")
        plot(t_split{i}, C(i, 2)*b{1} + C(i, 3)*b{2}, "--r")
        %plot(t_split{i}, C(i, 2)*b{1} + C(i, 3)*b{2} + C(i, 4)*b{3}, "--g", LineWidth=1.2)
        %plot(t_split{i}, C(i, 2)*b{1} + C(i, 3)*b{2} + C(i, 4)*b{3} + C(i, 5)*b{4}, "--b", LineWidth=1.4)
        plot(t_split{i}, C(i, 2)*b{1} + C(i, 3)*b{2} + C(i, 4)*b{3} + C(i, 5)*b{4} + C(i, 6)*b{5}, "-k", LineWidth=1.2)
    end
    vetikalne_ciary()
    title("Porovnanie prvej a poslednej aproximácie")
    xlabel("Počet dní od 1. 1. 2024")
    ylabel("Relatívna hodnota akcie [$]")

    dummy1 = plot(NaN, NaN, "--r", DisplayName="Prvé 2");
    %dummy2 = plot(NaN, NaN, "-.g", DisplayName="Prvé 3");
    %dummy3 = plot(NaN, NaN, "--b", DisplayName="Prvé 4");
    dummy4 = plot(NaN, NaN, "-k", DisplayName="Prvých 5", LineWidth=1.2);

    legend([dummy1, dummy4])
    hold off
end


% -------------------------------- exportovanie obrazkov -----------------
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
    filename = sprintf('zadanie2/figure_%d.png', i); 
    
    % Save the figure as PNG with specified resolution
    print(fig, filename, '-dpng', ['-r', num2str(resolution)]);
end


