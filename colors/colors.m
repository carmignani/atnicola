function color=colors(num)
%  color=colors(num) gives the standard matlab colors used by plot function,
%  in the same order of the plot function
%  
a=load('colors.mat');
% a=load('/mntdirect/_machfs/carmigna/Repositories/atnicola/colors/colors.mat','col');
col=a.col;
color=col(mod(num-1,7)+1,:);
end