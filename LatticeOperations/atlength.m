function len=atlength(ring)
%
% atlength computes the length of the ring
% len=atlength(ring)
% ring is an AT structure
% len is the length in metres
%
% see also: findspos

len=findspos(ring,length(ring)+1);
end