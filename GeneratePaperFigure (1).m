% This is the code used to simulate PIDDosome-dependent degradation of
% Mdm2 following mitosis in Tsabar et al 2020
%
% Calls function HeltbergModel.m 
%
% See paper text and supplemental information for further explanation of
% model and parameters

lags = [.7]; % This is T_del, the time delay (in hrs) for p53-induced Mdm2 expression; using 0.7 per Batchelor 2008
hist = [.1 .15]; % [p53_initial = 0.1 Cs; mdm2_initial = .15 Cs]  Initial values from Heltberg et al
interval = [0,72]; % time interval in hours over which to evaluate model - here 3 days

global epsilon %PIDDosome-dependent Mdm2 degradation rate; epsilon in paper
global tmitosis %set mitosis time

tmitosis = 30;
epsilonRange = [0:1:4]; %vary epsilon from 0 to 4

figure;
for i=1:5
    epsilon = epsilonRange(i);  
    sol = dde23(@ModelSimulator, lags, hist, interval);
    plot(sol.x,sol.y(1,:)); %note: sol.y(1,:) gives [p53] time trace; sol.y(2,:) gives [Mdm2] time trace
    ylim([0 .8]);
    hold on;
end

title(['Simulated [p53] while varying \epsilon when t_{mitosis} = 30h'])
xlabel('Time (hr)')
ylabel('[p53] (AU)')
legend('\epsilon = 0','\epsilon = 1','\epsilon = 2','\epsilon = 3','\epsilon = 4','Location','NorthWest')