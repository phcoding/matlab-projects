clear;clc;
% 光脉冲的色散传播（脉冲展宽）
t = linspace(-20,20,400);
z = linspace(0,4,100);
lines = zeros(10, 400);
for i=1:100;
    sigma = 1+z(i);
    u = 0;
    pluse = gaussmf(t, [sigma u])/sigma;
    lines(i,:) = pluse;
end
[Z, T] = meshgrid(z, t);
% plot3(T,Z,lines');
surf(T,Z,lines');
shading interp;
xlabel('Pluse Width');
ylabel('Transmit Distance');