function [sphere_moving_x, sphere_moving_y, sphere_moving_z] = Trajectory_Generation_Selection(dt)
    Selection = input("Lift, Drag, Both, or just Gravity: ", 's');
    if strcmpi(Selection, 'Drag-H')
        v0 = input("Inital velocity in m/s: ");
        theta = input("Angle of the velocity in degrees: ");
        [sphere_moving_x, sphere_moving_y, sphere_moving_z] = Drag(v0, theta, dt);
    elseif strcmpi(Selection, 'Lift-H')
        v0 = input("Inital velocity in m/s: ");
        theta = input("Angle of the velocity in degrees: ");
        wx = input("Rifle spin in rads/sec: ");
        wy = input("Side spin in rads/sec: ");
        wz = input("Back spin in rads/sec: ");
        phi = input("Spin angle in degrees: ");
        [sphere_moving_x, sphere_moving_y, sphere_moving_z] = Lift(v0, theta, wx, wy, wz, phi, dt);
    elseif strcmpi(Selection, 'Both-H')
        v0 = input("Inital velocity in m/s: ");
        theta = input("Angle of the velocity in degrees: ");
        wx = input("Rifle spin in rads/sec: ");
        wy = input("Side spin in rads/sec: ");
        wz = input("Back spin in rads/sec: ");
        phi = input("Spin angle in degrees: ");
        [sphere_moving_x, sphere_moving_y, sphere_moving_z] = Both(v0, theta, wx, wy, wz, phi, dt);
    elseif strcmpi(Selection, 'Gravity-H')
        v0 = input("Inital velocity in m/s: ");
        theta = input("Angle of the velocity in degrees: ");
        [sphere_moving_x, sphere_moving_y, sphere_moving_z] = Gravity(v0, theta, dt);
    end 
    fprintf("\n")
end

