function vcvs(nd1,nd2,ni1,ni2,val)

% Student Name: Yousef Nour
% Elec 4700
% Adds the stamp of a dependent voltage-controlled 
% voltage-source(VCVS)to the matrices in circuit 
% representation.
%
%   ni1 O-------O          |----------o nd1
%                          |
%                         /+\
%                      | /   \    Vnd1-Vnd2 = val*(Vni1-Vni2)
%                Ivcvs | \   /
%                      V  \-/ 
%                          |
%   ni2 O-------O          |----------o nd2
%
%  (1) "nd1 & nd2" are the nodes across the dependent
%                  voltage source.
%  (2) "ni1 & ni2" are the nodes corresponding to the 
%                  controller voltage
%
%   nd1: (+) node   \
%   nd2: (-) node   |----->  Vnd1-Vnd2 = val*(Vni1-Vni2)
%   ni1: (+) node   |
%   ni2: (-) node   /
%--------------------------------------------------------------
global G C F;%define global variables

% Using an index bigger than the current size,  Matlab automatically 
... increases the size of the matrix:
newInd = size(C,1) + 1; % new index
G(newInd, newInd) = 0;
C(newInd, newInd) = 0;
F(newInd) = 0;

if nd1 ~= 0
    G(newInd, nd1) = G(newInd, nd1) - val;
end
if nd2 ~= 0
    G(newInd, nd2) = G(newInd, nd2) + val;
end
if ni1 ~= 0
    G(newInd, ni1) = 1;
    G(ni1, newInd) = 1;
end
if ni2 ~= 0
    G(newInd, ni2) = -1;
    G(ni2, newInd) = -1;
end
end
