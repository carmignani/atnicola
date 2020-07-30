function [ring2,ibpm,iID,iquad,isext,ioct]=atCleanEBS(ring)
%
% [ring2,ibpm,iID,isext,iquad]=atCleanEBS(ring);
% runs atreduce keeping bpms and IDs
% see also: atreduce

iIDold=findcells(ring,'FamName','ID\w*');
ibpmold=findcells(ring,'Class','Monitor');

ring2=atreduce(ring,sort([iIDold,ibpmold]));
iID=findcells(ring2,'FamName','ID\w*');
ibpm=findcells(ring2,'Class','Monitor');

iquad=findcells(ring2,'Class','Quadrupole');
isext=findcells(ring2,'Class','Sextupole');
ioct=findcells(ring2,'Class','Octupole');

end