function Golf_Ball_Trajectory(sphere_moving_x, sphere_moving_y, sphere_moving_z, r)
    for position = 1:length(sphere_moving_x)
        [x y z] = sphere;
        x = x * r;
        y = y * r;
        z = z * r;
        surf(x + sphere_moving_x(position), y + sphere_moving_y(position), z + sphere_moving_z(position));
    end
    title('Golf Ball Trajectory')
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    daspect([1 1 1])
end