# MATLAB-LiDAR

This repository includes MATLAB code for the simulation of the Velodyne VLP-16 LiDAR sensor as well as algorithms for finding the intersections of the emitted lasers with triangles and golf balls. Intersections with golf balls are calculated through generation of a golf ball's trajectory under situations such as gravity, drag, and lift.

Call any functions to use the simulator within main.m Helper functions, which should not be called by the user within the main.m file, have the "\_H" tag at the end of the file name. Further instructions on the code and how to call the functions can be found within the main.m file.

Credit for the logic implemented within Drag.m, Lift.m, Both.m, and Gravity.m which are files used to generate a golf ball's trajectory, go to UW Chemical Engineering Student Rama Al-Enzy.
