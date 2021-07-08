function [Timeint, Velocity, Sigma] = MBC_Int(H,U1,S1,Tapplied,Time,xo)
%Function was written to take the input parameters and determine the
%interface insitu values
%n_rvb = find(H(:,1)<0,1,'first')-1;
count = length(H(:,1));
tf = 0;
% for n = 1:count
%    if H(n,1) < 0
%        tf = 1;
%    end
% end
if tf == 0
    Timeint = Tapplied;
    Velocity = U1(:,1);
    Sigma = S1(:,1);
end
% n_rvb = find(H(:,1)<0,1,'first')-1;
% Timeint = H(:,1)*0;
% Velocity = U1(:,1)*0;
% Sigma = S1(:,1)*0;
% Timeint(1:n_rvb) = Tapplied(1:n_rvb);
% Velocity(1:n_rvb) = U1(1:n_rvb,1);
% Sigma(1:n_rvb) = S1(1:n_rvb,1);
% for n = n_rvb+1:size(H,2)
%     pt = find(H(n,:)==xo,1,'first');
%     Timeint(n,1) = interp1(H(n,1:pt),Time(n,1:pt),0);
%     Velocity(n,1) = interp1(H(n,1:pt),U1(n,1:pt),0);
%     Sigma(n,1) = interp1(H(n,1:pt),S1(n,1:pt),0);
% end
% NaNLocator = isnan(Timeint);
% LocationsToFix = sum(NaNLocator);
% if(LocationsToFix>2)
%     pts = find(NaNLocator==1,LocationsToFix,'first')+1;
%     for n=1:LocationsToFix/2
%         n
%         Timeint(pts(2*n-1):pts(2*n)-1)     = interp1([pts(2*n-1)-1 pts(2*n)]',[Timeint(pts(2*n-1)-1) Timeint(pts(2*n))]'        ,[pts(2*n-1):pts(2*n)-1]');
%         Velocity(pts(2*n-1):pts(2*n)-1) = interp1([pts(2*n-1)-1 pts(2*n)]',[Velocity(pts(2*n-1)-1) Velocity(pts(2*n))]',[pts(2*n-1):pts(2*n)-1]');
%         Sigma(pts(2*n-1):pts(2*n)-1)    = interp1([pts(2*n-1)-1 pts(2*n)]',[Sigma(pts(2*n-1)-1) Sigma(pts(2*n))]'      ,[pts(2*n-1):pts(2*n)-1]');
%     end
% end