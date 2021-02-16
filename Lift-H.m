function [sphere_moving_x, sphere_moving_y, sphere_moving_z] = Lift(v0, theta, wx, wy, wz, phi, dt)
    rho = 1.225; 
    grav =9.81; 
    mass = 0.042672; 
    diameter = 0.042672;
    Area = pi*diameter^2/4;
    Cd = 0.2;
    Cl = 0.2;

    theta = pi * theta / 180;
    phi = pi * phi / 180;
    
    omega = (wx^2 + wy^2 + wz^2);
    if omega ~= 0
        tx = wx/omega;
        ty = wy/omega;
        tz = wz/omega;
    else
        tx = 0;
        ty = 0;
        tz = 0;
    end
    
    vx = v0*cos(theta)*cos(phi);
    vy = -(v0*cos(theta)*sin(phi));
    vz = v0*sin(theta);
    
    x = 0;
    y = 0;
    z = 0;
    
    speed = sqrt(vx^2 + vy^2 + vz^2);
    Q = rho*speed^2*Area/2;
    vx = vx + (Q*Cl*(ty*vz-tz*vy)/speed)*dt/mass;
    vy = vy + (Q*Cl*(tx*vy-ty*vx)/speed)*dt/mass;
    vz = vz + (Q*Cl*(tz*vx-tx*vz)/speed)*dt/mass - grav*dt;

    x = x + vx*dt;
    y = y + vy*dt;
    z = z + vz*dt;
    
    sphere_moving_x = x;
    sphere_moving_y = y;
    sphere_moving_z = z;
    
    while true
        speed = sqrt(vx^2 + vy^2 + vz^2);
        Q = rho*speed^2*Area/2;
        vx = vx + (Q*Cl*(ty*vz-tz*vy)/speed)*dt/mass;
        vy = vy + (Q*Cl*(tx*vy-ty*vx)/speed)*dt/mass;
        vz = vz + (Q*Cl*(tz*vx-tx*vz)/speed)*dt/mass - grav*dt;
        
        x = x + vx*dt;
        y = y + vy*dt;
        z = z + vz*dt;
              
        if z < 0
            break
        end
        
        sphere_moving_x = [sphere_moving_x; x];
        sphere_moving_y = [sphere_moving_y; y];
        sphere_moving_z = [sphere_moving_z; z];
    end
    Plot_Trajectory(sphere_moving_x, sphere_moving_y, sphere_moving_z)
end