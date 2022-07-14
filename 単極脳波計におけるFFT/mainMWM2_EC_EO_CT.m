% 概要：20212/17に行った多人数同時脳波計測実験のデータ（Aグループ、Bグループ）の前処理、
% 時系列信号のプロット、FFT、平均スペクトルのプロット。それぞれをエクセルで保存（処理は長い）。

%% 変数の宣言
clear
SUB = 1;
TASK = 7;

group = [1]; % グループ数、A=1, B=2
%[1 2]
no = 1; %UserNo
% [1 2 3 4 5 6 7 8]


T_record = 90; % 解析したいブロック間の秒数
task = 1; % EyesClose=1,EyesOpen=2,CalculateTask=3
fs = 512; % MindwaveMobile2のサンプリング周波数は512Hzで固定。
sampling = 512*4; % FFTをするサンプリング数
shift = 512/2;
winHannSwitch = 1;%ハニング窓1だと指定あり
ch = 1; % 単極脳波計は常に１チャンネル
f_max = 30; % スペクトルの周波数の最大値を指定する変数

close all
R = {'A1'}; % s_aveの書き込みのためのエクセル範囲指定（タスク個数）
dt = sampling/fs; df = 1/dt;%dt = 4,df:周波数分解能
W_sampling = T_record/dt;%fix->各要素をゼロ方向の最も近い整数に丸めます（小数点以下切り捨て）
%fix(30/4)->7
T_win = dt*W_sampling; %
T_shift = shift/fs;%256/512=>1/2
% windowsの時間や周波数を作成する
time_X = (dt:T_shift:T_win); %dt=4から30まで0.5ずつ=53
time_Y = (0:1/fs:T_record-1/fs);
freq = (df:df:f_max);%1/4から1/4刻みで40まで
win_shift = size(time_X,2);%time_Xの横のマス数
if sampling == shift % 2048=256
    window = fix(T_record/dt);%30/4=7.5->7
else 
    window = win_shift;%53
end

s = [];s_ave = [];y=[];x=[];
%%T
for i = group
    for j = 1:no
        for k = 1:task
            filename = 'SUB2_TASK2_nonart.xlsx';
            %filename = ['SUB',num2str(j),'_TASK7_out.xlsx'];
            y(:,k) = readmatrix(filename,"sheet",k,"Range","B2");%繰り返しの数だけkが更新->1~8
%             y(:,k) = y(:,k)/4.55; % NeuroSky式
%             y(:,k) = detrend(y(:,k)); % データのトレンド除去
            
            % 時間幅の分割（x）とスペクトル解析（s,s_ave）
            x(:,:,k) = f_X_inputY(y(:,k),sampling,shift,window);%三次元配列xのk番目のページ
            %x(:,i) = y(a:b,1);（f_X_inputYのなの一部）->行列xのi番目の列 = 行列yの
            [s(:,:,k),s_ave(:,k)] = f_STFT(x(:,:,k),sampling,df,window,winHannSwitch,freq);
            %excel全てのマス（K番目のシート） アーティファクト除去用

             %FFTしたあとの値がx
%              writematrix(x(:,:,1),['OutputRawdataWin_1217_No'...
%                  ,num2str(j),'_Task',num2str(k),'.xlsx'],'Sheet',1);
%              
%              writematrix(y(:,1),['OutputRawdataY_1217_No'...
%                  ,num2str(j),'_Task',num2str(k),'.xlsx'],'Sheet',1);
% 
%              writematrix(s(:,:,1),['OutputSP_1217_No'...
%                  ,num2str(j),'_Task',num2str(k),'.xlsx'],'Sheet',1);
        end
        
        fig1 = figure;
        for k = 1:task
            % 時系列脳波のプロット
            subplot(task,1,k)
            plot(time_Y,y(:,k))
            title(['Task',num2str(j),' ch1'])
           %ylim([-200  200])
           %saveas(gcf,['Task',num2str(j),'_time'],'png');
        end
        
        fig2 = figure; % fig処理のために分割する
        for k = 1:task
            plot(freq,s_ave(:,k))
            hold on
            %writematrix(s_ave(:,k),['OutputAVE_SP_1217_No',num2str(j),'.xlsx'],'Sheet',1,'Range',['',num2str(R{1,k}),'']);
            title(['Task',num2str(j),' ch1'])
%             legend("task1","rest1","task2","rest2","task3","rest3")
            xlim([freq(:,1) freq(:,end)])
            ylim([0 5e8])

        end
    end
end