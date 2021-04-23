% %Name: Yousef Nour
% %Elec 4700 PA7 MNPA

set(0,'DefaultFigureWindowStyle', 'docked')
set(0,'defaultaxesfontsize', 20)
set(0, 'defaultaxesfontname', 'Times New Roman')
set(0,'DefaultLineLineWidth', 2);

close all
clear all 
clc

global G C F;

% Define number of nodes in circuit
Nr_Nodes = 5;

% Reset G, C, F matrices
G = zeros(Nr_Nodes, Nr_Nodes);
C = zeros(Nr_Nodes, Nr_Nodes);
F = zeros(Nr_Nodes, 1);

% a) Create C, G matrix done through stamping in functions

% Define component values
R1 = 1;
R2 = 2;
R3 = 10;
R4 = 0.1;
Ro = 1000;
C1 = 0.25;
L1 = 0.2;
alpha = 100;


% Arrange G, C, and F matrices using stamp functions
    res(1, 2, R1); 
    res(2, 0, R2); 
    res(3, 0, R3); 
    res(4, 5, R4); 
    res(5, 0, Ro);
    cap(1, 2, C1); 
    ind(2, 3, L1); 
    val = alpha/R3; vcvs(3, 0, 4, 0, val);
    
% b) DC Sweep the input voltage V1 from -10V to 10V and plot the output
% voltage and the votlage at node 3

inputV = -10:0.1:10;
inputV = inputV'; %matirx size configuration change of inpu tvotlage 
N3 = zeros(length(inputV), 1); % intialization votlage at node 3
outputV = zeros(length(inputV), 1);

for i = 1:length(inputV)
    % Need to reset G, C, F matrices every time because of stamping
    G = zeros(Nr_Nodes, Nr_Nodes);
    C = zeros(Nr_Nodes, Nr_Nodes);
    F = zeros(Nr_Nodes, 1);
    
    % Reset G, C, and F matrices using stamp functions for every new
    % voltage 
    res(1, 2, R1); 
    res(2, 0, R2); 
    res(3, 0, R3); 
    res(4, 5, R4); 
    res(5, 0, Ro);
    cap(1, 2, C1); 
    ind(2, 3, L1); 
    val = alpha/R3; vcvs(3, 0, 4, 0, val);
    
    % Update the G matirx every time there is a new voltage source setup, G matrix is changed
    vol(1, 0, inputV(i)); 
    
    % Solve for unknowns
    V = G\F;
    
    % V = [v1;v2;v3;v4;Vout;iL;Vin;vT];
    outputV(i) = V(5); % V(5) = vout
    N3(i) = V(3); % V(3) = v3
end

% Plot Vout and V3 vs. Vin
figure (1)
subplot(2,1,1)
plot(inputV, outputV,'r');
title('DC Case Sweep of  Vout vs. Vin');
xlabel('Vin [V]'); 
ylabel('Vout [V]');
subplot(2,1,2)
plot(inputV, N3,'r');
title('DC Case Sweep : V3 vs. Vin');
xlabel('Vin [V]'); 
ylabel('Vout [V]');

% c) AC case sweep plot VO as a function of omega also plot the gain Vo/V1
% in dB
% Setup
frq = 0:0.1:100; % frequency from 1 to 100 Hz
omega = (2*pi).*frq; 
inputV = 1; % reset input voltage to 1 for frequency domain
% intilizaze zero matirx of output votlage and gain
outputV = zeros(length(frq),1);
gain = zeros(length(frq),1);

% Reset the G, C, F matrices for th new input voltage 
G = zeros(Nr_Nodes, Nr_Nodes);
C = zeros(Nr_Nodes, Nr_Nodes);
F = zeros(Nr_Nodes, 1);
res(1, 2, R1);
res(2, 0, R2);
res(3, 0, R3); 
res(4, 5, R4); 
res(5, 0, Ro);
cap(1, 2, C1);
ind(2, 3, L1);
val = alpha/R3; vcvs(3, 0, 4, 0, val);
vol(1, 0, inputV);

% Actual AC Sweep
for i = 1:length(frq)
    numer = (G + 1i*omega(i).*C);%numerator
    V = numer\F;
    outputV(i) = V(5);
end
%convert to dB
gain = 20.*log(outputV./inputV);

% AC Sweep plot
figure (2)
plot(omega, gain, 'r');
title('Gain(w) = Vo/V1');
xlabel('omega [rads/s]'); 
ylabel('Gain [dB]');

% d) For the AC case plot the gain as function of random perturbations on C using a normal distributionwith std = 0.05
% at omega=pi. Plot a histogram
% initalize 
randmN = 0.05*randn(500, 1); % random dist with std = 0.05
randmN = randmN + 1; % shift the distribution so there's no negatives
gain = zeros(length(randmN), 1);
omega = pi;

% Equate for random perturbations
for i = 1:length(randmN)
    numer = (G + 1i*omega.*C.*randmN(i)); % add random variation to C
    V = numer\F; 
    gain(i) = 20.*log(abs(V(5))); %detemrine magnitude in dB of complex value
end

% Plot the histogram of perturbations
figure (3)
histogram(gain);
title('Gain(w) = Vo/V1 With C Perturbations');
xlabel('Gain [dB]'); 
ylabel('Number');
