% ULOHA 7
% ortogonalizujte polynomicku bazu 6 rozmerneho priestoru

t = linspace(0, 5, 6);  % [0, 1, 2, 3, 4, 5]

u1 = t.^0;
u2 = t.^1;
u3 = t.^2;
u4 = t.^3;
u5 = t.^4;
u6 = t.^5;

% polynomicka baza by bola u1 az u6

b1 = u1;

c21 = (u2 * b1') / (b1 * b1');
b2 = u2 - c21*b1;

c31 = (u3 * b1') / (b1 * b1');
c32 = (u3 * b2') / (b2 * b2');
b3 = u3 - (c31*b1 + c32*b2);

c41 = (u4 * b1') / (b1 * b1');
c42 = (u4 * b2') / (b2 * b2');
c43 = (u4 * b3') / (b3 * b3');
b4 = u4 - (c41*b1 + c42*b2 + c43*b3);

c51 = (u5 * b1') / (b1 * b1');
c52 = (u5 * b2') / (b2 * b2');
c53 = (u5 * b3') / (b3 * b3');
c54 = (u5 * b4') / (b4 * b4');
b5 = u5 - (c51*b1 + c52*b2 + c53*b3 + c54*b4);

c61 = (u6 * b1') / (b1 * b1');
c62 = (u6 * b2') / (b2 * b2');
c63 = (u6 * b3') / (b3 * b3');
c64 = (u6 * b4') / (b4 * b4');
c65 = (u6 * b5') / (b5 * b5');
b6 = u6 - (c61*b1 + c62*b2 + c63*b3 + c64*b4 + c65*b5);

B = [b1
    b2
    b3
    b4
    b5
    b6]



% ULOHA 8
% najdite suradnice vektorov v baze B
v1 = [4, 2, 0, 0, 2, 4];
v2 = [8, 5, 6, 6, 4, 2];
v3 = [0, 1, 4, 8, 16, 32];
v4 = [4, 2, 8, 3, 4, 0];
v5 = [0, 2, 6, 3, 1, 8];

% Bx = v   ->   x = B/v
v1B = B\v1';
v2B = B\v2';
v3B = B\v3';
v4B = B\v4';
v5B = B\v5';

% iba pre zobrazenie vektorov, actually baza by asi nedavala zmysel
B2 = [v1B'
    v2B'
    v3B'
    v4B'
    v5B']
