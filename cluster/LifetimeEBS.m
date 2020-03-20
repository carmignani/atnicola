function datafolder = LifetimeEBS( inputdatafile,varringname,Nproc,Nturns, FromID, ToID )
%  datafolder = LifetimeEBS( inputdatafile,varringname,Nproc,Nturns )
%

ringfile=inputdatafile;        %1
if nargin<4
    Nturns=512;          %3
end
if nargin<5
    FromID=5;
    ToID=9;
end


a=load(ringfile,varringname);
ring=a.(varringname);
indID=findcells(ring,'FamName','ID\w*');%Marker');

% From=539;   %indID(4);            %4
% To=805;     %indID(6);              %5 
% From=indID(4);
% To=indID(5);
From=indID(FromID);
To=indID(ToID);
% From=1;
% To=length(ring);
% To=indID(3);
RFVolt_MV=6.5;       %6
harm_num=992;        %7
rp=ringpara(ring);
emitx=rp.emittx;
emity=10e-12;            %9
Ib=0.2/868;             %11
Zn = 0.67;
BL=atBunchLength(ring,Ib,Zn); %10

addlabel='';
% oarspecstring=' -q asd -l walltime=3:00:00 -p "opsys=''debian8''"';
oarspecstring='';
collect=true;
datafolder= RunTouLTArray(ringfile,varringname,...
    Nturns,From,To,RFVolt_MV,harm_num,emitx,emity,BL,Ib,Nproc,...
    addlabel,oarspecstring,collect);
end