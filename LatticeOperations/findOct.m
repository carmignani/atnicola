function [indoct,b4,L] = findOct(ring)
%   [indsext,b4,L] = findOct(ring)
%   this function returns the indexes, the strengths and the lengths of 
%   the octupoles
%
%   see also findSext

indoct=findcells(ring,'FamName','O[IJFD]\w*')';
b4=getcellstruct(ring,'PolynomB',indoct,1,4);
L=getcellstruct(ring,'Length',indoct);

end
