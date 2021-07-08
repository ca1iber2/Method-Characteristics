function [CL,CS]=EOS(Rho,P,Rho_o)

x = Rho;
y = P;
%Finding the slopes between rho and P
dydx = gradient(y(:)) ./ gradient(x(:));
CS = sqrt(dydx);
z = zeros(length(CS));
CL = x;
for n = 1:length(CS)
    z(n) = (x(n)/Rho_o) * CS(n);
    CL(n,1) = z(n,1);
end
