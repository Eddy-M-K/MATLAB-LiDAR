# MATLAB-LiDAR

This repository includes MATLAB code for the simulation of the Velodyne VLP-16 LiDAR sensor as well as algorithms for finding the intersections of the emitted lasers with triangles and moving golf balls. Intersections with golf balls are calculated through generation of a golf ball's trajectory under situations such as gravity, drag, and lift.

Call any functions to use the simulator within main.m. Helper functions, which should not be called by the user within the main.m file, have the "\_H" tag at the end of the file name. 

## Example:

The code is customizable so that multiple instances of VLP-16s can be placed along the golf ball's trajectory with options to rotate the sensor and use it in a way that takes advantage of the horizontally spinning lasers. Below is an example where the user has chosen Lift, Drag and Gravity conditions with a golf shot with initial velocity 45 m/s, an angle of 12 degrees, 1 rad/s for rifle spin, side spin, and back spin, and 1 degree for spin angle.

<p align="center"><img src="https://user-images.githubusercontent.com/39893918/131205703-d2da84d6-8d86-4871-b5fd-72d56315d2da.png"/> </p>

4 LiDAR sensors, two upright and two placed on their side so that the rotation of lasers run perpendicular to the golf ball's trajectory, have the following x, y, z positions:

<p align="center"><img src="https://user-images.githubusercontent.com/39893918/131205831-ed6b1071-ea29-4ac9-aa1d-20d7a4c7fea5.png"/> </p>

and their functions are called as ```Precise_Moving_Golf_Ball_Intersection``` and ```Parallel_Rotated_Precise_Moving_Golf_Ball_Intersection```. The result is a general trajectory and emission pattern diagram as well as a diagram of just the theoretical intersections that would appear:

<p align="center"><img src="https://user-images.githubusercontent.com/39893918/131205933-8344c196-c086-4f3e-a7bd-84ea7460b2f9.png" width="450"/><img src="https://user-images.githubusercontent.com/39893918/131205961-e217c3aa-e443-4c8d-abad-ac32579d45be.png" width="450"/> </p>

Output is exported as an xlsx file:

<p align="center"><img src="https://user-images.githubusercontent.com/39893918/131206108-547b1ffe-bd0b-4e82-8abe-c189c0528bc2.png"/> </p>

Credit for the logic implemented within Drag.m, Lift.m, Both.m, and Gravity.m which are files used to generate a golf ball's trajectory, go to UW Chemical Engineering Student Rama Al-Enzy.
