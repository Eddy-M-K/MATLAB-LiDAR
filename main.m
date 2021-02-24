% IMPORTANT: This is a template main.m file which calls other functions
% that don't have the _H tag (files with _H tags are helper functions).
% Create a copy of this file called "Copy_of_main" for your local system 
% if you plan to commit changes to the repository. 

% All values are in meters.

clc
close all
clearvars
format long

% Variables that should remain constant for accuracy:
Radius_Start = 0.04191; % Starting length of laser beam
r = 0.021335;           % Golf ball radius

% IMPORTANT: If changing to a different ball, ensure you change the mass 
% and diameter values within Both_H.m or the relevant trajectory generation 
% function you will be calling:

% Baseball radius 0.0375;
% Tennis Ball radius 0.03429;

% RPM must be in increments of 60 from 300 to 1200
RPM = 1200; 

% -------------------------------------------------------------------------
% Laser Intersection with Triangle(s) (Inaccurate)
%
% Triangle vertices:
% P1 = [1 0 2];
% P2 = [0 1 0];
% P3 = [2 2 -3];
% 
% LiDAR Sensor Location Shift:
% LiDAR_x = 0;
% LiDAR_y = 0;
% LiDAR_z = 0;
%
% Azimuth_Resolution = RPM / 60 * 360 * 55.296*10^-6;
%
% Radius_End = 0.042672 * sind((180-Azimuth_Resolution) / 2) / sind(Azimuth_Resolution);
% 
% Function Call(s):
% Triangle_Intersection(P1, P2, P3, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z)
%
% -------------------------------------------------------------------------
% Laser Intersection with Static Golf Ball(s) (Inaccurate)
%
% Shift golf ball's center:
% sphere_shift_x = 2;
% sphere_shift_y = -0.5;
% sphere_shift_z = 0.1;
% 
% LiDAR Sensor Location Shift:
% LiDAR_x = 0;
% LiDAR_y = 0;
% LiDAR_z = 0;
% 
% Azimuth_Resolution = RPM / 60 * 360 * 55.296*10^-6;
%
% Radius_End = 0.042672 * sind((180-Azimuth_Resolution) / 2) / sind(Azimuth_Resolution);
%
% Function Call(s):
% Static_Golf_Ball_Intersection(sphere_shift_x, sphere_shift_y, sphere_shift_z, r, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z)
% 
% -------------------------------------------------------------------------
% General Laser Emission Pattern Generation of a VLP-16 for Visualization
% Purposes (Inaccurate)
%
% FOV_Start = 0;
% FOV_End = 359;
% Lower_Angle = -15;
% Upper_Angle = 15;
%
% Function Call(s):
% LiDAR_Emission_Pattern(FOV_Start, FOV_End, Lower_Angle, Upper_Angle, 10, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z)
%
% -------------------------------------------------------------------------
% Example code to generate golf ball trajectory and implement multiple, accurate
% LiDAR simulations to detect intersections

dt = 2.304*10^-6;
Precise_Azimuth_Resolution = RPM / 60 * 360 * 2.304*10^-6;

% Change LiDAR's start Azimuth position for spinning (Default is 0):
Precise_Azimuth = 0; % RPM / 60 * 360 * 2.304*10^-6 * 16 * (Enter Whole number here)

Radius_End = 10; % (Or some number)

FOV_Start = 0;
FOV_End = 359;
Lower_Angle = -15;
Upper_Angle = 15;
Azimuth_Resolution = 30;

% LiDAR positions in order:

LiDAR_x1 = 7;
LiDAR_y1 = -1;
LiDAR_z1 = 1;

LiDAR_x2 = 40;
LiDAR_y2 = -3;
LiDAR_z2 = 0;

LiDAR_x3 = 65;
LiDAR_y3 = -5;
LiDAR_z3 = 0;

LiDAR_x4 = 95;
LiDAR_y4 = -10;
LiDAR_z4= 0;

hold on 
LiDAR_Emission_Pattern(FOV_Start, FOV_End, Lower_Angle, Upper_Angle, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x1, LiDAR_y1, LiDAR_z1)
Perpendicular_Rotated_LiDAR_Emission_Pattern(FOV_Start, FOV_End, Lower_Angle, Upper_Angle, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x2, LiDAR_y2, LiDAR_z2)
Perpendicular_Rotated_LiDAR_Emission_Pattern(FOV_Start, FOV_End, Lower_Angle, Upper_Angle, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x3, LiDAR_y3, LiDAR_z3)
LiDAR_Emission_Pattern(FOV_Start, FOV_End, Lower_Angle, Upper_Angle, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x4, LiDAR_y4, LiDAR_z4)

[sphere_moving_x, sphere_moving_y, sphere_moving_z] = Trajectory_Generation_Selection(dt);

hold off
figure 
hold on

Export = {'Point of Intersection (x)', 'Point of Intersection (y)', 'Point of Intersection (z)', 'Azimuth', 'Vertical Angle', 'Sphere Center (x)', 'Sphere Center (y)', 'Sphere Center (z)'};

Export = Precise_Moving_Golf_Ball_Intersection(Precise_Azimuth, sphere_moving_x, sphere_moving_y, sphere_moving_z, r, Precise_Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x1, LiDAR_y1, LiDAR_z1, Export);
Export = Perpendicular_Rotated_Precise_Moving_Golf_Ball_Intersection(Precise_Azimuth, sphere_moving_x, sphere_moving_y, sphere_moving_z, r, Precise_Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x2, LiDAR_y2, LiDAR_z2, Export);
Export = Perpendicular_Rotated_Precise_Moving_Golf_Ball_Intersection(Precise_Azimuth, sphere_moving_x, sphere_moving_y, sphere_moving_z, r, Precise_Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x3, LiDAR_y3, LiDAR_z3, Export);
Export = Precise_Moving_Golf_Ball_Intersection(Precise_Azimuth, sphere_moving_x, sphere_moving_y, sphere_moving_z, r, Precise_Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x4, LiDAR_y4, LiDAR_z4, Export);

filename = 'Exported Points of Intersections (MATLAB LiDAR Simulation).xlsx';
writecell(Export, filename);