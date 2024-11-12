t = linspace(0, 7, 8);
f = [ 1 4 0 0 1 1 0 1 ];
close all;

for n = 1:8
    for k = 1:8
        H(n,k) = cos((n-1) * (k-1) * 2*pi / 8) + 1i * sin((n-1) * (k-1) * 2*pi / 8) ;
    end
end

c = f * H^(-1);
% c = fft(f)./8;

% druhy je najsilnejsi
fp1 = 1 + c(3) * H(3,:) + c(7) * H(7,:);

tt = linspace(0, 7, 10000);
y1 = 1 + 2*real(c(3)) * cos(tt*2*2*pi/8) - 2*imag(c(3)) * sin(tt*2*2*pi/8);
y2 = y1 + 2*real(c(2)) * cos(tt*1*2*pi/8) - 2*imag(c(2)) * sin(tt*1*2*pi/8);
y3 = y2 + 2*real(c(4)) * cos(tt*3*2*pi/8) - 2*imag(c(4)) * sin(tt*3*2*pi/8);
y4 = y3 + 2*real(c(5)) * cos(tt*4*2*pi/8) / 2;


hold on;
grid on;

plot(t, f, "-");
% plot(t, real(fp1), "-");
plot(tt, y1, "-");
plot(tt, y2, "-");
plot(tt, y3, "-");
plot(tt, y4, "-");
