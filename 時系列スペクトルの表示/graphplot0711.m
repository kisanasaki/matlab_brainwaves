%%ウェーブレット変換を用いたアーチファクト除去後のスペクトルをTaskごとに選択して時系列で表示するプログラム
%ave_sp_time_createで生成したxlsxを入力して使う.


clear;
SUB =9;

TASK = 7;
T_record = 90;
fs = 512; 
sampling = 512*4;
shift = 512/2;

close all

dt = sampling/fs; df = 1/dt;
W_sampling = T_record/dt;
T_win = dt*W_sampling; 
T_shift = shift/fs;

time_X = (dt:T_shift:T_win); 


for i = 1:SUB
    x_theta(:,:,i) = readmatrix('theta_sheet1-9_cell1-7.xlsx',sheet=i);
    x_fmtheta(:,:,i) = readmatrix('fmtheta_sheet1-9_cell1-7.xlsx',sheet=i);
    x_alpha(:,:,i) = readmatrix('alpha_sheet1-9_cell1-7.xlsx',sheet=i);
    x_beta(:,:,i) = readmatrix('beta_sheet1-9_cell1-7.xlsx',sheet=i);
end
% 
% for i = 1:SUB
%     figure;
%     for j=1:TASK
%         plot(time_X,x_theta(:,j,i));
%         title(['SUB',num2str(i),'-theta']);
%         
%         hold on;
%     end
%     legend({'task1','task2','task3','Task4','Task5','Task6','Task7'},'Location','northwest')
% end

for i = [6 7 8]
    figure;
    for j= [4 5]
        plot(time_X,x_fmtheta(:,j,i));
        title(['SUB',num2str(i),'-fmtheta']);
        
        hold on;
    end
    %legend({'task1','task2','task3','Task4','Task5','Task6','Task7'},'Location','northwest')
    legend({'task4','task5'},'Location','northwest')
end

% for i = 1:SUB
%     figure;
%     for j=1:TASK
%         plot(time_X,x_alpha(:,j,i));
%         title(['SUB',num2str(i),'-alpha']);
%         hold on;
%     end
%     legend({'task1','task2','task3','Task4','Task5','Task6','Task7'},'Location','northwest')
% end

% for i = 1:SUB
%     figure;
%     for j=1:TASK
%         plot(time_X,x_beta(:,j,i));
%         title(['SUB',num2str(i),'-beta']);
%         hold on;
%     end
%     legend({'task1','task2','task3','Task4','Task5','Task6','Task7'},'Location','northwest')
% end
% 

% 積み上げ縦棒
% for i = 1:SUB
%     figure;
%     bar(time_X,x_theta(:,:,i),'stacked');
%     legend({'task1','task2','task3','Task4','Task5','Task6','Task7'},'Location','northwest')
% end
% 
% for i = 1:SUB
%     figure;
%     bar(time_X,x_fmtheta(:,:,i),'stacked');
%     legend({'task1','task2','task3','Task4','Task5','Task6','Task7'},'Location','northwest')
% end
% 
% for i = 1:SUB
%     figure;
%     bar(time_X,x_alpha(:,:,i),'stacked');
%     legend({'task1','task2','task3','Task4','Task5','Task6','Task7'},'Location','northwest')
% end
% 
% for i = 1:SUB
%     figure;
%     bar(time_X,x_beta(:,:,i),'stacked');
%     legend({'task1','task2','task3','Task4','Task5','Task6','Task7'},'Location','northwest')
% end