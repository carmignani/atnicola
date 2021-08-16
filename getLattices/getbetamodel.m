function r=getbetamodel()
%  r=getbetamodel()
%  
%  returns the at lattice betamodel currently in operation
%  the function has to be used from raki or other alcholic machines

load('/operation/beamdyn/matlab/optics/sr/theory/betamodel.mat','betamodel')
r=betamodel;

end