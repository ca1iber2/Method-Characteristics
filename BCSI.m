function [F1,B1,F2,B2] = BCSI(Press1,Press2,Sigma1,Sigma2,Uint)
%Backwards Characteristics Scheme Interface was written to take an
%   interface velocity measurment and to determine the characteristiscs
%   from it.

S2int = Uint;
Press2Match = interp1(Sigma2,Press2,S2int,'PCHIP');
S1int = interp1(Press1,Sigma1,Press2Match,'PCHIP');

F1 = Uint + S1int;
B1 = Uint - S1int;
F2 = Uint + S2int;
B2 = Uint - S2int;