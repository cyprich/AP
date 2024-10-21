clear

format short
    
t = [ 0 1 2 3 4 ];
f = [ 0 0.5 1 4 8 ];


plot(t, f, "-*b")
grid on

% ---------------- regresna priamnka y = a + b.t + c.t^2

b0 = t.^0;
b1 = t.^1;
b2 = t.^2;

A = [ b0*b0' b1*b0' b2*b0' 
      b0*b1' b1*b1' b2*b1'
      b0*b2' b1*b2' b2*b2' ];

b = [ f*b0'
      f*b1'
      f*b2' ];

c = A\b;

fp = c(1)*b0 + c(2)*b1 + c(3)*b2;

(f - fp);

e = sqrt((f-fp) * (f-fp)')

plot(t, f, "-*b", t, fp, '-*r')
grid on


% -------- regresna kvadraticka funkcia 

tt = linspace(0, 4, 1000);
y = c(1) + c(2)*tt + c(3)*tt.^2;

plot(t, f, "-*b", t, fp, '-*r', tt, y, '-k')
grid on
