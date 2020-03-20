function C = findrespmat_Girder_angle(RING, indbpm, PLANE, PVALUE, ORBITFUNCTION)
%findrespmat_Girder computes the change in the closed orbit due to
%girder misalignments
% Two calling syntax options
% 1. findrespmat_DX(RING, indbpm, indquad, PLANE, PVALUE)
%
% RING      - ring lattice
% indbpm    - indexes of elements where the orbit is observed (at the entrance)
% PLANE     - can be H or V
% PVALUE    - amount of misalignment
%             (Numeric array or scalar if all perturbations are the same magnitude)
%
% ORBITFUNCTION  - specifies which of the FINDORBIT functions is used
%
%             'findorbit4' (default)
%             'findorbit4Err'
%             'findsyncorbit'
%             'findorbit6'
%             'findorbit6Err'
%             'findtrajectory6Err'
%             'finddispersion6Err'
%             'gettunechromatlinopt'
%
%
% ARGS - additioanl arguments may be passsed to some of the FINDORBIT functions
%             findorbit4     - constant momentum error dP
%             findorbit4Err     - constant momentum error dP
%             findsyncorbit  - fixed orbit lengthening dCT
%             findorbit6     - inCOD
%             findorbit6err  - inCOD
%             findtrajectory6err   - inCOD
%             finddispersion6Err   - indrfc,alpha,delta,inCOD
%             gettunechromatlinopt - inCOD
%
% 2 sided matrix is computed (Oplus-Ominus)/2
%
% Returns a 1-by-4 cell array of O-by-P matrixes
% where O = length(OBSINDEX) and P = length(PERTURB)
% one for each of the close orbit components: X, PX, Y, PY
% See also ATPARAMGROUP, FINDORBIT, FINDORBIT4, FINDORBIT6, FINDSYNCORBIT

% warning('off','all');

O = length(indbpm);
P = 128;
C = {zeros(O,P),zeros(O,P),zeros(O,P),zeros(O,P)};

if length(PVALUE) ~= P
    PVALUE = PVALUE(ones(1,P(1)));
end


OBSINDEX=indbpm;
switch ORBITFUNCTION
    case 'findorbit4'
        orbit_function_handle = @findorbit4;
        if nargin == 9
            orbit_function_args   = {varargin{5}, OBSINDEX};
        else            
            orbit_function_args   = {0, OBSINDEX};
        end
    case 'findorbit4Err'
        orbit_function_handle = @findorbit4Err;
        if nargin == 9
            orbit_function_args   = {varargin{5}, OBSINDEX};
        else            
            orbit_function_args   = {0, OBSINDEX};
        end
    case 'findsyncorbit'
        orbit_function_handle = @findsyncorbit;
        if nargin == 9
            orbit_function_args   = {varargin{5}, OBSINDEX};
        else
            orbit_function_args   = {0, OBSINDEX};
        end
    case 'findorbit6'
        orbit_function_handle = @findorbit6;
        orbit_function_args   = {OBSINDEX};
        
    case 'findorbit6Err'
        orbit_function_handle = @findorbit6Err;
        orbit_function_args   = {OBSINDEX,varargin{5}};
        
    case 'findtrajectory6Err'
        orbit_function_handle = @findtrajectory6Err;
        orbit_function_args   = {OBSINDEX,varargin{5}};
        
    case 'finddispersion6Err'
        orbit_function_handle = @finddispersion6Err;
        orbit_function_args   = {OBSINDEX,varargin{5},varargin{6},varargin{7},varargin{8}};
        
    case 'gettunechromatlinopt'
        orbit_function_handle = @gettunechromatlinopt;
        orbit_function_args   = {varargin{5}};
        
        
    otherwise
        error(['Unknown FINDORBIT function: ',ORBITFUNCTION]);
end

for i = 1:P
%     if i==7
%         
%     end
    if PLANE == 'H'
        RING2=atsetshift_Girder(RING,i,0,0,+PVALUE(i),0);
    elseif PLANE == 'V'
        RING2=atsetshift_Girder(RING,i,0,0,0,+PVALUE(i));
    end
    ORBITPLUS  = feval(orbit_function_handle,RING2,orbit_function_args{:});
    if PLANE == 'H'
        RING2=atsetshift_Girder(RING,i,0,0,-1*PVALUE(i),0);
    elseif PLANE == 'V'
        RING2=atsetshift_Girder(RING,i,0,0,0,-1*PVALUE(i));
    end
    ORBITMINUS  = feval(orbit_function_handle,RING2,orbit_function_args{:});
%     if PLANE == 'H'
%         RING = atsetshift(RING,i,0,0);
%     elseif PLANE == 'V'
%         RING=atsetshift(RING,i,0,0);
%     end
    DORBIT = (ORBITPLUS - ORBITMINUS)/2/PVALUE(i);
    
    C{1}(:,i) = DORBIT(1,:);
    C{2}(:,i) = DORBIT(2,:);
    C{3}(:,i) = DORBIT(3,:);
    C{4}(:,i) = DORBIT(4,:);
end

% warning('on','all');

end
