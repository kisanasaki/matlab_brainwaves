%%離散ウェーブレット変換によるノイズ除去

T_record = 90;
fs = 512;
time_Y = (0:1/fs:T_record-1/fs);

SUB = 2;
TASK = 2;
% 
for j = 1:SUB
    for i = 1:TASK
        filename_in = ['SUB',num2str(j),'_TASK',num2str(i),'_outのコピー.xlsx'];
        %filename_in = 'sample_out.xlsx';
        filename_out = 'sample_aa.xlsx';
        %filename_out = ['SUB',num2str(j),'_TASK',num2str(i),'_nonart.xlsx'];
        wecg = readmatrix(filename_in);
        wecg = wecg/4.55; % NeuroSky式
        wecg = detrend(wecg); % データのトレンド除去
        
        %ノイズ除去
        %アーチファクトを含む脳波信号に離散ウェーブレット変換を適用し，基底関数としてSymlet（sym3）を使用して8つのレベルに分解する．
        %レベル毎に平均二乗誤差を用いたミニマックス推定によりしきい値を求め，ハードなしきいち値処理を行いノイズの除去を行う。
        %XXX:wdenは非推奨であり、wdenoiseが最新の関数なので使えなくなる可能性がある
        %wdenoiseの関数での指定方法がわからなかったため、wdenを使用した
        
        % xden = wdenoise(xrec,8,Wavelet="sym3", ...
        %     DenoisingMethod="Minimax",ThresholdRule="Hard");
        
        xden = wden(wecg,'minimaxi','h','mln',8,'sym3');
        
        %残差を計算する
        
        xx = wecg - xden;

        figure;
        plot(time_Y,wecg);
        ylim([-200  200]);
        hold on;
        plot(time_Y,xx);
        ylim([-200  200])

        %writematrix(xx,filename_out,'Range','B2');
    end 
end




%%https://jp.mathworks.com/help/wavelet/ref/wdenoise.html#d123e28444
%https://jp.mathworks.com/help/wavelet/ug/wavelet-denoising-and-nonparametric-function-estimation.html
%https://jp.mathworks.com/help/wavelet/ref/thselect.html