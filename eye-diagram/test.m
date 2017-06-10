clear;clc;

clear;clc;
% ¸ßË¹ÂË²¨²âÊÔ

brate = 1e10;
srate = 128e10;
rtime = 0.05/brate;
ftime = 0.05/brate;
blen = 300;

bits = bitseq(blen);
[pulse, time] = nrzpulse(bits, rtime, ftime, brate, srate);
[pulsel, pulse_fft, pulse_fft_lf, gauss_lf, fs] = gausslpf(pulse, 0.75*brate, srate);

figure;
hold on;
plot(fs, 2*abs(pulse_fft)/(blen*srate/brate),'b');
plot(fs, 2*abs(pulse_fft_lf)/(blen*srate/brate),'g');
plot(fs, gauss_lf,'r')

figure;
hold on;
plot(time, pulse,'b');
plot(time, pulsel,'r');