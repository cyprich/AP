clear

format short
    
t = [ 0 1 2 3 4 ];
f = [ 0 0.5 1 4 8 ];


plot(t, f, "-*b")
grid on

% ---------------- regresna priamnka y = a + b.t

b0 = t.^0;
b1 = t.^2;
%b1 = log(t+1)

A = [ b0*b0' b1*b0' 
      b0*b1' b1*b1' ];

b = [ f*b0'
      f*b1'];

c = A\b;

fp = c(1)*b0 + c(2)*b1;

(f-fp)

e = sqrt((f-fp) * (f-fp)')

plot(t, f, "-*b", t, fp, '-*r')
grid on
