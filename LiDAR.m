clc
close all
clearvars
hold on
format long

Radius_Start = 0.04191;

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
Radius_End = 0.04267 * sind((180-Azimuth_Resolution) / 2) / sind(Azimuth_Resolution);

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

% FOV_Start = 270;
% FOV_End = 450;
% Lower_Angle = -15;
% Upper_Angle = 15;
% 
% sphere_moving_position1 = readmatrix('LiDAR.xlsx');
% sphere_moving_x1 = sphere_moving_position1(:,1);
% sphere_moving_y1 = sphere_moving_position1(:,3);
% sphere_moving_z1 = sphere_moving_position1(:,2);   
% 
% LiDAR_Emission_Pattern(FOV_Start, FOV_End, Lower_Angle, Upper_Angle, 10, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z)
% Golf_Ball_Trajectory(sphere_moving_x1, sphere_moving_y1, sphere_moving_z1, r)    
% 
% sphere_moving_position2 = readmatrix('LiDAR_Precise.xlsx');
% sphere_moving_x2 = sphere_moving_position2(:,1);
% sphere_moving_y2 = sphere_moving_position2(:,3);
% sphere_moving_z2 = sphere_moving_position2(:,2);
% 
% hold off
% figure
% hold on
% 
% Azimuth = 0;
% Moving_Golf_Ball_Intersection(Azimuth, sphere_moving_x2, sphere_moving_y2, sphere_moving_z2, r, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z)

% -------------------------------------------------------------------------

FOV_Start = 270;
FOV_End = 450;
Lower_Angle = -15;
Upper_Angle = 15;

sphere_moving_position3 = readmatrix('LiDAR2.xlsx');
sphere_moving_x3 = sphere_moving_position3(:,1);
sphere_moving_y3 = sphere_moving_position3(:,3);
sphere_moving_z3 = sphere_moving_position3(:,2);   

LiDAR_Emission_Pattern(FOV_Start, FOV_End, Lower_Angle, Upper_Angle, 10, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z)
Golf_Ball_Trajectory(sphere_moving_x3, sphere_moving_y3, sphere_moving_z3, r)    

sphere_moving_position4 = readmatrix('LiDAR2_Precise.xlsx');
sphere_moving_x4 = sphere_moving_position4(:,1);
sphere_moving_y4 = sphere_moving_position4(:,3);
sphere_moving_z4 = sphere_moving_position4(:,2);

hold off
figure
hold on

Azimuth = 0;
Precise_Moving_Golf_Ball_Intersection(Precise_Azimuth, sphere_moving_x4, sphere_moving_y4, sphere_moving_z4, r, Precise_Azimuth_Resolution, Radius_Start, 10, LiDAR_x, LiDAR_y, LiDAR_z)