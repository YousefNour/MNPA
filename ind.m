function ind(n1, n2, val)
% ELEC700
% Student Name: Yousef Nour 
% Adds the stamp of an inductor with a value of "val" (Henrys)
% connected between nodes n1 and n2 to the matrices in
% circuit representation.
%
%                 val
%      n1 O-----@@@@@@-----O n2      where L=val (henry)
%              IL ---->
%---------------------------------------------------------------

% The body of the function will go here!

global G C F;

d = size(G,1);
xr = d+1;      
F(xr) = 0;     
G(xr,xr) = 0; 
C(xr,xr) = 0;

if (n1 ~= 0)
    G(n1,xr) = 1;
    G(xr,n1) = 1;
end
if (n2 ~= 0)
    G(n2,xr) = 1;
    G(xr,n2) = 1;
end
if (n1 ~= 0) && (n2 ~= 0)
    G(n1,xr) = 1;
    G(xr,n1) = 1;
    G(n2,xr) = -1;
    G(xr,n2) = -1; 
end

C(xr,xr) = -val
end %func