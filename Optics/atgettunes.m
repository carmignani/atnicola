function tunes=atgettunes(ring,dpp)
%  tunes=atgettunes(ring,dpp)
%  computes the tunes (including the integer part) of the ring using 
%  atlinopt phase advances
%  dpp is the energy deviatio (default is 0)
%
%  see also: atlinopt

if nargin==1
    dpp=0;
end

finpos=length(ring)+1;
p=atlinopt(ring,dpp,1:finpos);
tunes=p(finpos).mu/2/pi;

end