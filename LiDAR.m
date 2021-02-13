clc
close all
clearvars
format long

Radius_Start = 0.04191;
dt = 2.304*10^-6;

% RPM must be in increments of 60 from 300 to 1200
RPM = 1200; 

% Golf ball radius
r = 0.021335; 

% LiDAR Sensor Location Shift
LiDAR_x = 6;
LiDAR_y = -2.3;
LiDAR_z = 0.7;

% Azimuth Resolution Calculation for Non Accurate Calculations where 16
% Lasers are assumed to fire at once
Azimuth_Resolution = RPM / 60 * 360 * 55.296*10^-6;

% Radius_End for Non Accurate Azimuth_Resolution
Radius_End = 0.042672 * sind((180-Azimuth_Resolution) / 2) / sind(Azimuth_Resolution);

% Precise Azimuth Resolution Calculation for Accurate Calculations 
Precise_Azimuth_Resolution = RPM / 60 * 360 * 2.304*10^-6;

% Change LiDAR's start Azimuth position for spinning (Default is 0)
Precise_Azimuth = 0; % RPM / 60 * 360 * 2.304*10^-6 * 16 * (Enter Whole number here)

% -------------------------------------------------------------------------

% Change triangles' vertices; use values as arguments for additional
% function calls to Triangle_Intersection
%     P1 = [1 0 2];
%     P2 = [0 1 0];
%     P3 = [2 2 -3];
% 
% Function Calls
% Triangle_Intersection(P1, P2, P3, Azimuth_Resolution, Radius_Start, Radius_End)

% -------------------------------------------------------------------------

% Shift sphere's center:
% sphere_shift_x = 2;
% sphere_shift_y = -0.5;
% sphere_shift_z = 0.1;

% Function Calls
% Golf_Ball_Intersection(sphere_shift_x, sphere_shift_y, sphere_shift_z, r, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z)

% -------------------------------------------------------------------------

FOV_Start = 270;
FOV_End = 450;
Lower_Angle = -15;
Upper_Angle = 15;

hold on 
LiDAR_Emission_Pattern(FOV_Start, FOV_End, Lower_Angle, Upper_Angle, 10, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z)
[sphere_moving_x4, sphere_moving_y4, sphere_moving_z4] = Trajectory_Generation_Selection(dt);

hold off
figure 
hold on
C = Precise_Moving_Golf_Ball_Intersection(Precise_Azimuth, sphere_moving_x4, sphere_moving_y4, sphere_moving_z4, r, Precise_Azimuth_Resolution, Radius_Start, 10, LiDAR_x, LiDAR_y, LiDAR_z)
filename = 'Exported Points of Intersections (MATLAB LiDAR Simulation).xlsx';
writecell(C, filename);