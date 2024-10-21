% ortogonalizujte vektory u1 az u4

u1 = [1, 1, 1, 1];
u2 = [0, 1, 2, 3];
u3 = [0, 1, 4, 9];
u4 = [0, 1, 8, 27];

% vysledne vektory
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

t = [0, 1, 2, 3];

B = [ b1 
    b2 
    b3 
    b4 ]

plot(t,b1,'-', t,b2,'-', t,b3,'-', t,b4,'-', 0, 10)
grid on
