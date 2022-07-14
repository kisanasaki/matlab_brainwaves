function [new_x,new_SP] = f_artifact70(x,SP)
c = 0; new_x = x;new_SP = SP;win = size(x,1);
for i = 1:win
    if max(x(i,:)) >= 70 || min(x(i,:)) <= -70
%         art = [art i];
        new_x(i-c,:) = [];
        new_SP(:,i-c) = [];
        c = c+1;
    end
end



