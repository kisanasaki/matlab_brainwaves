
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

for i = 1:SUB
    figure;
    for j= 1:TASK
        plot(time_X,x_fmtheta(:,j,i));
        title(['SUB',num2str(i),'-fmtheta']);
        
        hold on;
    end
    legend({'task1','task2','task3','Task4','Task5','Task6','Task7'},'Location','northwest')
    
end