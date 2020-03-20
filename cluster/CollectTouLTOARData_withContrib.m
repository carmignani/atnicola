function [TL, Contrib]=CollectTouLTOARData_withContrib(datafolder)
%
%  TL=CollectTouLTOARData(datafolder)
%   
%  The input of this function is the name of the folder where all the
%  momentum acceptance datas have been stored by the function
%  RunTouLTArray. The output of RunTouLTArray is the input of 
%  CollectTouLTOARData.
%  datafolder: folder of data generated with RunTouLTArray
%  
%   This is almost equal to CollectTouLTOARData, but the output is only TL
%   and the other output files are deleted in the directory
%
%  see also: RunTouLTArray TouLTOARrunner TouschekPiwinskiSimplified atmomap_manypos

cd(datafolder)

a=dir('specfile*.mat');
totproc=length(a);
b=dir('outfile*.mat');
finproc=length(b);
load('latticefile.mat');
% wait for processes to finish
while finproc~=totproc
    b=dir('outfile*.mat');

    disp(['waiting for ' num2str(totproc-finproc) '/' num2str(totproc) ' processes to finish.'])
    
    % % % count runnning processes
    b=dir('outfile*.mat');
    finproc=length(b);

    % wait
    pause(10);
    
end

% delete OAR files
%delete('*.stdout');
%delete('*.stderr');

load('GlobalTolParameters.mat','From','To','emitx','emity','Ib','BL');
%xa=[];
%ya=[];
%notok=[];
deltapAll=[];
deltanAll=[];
sAll=[];
indMomApAll=[];
for iproc=1:totproc
    load(['outfile_' num2str(iproc,'%0.4d') '.mat'],'deltap','deltan','s','indMomAp');
  %  notok=[notok (isnan(xx) | isnan(zz))];
    deltapAll=[deltapAll deltap];
    deltanAll=[deltanAll deltan];
    sAll=[sAll s];
    indMomApAll=[indMomApAll indMomAp];
end
deltapAll(deltapAll==0)=0.0001;
deltanAll(deltanAll==0)=-0.0001;

% rp=ringpara(ringNoRad);
% [beamdata, params]=atx(ringNoRad);
%Ib=0.200/868;
%U0=2.6e6;
%E0=6.0e9;
% U0=rp.U0;
% E0=rp.E0;
% ex=145e-12;
% ey=5e-12;
%sigmadelta=9e-4;
% sigmadelta=params.espread;
%alpha=8.7e-5;
%circ=843.98;
%h=992;
%Zn=0.7;
%RFV=RFVolt_MV*1e6;
%BL=BunchLength(Ib,Zn,RFV,U0,E0,h,alpha,sigmadelta,circ);

[TL,contributionsTL] = TouschekPiwinskiSimplified2(ring,Ib,BL,emitx,emity,1e-3,indMomApAll,[deltapAll' deltanAll'],From,To);
Contrib=contributionsTL;
indMomAp=indMomApAll;
s=sAll;
deltap=deltapAll;
deltan=deltanAll;

%if nargin>1
%
%figure;
%plot(x,y,'x');hold on;
%xlabel('dim 1');
%ylabel('dim 2');
%plot(xc,yc,'r+-')
%
save('Results.mat','TL','Contrib','indMomAp','s','deltap','deltan');
%end

% delete OAR files
delete('*.stdout');
delete('*.stderr');
% delete spec and out files
delete('spec*.mat');
delete('out*.mat');

cd ..




return