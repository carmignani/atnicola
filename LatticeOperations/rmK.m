function ring=rmK(ring)
%% rm K

%load('S28C_2016Feb16merged.mat')
indK=findcells(ring,'K');

%figure; atplot(ring);
for ii=indK
    ring{ii}=rmfield(ring{ii},'K');
end
%figure; atplot(ring);

