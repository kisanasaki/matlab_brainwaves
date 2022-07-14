function [x] = f_X_inputY(y,sampling,shift,window) 
startT = 0; 

x = zeros(sampling,window);%sampling（512*4）行window(53)列の0行列を作る
time_1sec = (0:1/sampling:(sampling-1)/sampling)';%スタ-ト=0,ストップ=(sampling-1)/samplingでsamplingずつ増加するベクトル->4秒~30秒まで0.5刻みでFFT
all_time = zeros(window*sampling,1);
A = ones(sampling,1);
B = A*startT;

for i = 1:window %1~53まで
    a = 1+shift*(i-1); %1+(256)*(i-1) 
    b = sampling+shift*(i-1); %2048+256*(i-1)
    all_time(a:b,1) = time_1sec+A*(i-1)+B; %a~bまで縦 = 4~30まで0.5刻みの値*(i-1)+ B（1*0のこと？）
    x(:,i) = y(a:b,1);
end
x = x';