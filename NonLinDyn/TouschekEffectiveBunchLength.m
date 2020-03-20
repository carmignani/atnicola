function TEBL = TouschekEffectiveBunchLength(LongDist,nbin)
%
%   TEBL = TouschekEffectiveBunchLength(LongDist,nbin)
%   LongDist is the longitudinal distribution of the particles in the bunch
%   nbin is the number of bin of the histogram
%   TEBL is the Touschek effective bunch length. It is the number one
%   should use in Piwinski or Bruck formulas for Touschek lifetime as bunch
%   length. When the bunch is gaussian, this is the standard deviation of
%   the gaussian, when the bunch is not gaussian it is different:
%
%   TEBL=1/(2*sqrt(pi)*Int(f(z)^2 dz))
%   where f(z) is the longitudinal distribution of the beam
%

npart=length(LongDist);
% ave=mean(LongDist);
% avedist=LongDist-ave;
[nelements,xcenters]=hist(LongDist,nbin);%,ceil(npart/100));
nelements=nelements/npart;
Int=sum(nelements.^2/(xcenters(2)-xcenters(1)));
TEBL=1/(2*sqrt(pi)*Int);
