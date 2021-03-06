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
%Moment Arm 
Lc = 10; 
% Theta A
thetaA = 0;
% Theta B
thetaB = 0;
% Theta C
thetaC = 0;
% thickness
thick = [(1/8),(3/16),(1/4)]; %inches
t = 3/16; %inches 
% width
w = .51; %inches
% Elastic Modulus 
E = .363 * 10^6; % ksi
% Yield Stress
Sy = 8.7 ; %ksi
% Yield Strength 
Sys = 7.05 ; %ksi
% Diameter of hole
d = .31 ; % inches
% Max Force 
Fmax = 7; %lbs
% Force at initial contact with button 
Fmid = 7; %lbs 
% Min Force 
Fmin = 0; 
%  Kt
Kt = 2.2;
% C
C = 1;

%% Under max Force (when longest bar is ~ at a right angle with the normal) 
%Ixx
I =(1/12)*(t*w^3)
% Axial Stress
Sax = (Fmax)./((w-d).*t);
% Stress Concentration
Sconc = (Kt*Fmax)/((w-d)*t);
% Buckling 
Fcrit = (C *(pi^2)*E*I)/(L1^2);

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
%Tc = ((Cy*sin(thetaC))-(Cx * cos(thetaC))/((cos(thetaC))^2+ sin(thetaC));

% Moment at C
Mc = Vc*Lc+Fc*Lc;

%% Optimize Geometry
%plotting axial stress


%Calculated Axial Stress Values 
axial_stress = [];

%Calculated Buckling Values 
buckling_stress = []; 

for t = 1:length(thick)
     axial_stress(t) = (Fmax)./((w-d).*t);
     buckling_stress(t) = (C *(pi^2)*E*(1/12)*(t*w^3))/(L1^2); 
end  

disp(axial_stress) 
disp(buckling_stress) 



%% Find Relationship Between Force and Theta

thetaA = [30, 45, 60, 80, 90]; 
Force_c = []; 

for i = 1:length(thetaA)
    thetaB = 90 - thetaA(i); 
    Force_c(i) = (Fmid)/(sin(thetaB)+(tan(thetaB)*cos(thetaB)));
end


%% Plots 

figure(1)
plot(thick, axial_stress, "r--", "LineWidth", 3)
hold on
sz = 50 
s = scatter(thick, axial_stress, sz, "filled")
s.LineWidth = 0.6;
s.MarkerEdgeColor = 'b';
s.MarkerFaceColor = [0 0.5 0.5];
 
xlabel("Material Thickness, inches") 
ylabel("Calculated Axial Stress, psi") 
title("NASA Airlock Design - Axial Stress vs Material Thickness") 

figure(2) 
plot(thick, buckling_stress, "r--", "LineWidth", 3)
hold on
sz = 50 
s = scatter(thick, buckling_stress, sz, "filled")
s.LineWidth = 0.6;
s.MarkerEdgeColor = 'b';
s.MarkerFaceColor = [0 0.5 0.5];
 
xlabel("Material Thickness, inches") 
ylabel("Calculated Buckling Stress, psi") 
title("NASA Airlock Design - Buckling Stress vs Material Thickness") 


figure(3)
plot(thetaA, Force_c, "r--", "LineWidth", 3)
hold on
sz = 50 
s = scatter(thetaA, Force_c, sz, "filled")
s.LineWidth = 0.6;
s.MarkerEdgeColor = 'b';
s.MarkerFaceColor = [0 0.5 0.5];
 
xlabel("Angle, degrees") 
ylabel("Calculated Force on Crank, psi") 
title("NASA Airlock Design - Crank Force and Angle Relationship")

