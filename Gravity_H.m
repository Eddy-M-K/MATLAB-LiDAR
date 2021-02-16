function [sphere_moving_x, sphere_moving_y, sphere_moving_z] = Gravity_H(v0, theta, dt)
    rho = 1.225; 
    grav =9.81; 
    mass = 0.042672; 
    diameter = 0.042672;
    Area = pi*diameter^2/4;
    Cd = 0.2;
    Cl = 0.2;

    theta = pi * theta / 180;
    
    vx = v0*cos(theta);
    vz = v0*sin(theta);
    
    x = 0;
    z = 0;

    vx = v0*cos(theta);
    vz = vz - grav*dt;

    x = x + vx*dt;
    z = z + vz*dt;
    
    sphere_moving_x = x;
    sphere_moving_z = z;
    
    while true
        vx = v0*cos(theta);
        vz = vz - grav*dt;
        
        x = x + vx*dt;
        z = z + vz*dt;
        
        if (z < 0)
            break
        end
        
        sphere_moving_x = [sphere_moving_x; x];
        sphere_moving_z = [sphere_moving_z; z];
    end
    sphere_moving_y = zeros(length(sphere_moving_x), 1);
    Plot_Trajectory_H(sphere_moving_x, sphere_moving_y, sphere_moving_z)
end