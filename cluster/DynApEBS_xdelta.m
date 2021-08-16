function datafolder=DynApEBS_xdelta( inputdatafile,varringname,Nproc,Nturns )
%
%  datafolder=DynApEBS( inputdatafile,varringname,Nproc,Nturns )
%
%  see also: CollectDynAp


ringfile=inputdatafile;        %1
if nargin<4
    Nturns=512;          %3
end

%oarstring='-l walltime=0:50:00 -q asd';
%oarstring='';
commands.time = num2str(12*60) ; % time in minutes
X0offset=zeros(6,1);
collect=true;
datafolder=RunDynApArray(...
    ringfile,...
    varringname,...
    Nturns,...         % number of turns
    [161 61],...       % steps in dimension(1) and dimension(2)
    Nproc,...          % number of processes on OAR
    [0 0.016],...% dimension(1) limits
    [-0.10 0.10],...    % dimension(2) limits
    'radial',...      % grid in cartesian coordinates
    [1 5],...       % dimensions to scan
    0.0,...
    commands,...
    X0offset,...
    collect); 

end
