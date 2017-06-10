function [ pulse, times ] = nrzpulse( bits, rtime, ftime, brate, srate )
%NRZPLUSE 非归零码脉冲生成器
%   bits    字节码数据流
%   rtime   上升沿时间
%   ftime   下降沿时间
%   brate   码率：bit rate = bits per second
%   srate   采样率：sample rate = sample length per second

bsl = length(bits);             % 字节码长度（个数）
btime = 1/brate;                % 一个字节码脉冲所占时长
tsl = round(bsl*btime*srate);   % 时间序列长度（总采样数）

% 生成上升边沿
rside = gaussmf(linspace(-rtime,0,round(srate*rtime)),[rtime/3,0]);
redge = [(rside-rside(1))/(1-rside(1)), ones(1, round((btime-rtime)*srate))];
% 生成下降边沿
fside = gaussmf(linspace(0,ftime,round(srate*ftime)),[ftime/3,0]);
fedge = [(fside-fside(end))/(1-fside(end)), zeros(1, round((btime-ftime)*srate))];
% 生成水平边沿
hedge = ones(1,round(btime*srate));
% 时间序列
times = linspace(0,bsl*btime, tsl);
% 脉冲信号流
pulse = zeros(1,tsl);

% 上一字节码备份
btmp = 0;
for i = 1:bsl
    % 拼接上升沿
    if btmp < bits(i)
        pulse(round((i-1)*btime*srate+1):round((i)*btime*srate)) = redge;
    end
    % 拼接下降沿
    if btmp > bits(i)
        pulse(round((i-1)*btime*srate+1):round((i)*btime*srate)) = fedge;
    end
    % 拼接水平沿
    if btmp == bits(i)
        pulse(round((i-1)*btime*srate+1):round((i)*btime*srate)) = hedge*bits(i);
    end
    % 更新字节备份
    btmp = bits(i);
end
end

