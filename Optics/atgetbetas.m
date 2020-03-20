function [bx, by] = atgetbetas(r,indbpm)
%   [bx, by] = atgetbetas(r,indbpm)
%   the function returns the values of betax, betay in
%   the indeces indbpm. the optics is computed by atlinopt
%
%   see also: atlinopt

[ld] = atlinopt(r,0,indbpm);

b=cat(1,ld.beta);
% d=cat(2,ld.Dispersion)';
bx=b(:,1);
by=b(:,2);
%dx=d(:,1);
end