function ring=getOperationLattice()
%  function ring=getOperationLattice()
%  
%  this function gets the lattice with the sext and oct of the operation
%  file
%
%  see also: SetStrengthsFileToLattice




[ring, ~,~,~,~,~,~ ] = ...
    SetStrengthsFileToLattice(...
    'operation',... % file to read, name or full path
    'quad',false,...% set quadrupoles (default: true)
    'sext',true,... % set sextupoles (default: true)
    'skew',false,... % set skew (default: true)
    'hor',false,... % set hor steerers (default: false)
    'ver',false,...  % set ver steerers (default: false)
    'oct',true);     % set octupoles (default: true)

end

