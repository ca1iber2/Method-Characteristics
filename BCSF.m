function [F1,B1] = BCSF(Ufs)
%Backwards Characteristics Scheme Free Surface was written to determine the
%characteristics from a free surface measurement.  The relationship is
%quite simple.
%Reimann invariants are F and B
B1 = Ufs;
F1 = Ufs;
