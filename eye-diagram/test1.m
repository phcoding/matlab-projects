clear;clc;
% 添加随机噪声，测试眼图生成

% 定义全局变量
brate = 1e10;       % 码率
btime = 1/brate;    % 单个脉冲时间
srate = 128*brate;  % 采样率
rtime = 0.05*btime; % 上升沿时间
ftime = 0.05*btime; % 下降沿时间
blen = 256;         % 字节码序列长度

%% 光发射机
% 随机字节码生成器：生成随机字节码序列
bits = bitseq(blen);
% 非归零码脉冲生成器：生成非归零码电脉冲
[pulse, times] = nrzpulse(bits, rtime, ftime, brate, srate);
% 添加时域可视化仪表
ht0 = optdvi(pulse, srate, '', 'r');
legend(ht0,{'脉冲原始信号'});
title(ht0,'原始信号时域图');
% 添加频域可视化仪表
hf0 = opspec(pulse, srate, '', 'b');
legend(hf0,{'脉冲原始信号'});
title(hf0,'原始信号频域图');
% optdvi(pulse,srate,subplot(121),'r');
% opspec(pulse,srate,subplot(122),'b');
% 光调制器：由电脉冲生成光脉冲，引入消光比
pulse_optic = modulate(pulse, 30);

%% 光接收机
% 光衰减器：模拟光纤传播能量衰减
pulse_atten = opatten(pulse_optic, 30);
% 光接收探头：添加随机噪声（量子噪声和暗电流噪声）
[pulse_noise, noise_sig] = noisegen(pulse_atten, 0.3, 0.2);

% 添加时域可视化仪表
ht1 = optdvi(pulse_noise, srate, '', 'b');
optdvi(noise_sig, srate, ht1, 'y');
optdvi(pulse_atten, srate, ht1, 'r');
legend(ht1,{'叠加原始信号','噪声原始信号','脉冲原始信号'});
title(ht1,'噪声处理时域图');
% 添加频域可视化仪表
hf1 = opspec(pulse_noise, srate, '', 'b');
opspec(noise_sig, srate, hf1, 'y');
opspec(pulse_atten, srate, hf1, 'r');
legend(hf1,{'叠加原始信号','噪声原始信号','脉冲原始信号'});
title(hf1,'噪声处理频域图');

% 高斯低通滤波器：过滤大部分噪声
[pulse_low,~,~,gauss_lf,fset] = gausslpf(pulse_atten, 0.75*brate, srate);
noise_low = gausslpf(noise_sig, 0.75*brate, srate);
pulse_noise_low = gausslpf(pulse_noise, 0.75*brate, srate);

% 添加时域可视化仪表
ht2 = optdvi(pulse_noise, srate, '', 'color',[0 0.8 0.6]);
optdvi(noise_low, srate, ht2, 'color',[1 0.8 0]);
optdvi(pulse_noise_low, srate, ht2, 'b');
optdvi(pulse_low, srate, ht2, 'color',[1 0 1]);
optdvi(pulse_atten, srate, ht2, 'r');
legend(ht2,{'叠加原始信号','噪声低通信号','叠加低通信号','脉冲低通信号','脉冲原始信号'});
title(ht2,'低通过滤时域图');
% 添加频域可视化仪表
hf2 = opspec(pulse_noise, srate, '', 'color',[0 1 1]);
opspec(pulse_atten, srate, hf2, 'y');
opspec(pulse_low, srate, hf2, 'r');
opspec(noise_low, srate, hf2, 'g');
opspec(pulse_noise_low, srate, hf2, 'b');
% 补充绘制高斯滤波曲线
hold on;plot(hf2,fset,gauss_lf,'color',[1 0 1]);hold off;
legend(hf2,{'叠加原始信号','脉冲原始信号','脉冲低通信号','噪声低通信号','叠加低通信号','高斯过滤曲线'});
title(hf2,'低通过率频域图');
% 眼图分析仪：绘制眼图
[eyeplot, heye] = eyediag(pulse_noise_low,2*btime,srate,0.5*btime,'','k');
title(heye,'最终信号眼图');