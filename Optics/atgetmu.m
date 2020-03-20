function [mux, muy, dx] = atgetmu(r,indbpm,fromlastbpm)
%   [mux, muy] = atgetmu(r,indbpm)
%   the function returns the values of mux and muy in rad between two bpms.
%   mux(1) will be the horizontal phase advance between the last bpm of the
%   ring and the first, mux(2) is the phase advance between the first and
%   the second, etc.
%   the optics is computed by atlinopt.
%
%   see also: atlinopt, atgetbetas
if nargin<3
    fromlastbpm=false;
end    
indbpm=indbpm(:);
if nargout>2
    [ld,~,~] = atlinopt(r,0,[indbpm; length(r)+1]);
else
    ld = atlinopt(r,0,[indbpm; length(r)+1]);
end
m=cat(1,ld.mu);
mux1=m(:,1);
muy1=m(:,2);
if fromlastbpm
    mux=mux1(1:end-1)+mux1(end)-mux1(end-1);
    muy=muy1(1:end-1)+muy1(end)-muy1(end-1);
else
    mux=[mux1(1)+mux1(end)-mux1(end-1); mux1(2:end-1)-mux1(1:end-2)];
    muy=[muy1(1)+muy1(end)-muy1(end-1); muy1(2:end-1)-muy1(1:end-2)];
end
if nargout>2
    d=cat(2,ld.Dispersion)';
    dx=d(1:end-1,1);
end
end