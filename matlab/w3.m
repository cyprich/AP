clear

format short
    
t = [ 0 1 2 3 4 5 ];
f = [ 1 2 16 3 0 7 ];


u0 = t.^0;
u1 = t.^1;
u2 = t.^2;
u3 = t.^3;
u4 = t.^4;
u5 = t.^5;
u6 = t.^6;


b0 = u0;

c = (u1 * b0') / (b0*b0')
b1 = u1 - c * b0

c1 = (u2 * b0') / (b0*b0')
c2 = (u2 * b1') / (b1*b1')
b2 = u2 - (c1 * b0 + c2 * b1)

c1 = (u3 * b0') / (b0*b0')
c2 = (u3 * b1') / (b1*b1')
c3 = (u3 * b2') / (b2*b2')
b3 = u3 - (c1 * b0 + c2 * b1 + c3 * b2)

c1 = (u4 * b0') / (b0*b0')
c2 = (u4 * b1') / (b1*b1')
c3 = (u4 * b2') / (b2*b2')
c4 = (u4 * b3') / (b3*b3')
b4 = u4 - (c1 * b0 + c2 * b1 + c3 * b2 + c4 * b3)

c1 = (u5 * b0') / (b0*b0')
c2 = (u5 * b1') / (b1*b1')
c3 = (u5 * b2') / (b2*b2')
c4 = (u5 * b3') / (b3*b3')
c5 = (u5 * b4') / (b4*b4')
b5 = u5 - (c1 * b0 + c2 * b1 + c3 * b2 + c4 * b3 + c5 * b4)


c0 = (f*b0') / (b0*b0');
c1 = (f*b1') / (b1*b1');
c2 = (f*b2') / (b2*b2');
c3 = (f*b3') / (b3*b3');

C = [ c0 c1 c2 c3 c4 c5 ]


plot(t,b0,'--', t,b1,'--', t,b2,'--', t,b3,'--', t,b4,'--', t,b5,'--', t,f,'-k*', 0, 10)
grid on

C = [ c0 c1 c2 c3 c4 c5 ]

% plot(t, f, "", 0, 10)