function [ ah, ph ] = optdvi( opsig, srate, varargin )
%OPTDVI 光学时域信号显示仪
%   opsig   光学信号
%   srate   信号采样率
%   [h]     绘图句柄

N = length(opsig);
ts = (0:N-1)/srate;
if ~isempty(varargin) && isfloat(varargin{1})
    ah = varargin{1};
    axes(ah);
    hold on;
    ph = plot(ah, ts, opsig, varargin{2:end});
    hold off;
else
    figure('name','Optical Time Domain Visualizer');
    ah = axes();
    ph = plot(ah, ts, opsig, varargin{2:end});
    title('');
    xlabel('Time(s)');
    ylabel('Power(w)');
end
set(ah, 'xlim', minmax(ts));
grid(ah, 'on');
end

