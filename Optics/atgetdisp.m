function [dx, dxp, dy, dyp] = atgetdisp(r,indbpm)
%   [dx, dxp, dy, dyp] = atgetdisp(r,indbpm)
%   the function returns the values of disp x, disp x', disp y and disp y'
%   in the indeces indbpm. the optics is computed by atlinopt
%
%   see also: atlinopt

[ld,~,~] = atlinopt(r,0,indbpm);

d=cat(2,ld.Dispersion)';
% d=cat(2,ld.Dispersion)';
dx=d(:,1);
dxp=d(:,2);
dy=d(:,3);
dyp=d(:,4);

%dx=d(:,1);
end