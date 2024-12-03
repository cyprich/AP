clear all;
close all;
format short;

% vyska, vaha
X = [192 111
    189 54
    175 76
    185 90
    189 77
    170 90
    162 50
    176 68
    184 70
    168 58
    181 100
    188 100
    172 58
    175 58];

% vycentrovat
m = mean(X);

X0 = X-m;


% kovariancna matica (vsetky zapisy spravia to iste)
% R = cov(X);
% R = cov(X0);
% R = X0' * X0 / 13;  % 13 = pocet - 1

R = [84 123
    84 349]


% korelacna matica - scale R
% r = corrcoef(X);  % na toto zabudnut aby sme sa nepomyl


% vlastne cisla
[U, S, V] = svd(R);
%{
vlastne cisla = S
vlastne vektory = U
? = V
%}


C = X0 * U;

-C(:, 1)  % taky ten ony co sa aj na tabulu pocital (tu je s vycentrovanymi datami)

% nepovinna jazda
% t = linspace(-80, 80, 1000);
% x(t) = t * U(1, 1);
% y(t) = t * U(1, 2);
% % koniec nepovinnej jazdy
% 
% hold on;
% plot(X0(:, 1), X0(:, 2), "*")
% plot(x, y)


% -----------------------------------------------


X = [
    1	2	2	3	4	1	1
    1	3	3	5	4	3	1
    1	1	1	2	1	1	2
    1	1	1	1	1	5	3
    3	4	3	3	3	2	1
    2	3	1	4	2	5	2
    2	2	2	5	4	5	1
    3	2	3	4	4	3	1
    2	1	2	5	3	4	1
    5	5	3	4	2	1	1
    2	2	2	4	2	2	1
    ]

R = cov(X);  % kovariacia
% R = corrcoef(X);  % korelacia
%{
medzi algebrou a mpi je vazba, lebo je vysoka (korelacia?)
%}

[U, S, V] = svd(R);
diag(R)

C = X*U

L = diag(S)
figure
plot(L)

figure
hold on
grid on
plot(C(:, 1), C(:, 2), "*b")
info2 = (L(1) + L(2))/sum(L);  % odchylka? 

figure
hold on
grid on
plot3(C(:, 1), C(:, 2), C(:, 3), "b*")
info3 = (L(1) + L(2) + L(3))/sum(L);  % odchylka? 

% figure;
% hold on
% plot(X(:, 1), X(:, 2))
