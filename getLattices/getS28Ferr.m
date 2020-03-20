function [ rcor,rerr,ringnoerr ] = getS28Ferr(seed)
%   [ ringerr,ringnoerr ] = getS28Derr(err)
%   ringerr is the ring with err, ringnoerr is the perfect lattice
%

load(['/mntdirect/_machfs/carmigna/Repositories/EBSlattices/AT/errors/'...
    'Errors_00' num2str(seed,'%02d') '.mat'],'ring','rerr','rcor');

rcor=rcor;
rerr=rerr;
ringnoerr=ring;

end

