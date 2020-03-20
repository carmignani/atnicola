function [TL, Contrib] = CollectLT( datafolder )
%  [TL, Contrib] = CollectLT_S28C( datafolder )
%

[TL, Contrib] = CollectTouLTOARData_withContrib(datafolder);
delete(fullfile(datafolder,'latticefile.mat'));

end

