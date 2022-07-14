clear

no = 4;
fb = [1 2 3 4 5];

fs = 512;
sampling = 512*4;
%θ(4~7Hz),Fmθ(6~7Hz),α(8~12Hz),β(13~30Hz),γ(30~40Hz)
%周波数帯域を設定
f_max = 40;
fno = [0 3];%除外する帯域
fT = [4 7];
fFT = [6 7];
fA = [8 12];
fB = [13 30];
fG = [30 40];

close all % figureが消える
dt = sampling/fs; df = 1/dt;
freq = (df:df:f_max);
s = [];s_ave = [];
for j = 1:no
    % l = 1 % ch1はFp1共通
    %アーチファクト除去後のファイルを使用する160*53
    s_aveFp1(:,:,j) = readmatrix(['MWM2_NonArt_OutputAVE_SP_day(1)_Sub'...
        ,num2str(j),'.xlsx'],'Sheet',1);
    s_aveFp1Freq(:,:,j) = [freq' s_aveFp1(:,:,j)];
    % 周波数
    
    Fp1_Theta(:,:,j) = s_aveFp1Freq(s_aveFp1Freq(:,1,j) >= fT(1,1) & s_aveFp1Freq(:,1,j) <= fT(1,2),:,j);
    Fp1_FmTheta(:,:,j) = s_aveFp1Freq(s_aveFp1Freq(:,1,j) >= fFT(1,1) & s_aveFp1Freq(:,1,j) <= fFT(1,2),:,j);
    Fp1_Alpha(:,:,j) = s_aveFp1Freq(s_aveFp1Freq(:,1,j) >= fA(1,1) & s_aveFp1Freq(:,1,j) <= fA(1,2),:,j);
    Fp1_Beta(:,:,j) = s_aveFp1Freq(s_aveFp1Freq(:,1,j) >= fB(1,1) & s_aveFp1Freq(:,1,j) <= fB(1,2),:,j);
    Fp1_Gamma(:,:,j) = s_aveFp1Freq(s_aveFp1Freq(:,1,j) >= fG(1,1) & s_aveFp1Freq(:,1,j) <= fG(1,2),:,j);
end

%正規化
%Fp1_Theta

Ptheta = sum(Fp1_Theta,1);
Pfmtheta = sum(Fp1_FmTheta,1);
Palpha = sum(Fp1_Alpha,1);
Pbeta = sum(Fp1_Beta,1);
Pgamma = sum(Fp1_Gamma,1);

%%
%被験者ごとの平均値を求める（新しく追加）
for j = 1:no
    P_theta_av(j,:) = mean(Fp1_Theta(:,:,j));
    P_fmtheta_av(j,:) = mean(Fp1_FmTheta(:,:,j));
    P_alpha_av(j,:) = mean(Fp1_Alpha(:,:,j));
    P_beta_av(j,:) = mean(Fp1_Beta(:,:,j));
    P_gamma_av(j,:) = mean(Fp1_Gamma(:,:,j));
end 

% 正規化をする
 for j = 1:no
     %EOのものを使う
     normalization_Theta(:,:,j) = (Fp1_Theta(:,:,j) - nomal_A2_theta(j))/ nomal_A2_theta(j);
     normalization_Alpha(:,:,j) = (Fp1_Alpha(:,:,j) - nomal_A2_alpha(j))/ nomal_A2_alpha(j);
     normalization_Beta(:,:,j) = (Fp1_Beta(:,:,j) - nomal_A2_beta(j))/ nomal_A2_beta(j);
     normalization_FmTheta(:,:,j) = (Fp1_FmTheta(:,:,j) - nomal_A2_fmtheta(j))/ nomal_A2_fmtheta(j);
     normalization_Gamma(:,:,j) = (Fp1_Gamma(:,:,j) - nomal_A2_gamma(j))/ nomal_A2_gamma(j);
 end

 for j = 1:no
    P_theta_av_nomal(j,:) = mean(normalization_Theta(:,:,j));
    P_fmtheta_av_nomal(j,:) = mean(normalization_FmTheta(:,:,j));
    P_alpha_av_nomal(j,:) = mean(normalization_Alpha(:,:,j));
    P_beta_av_nomal(j,:) = mean(normalization_Beta(:,:,j));
    P_gamma_av_nomal(j,:) = mean(normalization_Gamma(:,:,j));
 end 

%%
%グラフの出力（被験者ごとの平均）
figure;
subplot(1,1,1)
bar(P_alpha_av_nomal(:,2))
%bar(P_alpha_av(:,2))
title('CT:Alpha')
xlabel('Sub')
ylabel('Power(Average)')
saveas(gcf,'A1_CT_Alpha','png');

figure;
subplot(1,1,1)
bar(P_beta_av_nomal(:,2))
%bar(P_beta_av(:,2))
title('CT:Beta')
xlabel('Sub')
ylabel('Power(Average)')
saveas(gcf,'A1_CT_Beta','png');

figure;
subplot(1,1,1)
bar(P_fmtheta_av_nomal(:,2))
%bar(P_fmtheta_av(:,2))
title('CT:FmTheta')
xlabel('Sub')
ylabel('Power(Average)')
saveas(gcf,'A1_CT_FmTheta','png');


figure;
subplot(1,1,1)
bar(P_theta_av_nomal(:,2))
%bar(P_theta_av(:,2))
title('CT:Theta')
xlabel('Sub')
ylabel('Power(Average)')
saveas(gcf,'A1_CT_Theta','png');

figure;
subplot(1,1,1)
bar(P_gamma_av_nomal(:,2))
%bar(P_gamma_av(:,2))
title('CT:Gamma')
xlabel('Sub')
ylabel('Power(Average)')
saveas(gcf,'A1_CT_Gamma','png');




%%
% 被験者の平均
for j = 1:no
    P_th(j,:) = Ptheta(:,:,j);
    P_fmth(j,:) = Pfmtheta(:,:,j);
    P_al(j,:) = Palpha(:,:,j);
    P_be(j,:) = Pbeta(:,:,j);
    P_ga(j,:) = Pgamma(:,:,j);
    
end
%%

%平均値(mean)と標準偏差(std)を求める
%選んだタスクの被験者全員の周波数帯域ごとの平均
Pave_th = mean(P_th,1);
Pstd_th = std(P_th,1);
Pave_fmth = mean(P_fmth,1);
Pstd_fmth = std(P_fmth,1);
Pave_al = mean(P_al,1);
Pstd_al = std(P_al,1);
Pave_be = mean(P_be,1);
Pstd_be = std(P_be,1);
Pave_ga = mean(P_ga,1);
Pstd_ga = std(P_ga,1);
%%