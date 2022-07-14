% main2後、70μVの瞬きアーチファクトを除去する処理

day = 1;
sub = [1];
task = 1;

T_record = 90;
fs = 512;
sampling = 512*4; 
shift = 512/2;
winHannSwitch = 1;% 1はハニング窓あり
ch = 1; % 単極脳波計は常に１チャンネル
f_max = 30; % スペクトルの周波数の最大値を指定する変数

close all
R = {'A1' 'B1' 'C1' 'D1'}; % s_aveの書き込みのためのエクセル範囲指定（タスク個数）
dt = sampling/fs; df = 1/dt;%dt = 4,df=1/4
W_sampling = T_record/dt;%W_sampling=10fix->各要素をゼロ方向の最も近い整数に丸めます（小数点以下切り捨て）
T_win = dt*W_sampling; %T_win=40
T_shift = shift/fs;%T_shift=256/512=1/2
% windowsの時間や周波数を作成する
time_X = (dt:T_shift:T_win); %dt=4からまで1/2ずつ40まで
time_Y = (0:1/fs:T_record-1/fs);
freq = (df:df:f_max);
win_shift = size(time_X,2);
if sampling == shift
    window = fix(T_record/dt);
else 
    window = win_shift;
end
%ここのサイズとあってないみたい
x= zeros(window,sampling,ch);
s= zeros(size(freq,2),window,ch);
new_x = []; new_s = []; s_ave = [];

for i = 1:day
    i
    for j = sub
        j
        for k = 1:task
            k
            for l = 1:ch
                new_x = []; new_s = [];
                x(:,:,l) = readmatrix(['OutputRawdataWin_1217_No',num2str(j),'_Task1.xlsx'],'Sheet',l);
                s(:,:,l) = readmatrix(['OutputSP_1217_No',num2str(j),'_Task1.xlsx'],'Sheet',l);
                [new_x(:,:,l),new_s(:,:,l)] = f_artifact70(x(:,:,l),s(:,:,l));%アーチファクト除去の処理
                s_ave(:,k,l) = mean(new_s(:,:,l),2);%53列160行のデータを平均化->1列160行(30s)
                writematrix(new_x(:,:,l),['MWM2_NonArt_OutputRawdata_day(',num2str(i),')_Sub',num2str(j),'_Task',num2str(k),'.xlsx'],'Sheet',l);
                writematrix(new_s(:,:,l),['MWM2_NonArt_OutputSP_day(',num2str(i),')_Sub',num2str(j),'_Task',num2str(k),'.xlsx'],'Sheet',l);
            end
        end
        fig2 = figure; % fig処理のために分割する
        for k = 1:task
            plot(freq,s_ave(:,k))
            hold on
            writematrix(s_ave(:,k),['MWM2_NonArt_OutputAVE_SP_day(',num2str(i),')_Sub',num2str(j),'.xlsx'],'Sheet',1,'Range',['',num2str(R{1,k}),'']);
            title(['day',num2str(i),' sub',num2str(j),' ch1'])
            legend("task1","task2","task3","task4")
            xlim([freq(:,1) freq(:,end)])
            ylim([0 10e6])
        end
        filename = ['NonArtMWM2_Fp1_SP_day',num2str(i),'Sub',num2str(j),''];
        %savefig(fig2,filename)
        %saveas(gcf,['NonTask',num2str(j),'_sp'],'png');
    end
end