function [ pulselp, pulse_fft, pulse_fft_lf, gauss_lf, fset ] = gausslpf( pulse, cfreq, srate )
%GAUSSLPF 高斯低通滤波器
%   此处显示详细说明

plen = length(pulse);
N = 2^nextpow2(plen);
n = 0:N-1;
% 获取真实频率区间，并将低频区域移到中间
fset = n*srate/N-srate/2;
pulse_fft = fftshift(fft(pulse,N));
% 生成高斯低通过滤器
gauss_lf = gaussmf(fset, [cfreq/sqrt(2*log(2)),0]);
% 频域滤波
pulse_fft_lf = pulse_fft.*gauss_lf;
% 还原到时域信号
pulselp = ifft(fftshift(pulse_fft_lf),N);
pulselp = pulselp(1:plen);
end

