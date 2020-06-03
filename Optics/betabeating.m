function [bbx,bby] = betabeating(r0,r1,indbpm)
%
%   [bbx,bby] = betabeating(r0,r1,indbpm)
%   This function computes the beta beating in all the points of the ring
%   between the lattice with errors r1 and the perfect lattice r0.
%   bbx = ( betax1 - betax0 ) / betax0
%
%   if indbpm is passed, then the betabeating is computed only in the bpms
%
if nargin==2
    indbpm=1:length(r0);
end

LinData0 = atlinopt(r0,0,indbpm);
betax_0=arrayfun(@(x)x.beta(1),LinData0);
betay_0=arrayfun(@(x)x.beta(2),LinData0);
LinData1 = atlinopt(r1,0,indbpm);
betax_1=arrayfun(@(x)x.beta(1),LinData1);
betay_1=arrayfun(@(x)x.beta(2),LinData1);
bbx=(betax_1-betax_0)./betax_0;
bby=(betay_1-betay_0)./betay_0;

disp (['rms(bbx)=' num2str(rms(bbx)) ]);
disp (['rms(bby)=' num2str(rms(bby)) ]);
end
