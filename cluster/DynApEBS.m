function datafolder=DynApEBS( inputdatafile,varringname,Nproc,Nturns )
%
%  datafolder=DynApEBS( inputdatafile,varringname,Nproc,Nturns )
%
%  see also: CollectDynAp


ringfile=inputdatafile;        %1
if nargin<4
    Nturns=512;          %3
end

%oarstring='-l walltime=0:50:00 -q asd';
oarstring='';
X0offset=zeros(6,1);
collect=true;
datafolder=RunDynApArray(...
    ringfile,...
    varringname,...
    Nturns,...         % number of turns
    [41 200],...       % steps in dimension(1) and dimension(2)
    Nproc,...          % number of processes on OAR
    [-0.020 0.020],...% dimension(1) limits
    [0 0.014],...    % dimension(2) limits
    'radial',...      % grid in cartesian coordinates
    [1 3],...       % dimensions to scan
    0.0,...
    oarstring,...
    X0offset,...
    collect); 

end
