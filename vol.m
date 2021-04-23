function vol(n1,n2,val)

% Student Name: Yousef Nour
% Elec 4700
% Adds the stamp of an independent voltage source with a value
% of "val" (Volts) connected between nodes n1 and n2 to the 
% matrices in circuit representation.
%
%                   val 
%                  /  \
%      n1 O-------(+  -)--------O n2    where Vsrc= val (volts)
%                  \  /
%             Isrc ---->
%---------------------------------------------------------------
global G F C   % define global variables

d = size(G,1); % current size of the MNA
xr = d+1;      % new (extera)row/column

% Using an index bigger than the current size, Matlab  
...automaticallyincreases the size of the matrix:
    
G(xr,xr) = 0; % add new row/column
C(xr,xr) = 0;

if (n1 ~= 0)
    G(n1,xr) = 1;
    G(xr,n1) = 1;
end

if (n2 ~= 0)
    G(n2,xr) = -1;
    G(xr,n2) = -1;
end
F(xr) = val;

end %func
