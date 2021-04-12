% IMPORTANT: This is a template main.m file which calls other functions
% that don't have the _H tag (files with _H tags are helper functions). 

% Files that are named with "deprecated" are old simulations that are
% relatively inaccurate compared to the newer intersection finders that are
% named "Precise Moving Golf Ball Intersection"

% All values are in meters.

clc
close all
clearvars
format long

Radius_Start = 0.04191; % Starting length of laser beam
r = 0.021335;           % Golf ball radius

% Baseball radius is 0.0375;
% Tennis Ball radius is 0.03429;

% IMPORTANT: If changing to a different ball, ensure you change the mass 
% and diameter values within Both_H.m or the relevant trajectory generation 
% option you will be choosing (Both_H., Drag_H.m, Lift_H.m, Gravity_H.m)

% RPM must be in increments of 60 from 300 to 1200
RPM = 1200; 

% -------------------------------------------------------------------------

% Laser Intersection with Triangle(s) (Deprecated)
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

% -------------------------------------------------------------------------

% Laser Intersection with Static Golf Ball(s) (Deprecated)
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

% -------------------------------------------------------------------------

% Example code to generate golf ball trajectory and implement multiple, accurate
% LiDAR simulations to detect intersections

dt = 2.304*10^-6;                                               % Should remain constant
Precise_Azimuth_Resolution = RPM / 60 * 360 * 2.304*10^-6;      % Should remain constant

% Change LiDAR's start Azimuth position (Default is 0):
Precise_Azimuth = 0; % RPM / 60 * 360 * 2.304*10^-6 * 16 * (Enter Whole number here)

% Radius of LiDAR sensor lasers 
Radius_End = 10; 

%Should remain constant
FOV_Start = 0;
FOV_End = 359;
Lower_Angle = -15;
Upper_Angle = 15;
Azimuth_Resolution = 30;

% LiDAR positions in order (Currently there are 4 but more can be added):

LiDAR_x1 = 5;
LiDAR_y1 = 0;
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

% FROM HERE: call the LiDAR emission pattern functions according to where
% they should be - note that there are perpendicular and parallel
% configurations as well as the standard upright position:

hold on 
LiDAR_Emission_Pattern(FOV_Start, FOV_End, Lower_Angle, Upper_Angle, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x1, LiDAR_y1, LiDAR_z1)
Perpendicular_Rotated_LiDAR_Emission_Pattern(FOV_Start, FOV_End, Lower_Angle, Upper_Angle, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x2, LiDAR_y2, LiDAR_z2)
Perpendicular_Rotated_LiDAR_Emission_Pattern(FOV_Start, FOV_End, Lower_Angle, Upper_Angle, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x3, LiDAR_y3, LiDAR_z3)
LiDAR_Emission_Pattern(FOV_Start, FOV_End, Lower_Angle, Upper_Angle, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x4, LiDAR_y4, LiDAR_z4)

% -------------------------------------------------------------------------

% The below function prompts the user for the conditions for the golf
% ball's trajectory, generates the golf ball's position, plots it, and
% passes it onto the Precise Moving Golf Ball Intersection functions below
[sphere_moving_x, sphere_moving_y, sphere_moving_z] = Trajectory_Generation_Selection(dt);

hold off
figure 
hold on

Export = {'Point of Intersection (x)', 'Point of Intersection (y)', 'Point of Intersection (z)', 'Azimuth', 'Vertical Angle', 'Sphere Center (x)', 'Sphere Center (y)', 'Sphere Center (z)'};

% FROM HERE: call the functions "Precise Moving Golf Ball Intersection"
% according to the configuration needed. The function calls should match in
% type and count of the functions called for the emission pattern above

Export = Precise_Moving_Golf_Ball_Intersection(Precise_Azimuth, sphere_moving_x, sphere_moving_y, sphere_moving_z, r, Precise_Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x1, LiDAR_y1, LiDAR_z1, Export);
Export = Parallel_Rotated_Precise_Moving_Golf_Ball_Intersection(Precise_Azimuth, sphere_moving_x, sphere_moving_y, sphere_moving_z, r, Precise_Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x2, LiDAR_y2, LiDAR_z2, Export);
Export = Parallel_Rotated_Precise_Moving_Golf_Ball_Intersection(Precise_Azimuth, sphere_moving_x, sphere_moving_y, sphere_moving_z, r, Precise_Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x3, LiDAR_y3, LiDAR_z3, Export);
Export = Precise_Moving_Golf_Ball_Intersection(Precise_Azimuth, sphere_moving_x, sphere_moving_y, sphere_moving_z, r, Precise_Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x4, LiDAR_y4, LiDAR_z4, Export);

% -------------------------------------------------------------------------

filename = 'Exported Points of Intersections (MATLAB LiDAR Simulation).xlsx';
writecell(Export, filename);

% What results is a figure displaying the general golf ball trajectory and
% the general LiDAR emission patterns, and another figure with only the
% intersection lasers. Data is outputted in both the console and in an
% Excel file