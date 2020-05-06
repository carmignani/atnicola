function [ esrf, esrferr ] = getESRF1()
%GETESRF1 gets the esrf1 lattice, with 78highchroma sext and no sext corr.
%   [ ring0, ringerr ] = getESRF1(folder_resp_name)
%
%   ring0 is the lattice without errors
%   ringerr is the lattice with errors of MDT 2016/Oct16
%

f=load('esrf1.mat');
esrf=f.esrf;
esrferr=f.esrferr;

end

