clc;
clear all;
clear;

%% Variables 
% Torque 
T = 800;% in oz
% Angular Velocity 
Vang = 2; % rpm
% Length of link 1
L1 = 7;
% Length of link 2
L2 = 9;
% Length of link 3
L3 = 12;
% Space between the mount and motor
L4 = 10;
% Theta A
thetaA = ;
% Theta B
thetaB = ;
% Theta C
thetaC = ;
% thickness
t = [(1/8),(3/16),(1/4),(1/8),(1/4)]; %inches
% width
w = .51; inches
% Elastic Modulus 
E = .363 * 10^6; % ksi
% Yield Stress
Sy = 8.7 ; %ksi
% Yield Strength 
Sys = 7.05 ; %ksi
% Diameter of hole
d = .31 ; % inches
% Max Force 
Fmax = ;
% Force at initial contact with button 
Fmid = ;
% Min Force 
Fmin = ; 
%  Kt
Kt = 2.2;
% C
C = 1;

%% Under max Force (when longest bar is ~ at a right angle with the normal) 
%Ixx
I =(1/12)*(t*w^3)
% Axial Stress
Sax = (Fmax)/((w-d)*t);
% Stress Concentration
Sconc = (Kt*Fmax)/((w-d)*t);
% Buckling 
Fcrit = (C *(pi^2)*E*I)/(L^2);

%% Analysis as theta changes 

% Force on crank 
Fc=(Fmid)/(sin(thetaB)+(tan(thetaA)*cos(thetaB)));
% Component of Reaction force at C in x direction
Cx = (Fmid*cos(thetaB))/((sin(thetaB)+(tan(thetaA)*cos(thetaB))));
% Component of Reaction force at C in y direction
Cy = (Fmid*sin(thetaB))/((sin(thetaB)+(tan(thetaA)*cos(thetaB))));
% Moment at C
M = (Fmid*Lc)/((sin(thetaB)+(tan(thetaA)*cos(thetaB))));
% Shear in crank 
Vc = (((Cy *sin(thetaC)*cos(thetaC))-(Cx*(cos(thetaC))^2))/((cos(thetaC)^2*sin(thetaC)+(sin(thetaC))^2)))+...
    (Cx/sin(thetaC));
% Tension in crank 
Tc = ((Cy*sin(thetaC))-(Cx * cos(thetaC))/((cos(thetaC))^2+ sin(thetaC));

% Moment at C
Mc = Vc*Lc+Fc*Lc;

%% Optomize Geometry 

for t = [(1/8),(3/16),(1/4),(1/8),(1/4)];
    
    






%% Find Relationship Between Force and Theta




