function [indoct,b4,L] = findOct(ring)
%   [indsext,b4,L] = findOct(ring)
%   this function returns the indexes of the sextupoles
%   elements with PolynomB(1,4) not zero.

indoct=findcells(ring,'FamName','O[IJFD]\w*');
b4=getcellstruct(ring,'PolynomB',indoct,1,4);
L=getcellstruct(ring,'Length',indoct);
end
