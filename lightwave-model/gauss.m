function [ p ] = gauss( x, sigma, mu )
%GAUSS 此处显示有关此函数的摘要
%   此处显示详细说明

p = exp(-(x-mu).^2./(2*sigma.^2))./(sigma*sqrt(2*pi));
end

