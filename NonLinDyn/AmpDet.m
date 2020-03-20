function [A1,A2,A3,TunesData]=AmpDet(ring,xmax,ymax,np)
%AMPDET Computes the detuning with amplitude
%   [A1,A2,A3,TunesData]=AmpDet(ring,xmax,ymax,np)
%
%   ring = at lattice with radiation
%   xmax = maximum x coordinate
%   ymax = maximum y coordinate
%   np = number of amplitude points
%
%   A1 = horizontal detuning with horizontal amplitude
%   A2 = horizontal detuning with vertical amplitude
%   A3 = vertical detuning with vertical amplitude
%   TunesData is a structure with 6 arrays with length np inside:
%      nuxx, nuyx, nuxy, nuyy, x, y
%
%   see also: atnuampl, atfastring

doplot=false;
lindata=atlinopt(ring,0,1);
gamma=(1+lindata.alpha.*lindata.alpha)./lindata.beta;
orbit=findorbit6(ring,1);
x2=linspace(0,xmax.*xmax,np);
z2=linspace(0,ymax.*ymax,np);
[nuxx,nuzx]=atnuampl(ring,sqrt(x2),1,orbit);
[nuxz,nuzz]=atnuampl(ring,sqrt(z2),3,orbit);
TunesData.nuxx=nuxx;
TunesData.nuyx=nuzx;
TunesData.nuxy=nuxz;
TunesData.nuyy=nuzz;
TunesData.x=sqrt(x2);
TunesData.y=sqrt(z2);

if doplot
    tune0=floor([nuxx(1);nuzz(1)]);
    subplot(2,1,1);
    plot(x2,[nuxx;nuzx]-tune0(:,ones(1,np)));
    xlabel('x^2 (m^2)')
    ylabel('tunes')
    subplot(2,1,2);
    plot(z2,[nuxz;nuzz]-tune0(:,ones(1,np)));
    xlabel('y^2 (m^2)')
    ylabel('tunes')
end

rx=([nuxx-nuxx(1);nuzx-nuzx(1)]*x2')./(x2([1 1],:)*x2')/gamma(1);
rz=([nuxz-nuxz(1);nuzz-nuzz(1)]*z2')./(z2([1 1],:)*z2')/gamma(2);
r=2*[rx;rz];
A1=r(1); A2=r(2); A3=r(4);

end
