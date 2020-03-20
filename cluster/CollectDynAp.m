function [DynAp,DAleft] = CollectDynAp( datafolder )
%   DynAp = CollectDynAp_S28C( datafolder )
%   Computes dynamic aperture area in mm^2

if ~exist(fullfile(datafolder,'Results.mat'),'file')
    [xc,yc,~,~,~,~,~]=CollectDynApOARData_noplot(datafolder,'Results.mat');
else
    load(fullfile(datafolder,'Results.mat'));
end
DynAp=polyarea(xc,yc)*1e6;
xc_l=xc;
yc_l=yc;
xc_l(xc_l>0.005)=0.005;
yc_l(yc_l>0.0032)=0.0032;
DAleft=polyarea(xc_l,yc_l)*1e6;
end

