function [SP_to30Hz,SP_to30Hz_ave] = f_STFT(x,sampling,df,window,winHannSwitch,num_freq)
%F_STFTの概要：脳波データの短時間フーリエ変換する処理
%   脳波データx(秒×サンプリング)を短時間フーリエ変換する。
SP = zeros(sampling,window);
XTr = zeros(sampling/2+1,window);%
SP_to30Hz = zeros(size(num_freq,2),window);%(行160列53)
x = x';
for i = 1:window
    if winHannSwitch == 1%ハニング窓
        x(:,i) = x(:,i) .* hann(sampling);
    end
    SP(:,i) = fft(x(:,i));
    XTr(:,i) = abs(SP(1:sampling/2+1,i)).^2/df;
    SP_to30Hz(:,i) = XTr(1+1:size(num_freq,2)+1,i);
end
SP_to30Hz_ave = sum(SP_to30Hz,2)/window;
% figure
% plot(freq,XTr_to50Hz_ave)

