function Perpendicular_Rotated_LiDAR_Emission_Pattern(FOV_Start, FOV_End, Lower_Angle, Upper_Angle, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z)
    for Azimuth=FOV_Start:Azimuth_Resolution:FOV_End
        for Vertical_Angle=Lower_Angle:2:Upper_Angle
            P_Start = [LiDAR_x, ...
                    Radius_Start*cosd(Azimuth) + LiDAR_y, ...
                    Radius_Start*sind(Azimuth) + LiDAR_z];

            P_End = [Radius_End*sind(Vertical_Angle) + LiDAR_x, ...
                    Radius_End*cosd(Azimuth)*cosd(Vertical_Angle) + LiDAR_y, ...
                    Radius_End*sind(Azimuth)*cosd(Vertical_Angle) + LiDAR_z];

            plot3([P_Start(1) P_End(1)], [P_Start(2) P_End(2)], [P_Start(3) P_End(3)], 'LineWidth', 2.0);
        end
    end
    title('LiDAR Emission Pattern Perpendicular to Golf Ball Trajectory')
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    daspect([1 1 1])
end