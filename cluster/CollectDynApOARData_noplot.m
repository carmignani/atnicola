function [xc,yc,x,y,xa,ya,notok]=CollectDynApOARData_noplot(datafolder,outputfilename)
%
% [xc,yc,x,y,xa,ya,notok]=CollectDynApOARData(datafolder,outputfilename)
% 
% datafolder: folder of data generated with RunDynApArray
% outputfilename: file where to save the data
% xc,yc : contour points for particles survived
% x,y : grid points for particles survived
% xa,ya: grid points for all particles 
% notok: x=xa(notok==0);
% 
% to plot DA: plot(xc,yc,'x-');
% 
%see also: RunDynApArray

cd(datafolder)

a=dir('specfile*.mat');
totproc=length(a);
b=dir('outfile*.mat');
finproc=length(b);

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

load('GlobalTolParameters.mat','type','Nsteps');
xa=[];
ya=[];
notok=[];
for iproc=1:totproc

    load(['outfile_' num2str(iproc,'%0.4d') '.mat'],'xx','zz','X0');
    notok=[notok (isnan(xx) | isnan(zz))];
    xa=[xa X0(1,:)];
    ya=[ya X0(2,:)];
    
end

x=xa(notok==0);
y=ya(notok==0);
% figure;
% plot(x,y,'x');hold on;

switch type
    case 'grid'
        % get maximum of each column in the grid
        cols=mat2cell(reshape(notok,Nsteps([2,1]))',ones(1,Nsteps(1)),Nsteps(2));
        maxindcel=cellfun(@(a)find(a,1,'first'),cols,'un',0);
        cc=cellfun(@(a)isempty(a),maxindcel,'un',1);
        maxindcel(cc)={Nsteps(2)+1};% set to maximum if no limit is found.
        maxind=cell2mat(maxindcel);
        maxind=maxind-1;
        maxind(maxind==0)=1;
        xc=xa(maxind+[1:Nsteps(2):length(xa)-1]');
        yc=ya(maxind);
    case {'radial', 'radialnonlin'}
        % get maximum of each column in the grid
%         maxind=cell2mat(...
%             cellfun(@(a)find(a,1,'first'),...
%             mat2cell(reshape(notok,Nsteps([2,1]))',ones(1,Nsteps(1)),Nsteps(2)),...
%             'un',0));
       
        cols=mat2cell(reshape(notok,Nsteps([2,1]))',ones(1,Nsteps(1)),Nsteps(2));
        maxindcel=cellfun(@(a)find(a,1,'first'),cols,'un',0);
        cc=cellfun(@(a)isempty(a),maxindcel,'un',1);
        maxindcel(cc)={Nsteps(2)+1};% set to maximum if no limit is found.
        maxind=cell2mat(maxindcel);
        
        maxind=maxind-1;
        maxind(maxind==0)=1;
        xc=xa(maxind+[0:Nsteps(2):length(xa)-1]');
        yc=ya(maxind+[0:Nsteps(2):length(ya)-1]');
end


if nargin>1

% figure;
% plot(x,y,'x');hold on;
% xlabel('dim 1');
% ylabel('dim 2');
% plot(xc,yc,'r+-')

save(outputfilename,'x','y','xc','yc','xa','ya','notok');
end

% delete OAR files
delete('*.stdout');
delete('*.stderr');
% delete spec and out files
delete('spec*.mat');
delete('out*.mat');
if exist('latticefile.mat','file')
    delete('latticefile.mat');
end
cd ..




return