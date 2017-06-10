function [ asig ] = opatten( opsig, atten )
%OPATTEN 光衰减器
%   opsig   输入光信号
%   atten   光衰减度（dB）
%   asig    返回衰减后的光信号

asig = opsig*10^(-atten/10);
end

