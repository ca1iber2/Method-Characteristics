function [H,Time,Tapplied,U1,S1,CL_region] = MBC(F1,B1,xo,Sigma1,CL1,Timeint)
%MapBackwardsCharacteristics was designed to Map the backwards
%  Characteristics for as given material.
%
%  User input the Forward postive characteristics (F1), the backwards
%  negative characteristics (B1), the target thickness, the target strain
%  (Sigma1), the sounds speed as a function of target strain (CL1(Sigma1)),
%  the time at the interface (Timeint), and the pressure as a function of
%  the strain (Press1(Sigma1)).
%
%  Outputs are H (the characteristics intesections, Time (the time of the
%  characteristics intesections, the applied pressure (Papplied), and the
%  time of this applied pressure (Papplied).
%CL1 and Sigma1 are from the sample EOS, calculated in Get_PSR function


H = zeros(length(F1),length(F1));
Time = H;
for n = 1:length(Timeint)
    Time(n,n) = Timeint(n,1);
    H(n,n) = xo;
end
U1 = H; S1 = H;

i = 1; j = 1; 
%now lets find the velocity and sigma within the material
while i <= length(F1)
    while j <= i && j <= length(F1)
        U1(i,j) = .5*(F1(i)+B1(j));
        S1(i,j) = .5*(F1(i)-B1(j));
        j = j+1;
    end
    i = i + 1;
    j = 1;
end
%%  Find the time and location of the intersections
%The first reflected wave is a rarefaction wave that originated from the
%initial shock. The origin of this shock wave should start at time = 0, and
%should progated with shock speed L/to.  The rarefaction wave should travel
%at the local sound speed back into the material.  Incorporating this into
%the code may be difficult.


CL_region = interp1(Sigma1,CL1,S1,'pchip'); %this interpolates CL to all values of sigma (s1)
%from the given data at the interface (CL1(sigma1)).

CL_region = [interp1(Sigma1,CL1,F1/2) CL_region]; % appending more values of CL
%F1/2 is where B=0, thus sigma = F1/2
%Special case ie at the end of either fs or interface
%Corresponds to points on left edge 

i = 2; j = 1; k = 2; 
while k <= length(F1)
    while  j > 0
        %Calculating the slopes between the points
        Cp = (CL_region(i,j+1+1) + CL_region(i,j+1))/2;
        Cm = (CL_region(i-1,j+1) + CL_region(i,j+1))/2;
        %Calculating times for points
        Time(i,j) = (H(i-1,j)-H(i,j+1)+Time(i-1,j)*Cm+Time(i,j+1)*Cp)/(Cm+Cp);
        %Calculating position
        H(i,j) = H(i,j+1) - (Time(i,j+1)- Time(i,j))*Cp;
        
        j = j -1;
    end
    i = i + 1;
    k = k + 1;
    j = i - 1;
end
i = 2; j = 1; k = 2; x = 1; z = 1;
underZero = false;
while k <= length(F1)
    while  j > 0
        if H(i,j)>xo
            H(i,j)= xo;
        else
            if H(i,j) < 0
                H(i,j) = 0;
                x = i;
                z = j;
                underZero = false;
                while underZero == false
                    x = x -1;
                    z = z +1;
                    
                    if H(x,j)>0
                        underZero = true;
                        S1(i,j) = S1(x,z);
                        U1(i,j) = U1(x,z);
                        
                    end
                end
                
            end
        end
        j = j -1;
    end
    i = i + 1;
    k = k + 1;
    j = i - 1;
end

Tapplied = Time(:,1)-H(:,1)./CL_region(:,1);



