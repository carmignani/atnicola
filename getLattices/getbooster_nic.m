function booster = getbooster( setting )
%GETBOOSTER gives the at lattice of the esrf booster
%   !!!  AFTER THE SHORTENING DUE TO THE EBS  !!!
%   booster = getBooster( setting )
%   setting is an integer and can be:
%   1 old booster nominal lattice with corrected chromaticity:
%         on-energy, nuh=11.75
%   2 on-energy, new tunes (nuh = 12.75 instead of 11.75)
%   3 off energy lattice (+40kHz) old tunes (nuh=11.75)
%   4 (default) off energy lattice (+40kHz) new tunes (nuh = 12.75)
%
if nargin==0
    setting=4;
end
switch setting
    case 1
        load('/mntdirect/_machfs/carmigna/EBS/Booster/NewBoosterLength/booster_onen_nuh11.mat');
        booster=b;
    case 2
        load('/mntdirect/_machfs/carmigna/EBS/Booster/NewBoosterLength/booster_onen_nuh12.mat');
        booster=b;
    case 3
        load('/mntdirect/_machfs/carmigna/EBS/Booster/NewBoosterLength/booster_offen_nuh11.mat');
        booster=b;
    case 4
        load('/mntdirect/_machfs/carmigna/EBS/Booster/NewBoosterLength/booster_offen_nuh12.mat');
        booster=b;
    otherwise
        if setting~=1
            warning('setting has to be 1, 2, 3 or 4 (default)');
        end
end
end

