# MATLAB-LiDAR

This repository includes MATLAB code for the simulation of the Velodyne VLP-16 LiDAR sensor as well as algorithms for finding the intersections of the emitted lasers with triangles and golf balls. Intersections with golf balls are calculated through generation of a golf ball's trajectory under situations such as gravity, drag, lift.

When pulling this code, create a copy of the main.m file on your local machine, called "Copy of main.m", which will be the main script you can edit and use to call functions. Helper functions which should not be called by the user within the duplicate main.m have the "\_H" tag at the end of the file name. Further instructions on the code and how to call the functions can be found within the main.m file (As noted previously, please ensure you create a duplicate and do not edit the original main.m template file).

Credit for the logic implemented within Drag.m, Lift.m, Both.m, and Gravity.m which are files used to generate a golf ball's trajectory, go to UW Chemical Engineering Student Rama Al-Enzy.
