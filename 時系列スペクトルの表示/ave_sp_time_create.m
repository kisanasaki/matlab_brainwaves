%%被験者毎に分析をするために、FFT(4s0.5shift)した後のexcelから各秒の帯域パワーを算出するプログラム、これを統計分析する。
%被験者数とタスクの設定
clear;
SUB = 9;
TASK = 7;
BAND = 4;
range = 173;

%帯域の指定（excelのセル番号）
theta = 16:28;%4-7
fmtheta = 24:28;%6-7
alpha = 32:48;%8-12
beta = 52:120;%13-30


for i = 1:SUB
    for j = 1:TASK
        filename = ['OutputSP_1217_No',num2str(i),'_Task',num2str(j),'.xlsx'];
        x(:,:,i,j) = readmatrix(filename);

        %被験者毎タスクごとに4つの帯域二分割する
        t_theta(:,:,i,j) = x(theta,:,i,j);
        t_fmtheta(:,:,i,j) =  x(fmtheta,:,i,j);
        t_alpha(:,:,i,j) =  x(alpha,:,i,j);
        t_beta(:,:,i,j) =  x(beta,:,i,j);
        

    end
end

for i = 1:SUB
    for j = 1:TASK
       r_theta(:,:,i,j) = sum(t_theta(:,:,i,j));
       r_fmtheta(:,:,i,j) = sum(t_fmtheta(:,:,i,j));
       r_alpha(:,:,i,j) = sum(t_alpha(:,:,i,j));
       r_beta(:,:,i,j) = sum(t_beta(:,:,i,j));
    end
end

x_theta = squeeze(r_theta);
x_fmtheta = squeeze(r_fmtheta);
x_alpha = squeeze(r_alpha);
x_beta = squeeze(r_beta);


for i = 1:SUB
    writematrix(x_theta(:,i,:),'theta_sheet1-9_cell1-7.xlsx','Sheet',i);
    writematrix(x_fmtheta(:,i,:),'fmtheta_sheet1-9_cell1-7.xlsx','Sheet',i);
    writematrix(x_alpha(:,i,:),'alpha_sheet1-9_cell1-7.xlsx','Sheet',i);
    writematrix(x_beta(:,i,:),'beta_sheet1-9_cell1-7.xlsx','Sheet',i);
end

