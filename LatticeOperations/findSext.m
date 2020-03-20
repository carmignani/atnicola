function [indsext,b3,L] = findSext(ring)
%   [indsext,b3,L] = findSext(ring)
%   this function returns the indexes of the sextupoles
%   elements with PolynomB(1,3) not zero.
indsext=findcells(ring,'Class','Sextupole');
b3=getcellstruct(ring,'PolynomB',indsext,1,3);
L=getcellstruct(ring,'Length',indsext);
end
