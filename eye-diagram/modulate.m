function [ opsig ] = modulate( elsig, ext )
%MODULATE 光信号调制器
%   elsig   输入电脉冲信号
%   ext     调制器消光比

k = 10^(ext/10);
% 防止分母出现0
if k < eps
    k = eps;
end
opsig = elsig*(k-1)/(k+1)+max(elsig)/(k-1);
end

