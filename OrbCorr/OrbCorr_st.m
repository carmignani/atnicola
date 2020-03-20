function [rcor] = OrbCorr_st(r,plane,frac_eig,useDQ,maskbpm)
%ORBCORR_ST corrects orbit with steerer in ebs lattice 
%   
%   [rcor] = OrbCorr_st(r,plane,frac_eig)
%   r is the ring with big orbit 
%   plane is 'h' or 'v'
%   frac_eig is the fraction of eigenvalues used for the SVD
%   useDQ is 0 if no DQ, 1 if only DQ1, 2 if only DQ2, 3 if all DQ are used
%   as orbit correctors
%   rcor is the at lattice after corrections
%
%   matrices are stored in:
%   '/machfs/carmigna/EBS/Commissioning/OrbCorr/Orb_misalignment/RMs.mat'
%
indbpm=findcells(r,'Class','Monitor');

if nargin < 5
    maskbpm=true(size(indbpm));
end
if nargin <4
    useDQ=false; 
end

DQ=sort([5:12:384 7:12:384 8:12:384]);
DQ1=sort([5:12:384 8:12:384]);
DQ2=sort(7:12:384);
allmask=false(384,1);
DQmask=allmask;DQ1mask=allmask;DQ2mask=allmask;
DQmask(DQ)=true;
DQ1mask(DQ1)=true;
DQ2mask(DQ2)=true;

load('/machfs/carmigna/Repositories/atnicola/RMs.mat');
indbpm=indbpm(maskbpm);
orberrall=findorbit4Err(r,0,indbpm);
if strcmp(plane,'h') 
    if useDQ==3
        indst=findcells(r,'FamName','S[DFIJH]\w*','DQ\w*');
    elseif useDQ==2
        indst=findcells(r,'FamName','S[DFIJH]\w*','DQ2\w*');
    elseif useDQ==1
        indst=findcells(r,'FamName','S[DFIJH]\w*','DQ1\w*');
    else
        indst=findcells(r,'FamName','S[DFIJH]\w*');
    end
    orbe=orberrall(1,:)';
    if useDQ == 3
        Mat=RMh{1}(maskbpm,:);
    elseif useDQ==2
        Mat=RMh{1}(maskbpm,~DQ1mask);
    elseif useDQ==1
        Mat=RMh{1}(maskbpm,~DQ2mask);
    else
        Mat=RMh{1}(maskbpm,~DQmask);
    end
elseif strcmp(plane,'v')
    indst=findcells(r,'FamName','S[DFIJH]\w*');
    orbe=orberrall(3,:)';
    Mat=RMv{3}(maskbpm,:);
else 
    error('plane must be ''h'' or ''v''!');
end

max_eig=min(size(Mat));

cor=qemsvd_mod(Mat,orbe,floor(max_eig*frac_eig),0);

if strcmp(plane,'h') 
    cor0=getcellstruct(r,'KickAngle',indst,1,1);
    rcor=setcellstruct(r,'KickAngle',indst,cor0-cor,1,1);
elseif strcmp(plane,'v')
    cor0=getcellstruct(r,'KickAngle',indst,1,2);
    rcor=setcellstruct(r,'KickAngle',indst,cor0-cor,1,2);
end

end

