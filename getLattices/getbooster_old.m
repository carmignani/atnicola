function booster = getbooster_old( setting )
%GETBOOSTER gives the at lattice of the esrf booster
%   !!!  BEFORE THE SHORTENING DUE TO THE EBS  !!!
%   booster = getBooster_old( setting )
%   setting is an integer and can be:
%   1 (default) nominal lattice with corrected chromaticity, no errors
%   2 no errors, nuh = 12.75 instead of 11.75
%   3 off energy lattice (+40kHz)
%   4 off energy lattice and nuh = 12.75
%
if nargin==0
    setting=1;
end
switch setting
    case 2
        load('/mntdirect/_machfs/carmigna/EBS/Booster/Lattices/goodQuadNames/Booster_nux12.mat');
        booster=atsetcavity(atradon(b,'','auto','auto'),8e6,1,352);
    case 3
        load('/mntdirect/_machfs/carmigna/EBS/Booster/Lattices/goodQuadNames/Booster_offEn.mat');
        booster=b;
    case 4
        load('/mntdirect/_machfs/carmigna/EBS/Booster/Lattices/goodQuadNames/Booster_offen_nux12.mat');
        booster=b;
    otherwise
        if setting~=1
            warning('setting has to be 1 (default), 2, 3 or 4');
        end
        load('/mntdirect/_machfs/carmigna/EBS/Booster/Lattices/goodQuadNames/Booster.mat');
        booster=atsetcavity(atradon(b,'','auto','auto'),8e6,1,352);
end
end

