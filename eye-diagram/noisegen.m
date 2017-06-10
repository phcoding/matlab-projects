function [ pulse_noise,  noise_sig ] = noisegen( pulse, a, b )
%NOISE 给信号添加乘性和加性噪声
%   a   乘性噪声系数
%   b   加性噪声系数
%   pulse_niose     返回添加噪声后的光脉冲
%   noise_sig       返回添加的噪声信号

N = length(pulse);
% 生成乘性和加性噪声
% noise_sig = a*pluse.*(rand(1,N)-0.5)+b*(rand(1,N)-0.5);
noise_sig = a*pulse.*randn(1,N)+b*(rand(1,N)-0.5);
pulse_noise = pulse + noise_sig;
end

