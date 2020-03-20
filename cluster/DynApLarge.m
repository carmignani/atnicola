function datafolder=DynApLarge( inputdatafile,varringname,Nproc,Nturns )
%
%  datafolder=DynApLarge( inputdatafile,varringname,Nproc,Nturns )
%
%  see also: CollectDynAp_S28C


ringfile=inputdatafile;        %1
if nargin<4
    Nturns=512;          %3
end
commands=struct();
commands.time = num2str(3*60);
%Nturns=8;          %3
collect=true;
datafolder=RunDynApArray(...
    ringfile,...
    varringname,...
    Nturns,...         % number of turns
    [21 2000],...       % steps in dimension(1) and dimension(2)
    Nproc,...          % number of processes on OAR
    [-0.028 0.028],...% dimension(1) limits
    [0 0.04],...    % dimension(2) limits
    'radial',...      % grid in cartesian coordinates
    [1 3],...       % dimensions to scan
    0.0,...
    commands,...
    [0;0;0;0;0;0],...
    collect); 
%     '-q asd -l walltime=1:30:00');            % dpp
 %-p "host like ''hpc2-1%%%'' OR host like ''hpc2-09%%''"
end
