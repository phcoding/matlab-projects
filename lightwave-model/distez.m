function [ Ez ] = distez( m, n, r, o, z, f)
%DISTEZ 此处显示有关此函数的摘要
%   此处显示详细说明
try
    udata = load('u.mat');
catch
    error('Data file "u.mat" load failed !');
end
a = 1;k0 = 9e9;
n1=1.48+1e-4;
n2=1.48+1e-5;
A=1;C=1;

if f
    u = udata.u(m+1, n, 1);
else
    u = udata.u(m+1, n, 2);
end
r = r.*a;
k = u/a;
beta = sqrt((n1*k0)^2-k^2);
y = sqrt(beta^2-(n2*k0)^2);
Ez = zeros(length(r), length(o));
if min(r) >= 1
    Ez = C.*besselk(m, y.*r)'*exp(1i*m.*o+1i*beta.*z);
elseif max(r) <= 1
    Ez = A.*besselj(m, k.*r)'*exp(1i*m.*o+1i*beta.*z);
else
    indexs = 1:length(r);
    i = indexs(sort([r 1])==1);i = i(1)-1;    % 确定纤芯边界分割点
    Ez(1:i,:) = A.*besselj(m, k.*r(1:i))'*exp(1i*m.*o+1i*beta.*z);
    Ez((i+1):end,:) = C.*besselk(m, y.*r(i+1:end))'*exp(1i*m.*o+1i*beta.*z);
end
end

