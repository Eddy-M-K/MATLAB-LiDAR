function Plot_Trajectory(sphere_moving_x, sphere_moving_y, sphere_moving_z)
    plot3(sphere_moving_x, sphere_moving_y, sphere_moving_z, '.', 'Color', 'Red')
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    daspect([1 1 1])
    title('Golf Ball Trajectory')
end