function [Press,Sigma,Rho]=Get_PSR(Pressure,CL,Rho_data, Rho_o)
%3a rothman and ma
Press = Pressure;
%4 rothman and ma

Sigma = cumtrapz(Press,1./(Rho_o*CL));
Rho = Rho_data;
