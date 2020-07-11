
function dy = ModelSimulator(t,y,Z)

ylag1 = Z(:,1);
global epsilon %PIDDdependent Mdm2 degradation rate
global tmitosis %mitosis time in hr

a = .4; %production rate of p53: .4
b = 4; %MDm2-dependent degradation rate: 4
g = .01; %concentration for half-max p53 degradation
psi = .6; %p53-dependent Mdm2 production: .6 
delta = .4; %Mdm2 degradation rate: .4
PIDDosome = 1; %assume constant PIDD concentration of 1 Cs (Cs = simulated concentration units)

if t < tmitosis  
    dy = [a - b*y(2)*y(1)/(g+y(1))                                  % p53
        psi*ylag1(1) - delta*y(2)];                                 % Mdm2  
else %add PIDD-dependent degradation of Mdm2 after mitosis
    dy = [a - b*y(2)*y(1)/(g+y(1))                                  % p53
        psi*ylag1(1) - delta*y(2) - epsilon*y(2)*PIDDosome];        % Mdm2                 % 2 --> Mdm2
end

   