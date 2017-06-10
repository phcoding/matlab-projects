function [ bits ] = bitseq( nb )
%BITSEQ 随机字节码生成器
%   nb      字节码序列长度
%   bits    返回生成的指定长度的随机字节码

bits = 1e3*(randi(2, 1, nb) - 1);
end

