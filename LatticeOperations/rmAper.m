function ring=rmAper(ring)
% ring=rmAper(ring)
% removes Apertures field from the lattice
%

indRap=findcells(ring,'RApertures');
indEap=findcells(ring,'EApertures');

for ii=indRap
    ring{ii}=rmfield(ring{ii},'RApertures');
end
for ii=indEap
    ring{ii}=rmfield(ring{ii},'EApertures');
end

end