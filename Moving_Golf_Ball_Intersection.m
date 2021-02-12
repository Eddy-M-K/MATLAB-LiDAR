function Moving_Golf_Ball_Intersection(Azimuth, sphere_moving_x, sphere_moving_y, sphere_moving_z, r, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z)
    fprintf("Moving Golf Ball Intersection:\n");
    for position = 1:length(sphere_moving_x)
        for Vertical_Angle = -15:2:15
            P_Start = [Radius_Start*sind(Azimuth) + LiDAR_x, ...
                    Radius_Start*cosd(Azimuth) + LiDAR_y, ...
                    LiDAR_z];

            P_End = [Radius_End*sind(Azimuth)*cosd(Vertical_Angle) + LiDAR_x, ...
                    Radius_End*cosd(Azimuth)*cosd(Vertical_Angle) + LiDAR_y, ...
                    Radius_End*sind(Vertical_Angle) + LiDAR_z];
            
            slope = P_End - P_Start;

            A = slope(1)^2 + slope(2)^2 + slope(3)^2;
            B = 2*(slope(1)*(P_Start(1) - sphere_moving_x(position)) + slope(2)*(P_Start(2) - sphere_moving_y(position)) + slope(3)*(P_Start(3) - sphere_moving_z(position)));
            C = (P_Start(1) - sphere_moving_x(position))^2 + (P_Start(2) - sphere_moving_y(position))^2 + (P_Start(3) - sphere_moving_z(position))^2 - r^2;
            
            Delta = B^2 - 4*A*C;

            if (Delta == 0)
                s = -B/2*A;
                p_F = [P_Start(1) + s*slope(1), P_Start(2) + s*slope(2), P_Start(3) + s*slope(3)]
                plot3([P_Start(1) p_F(1)], [P_Start(2) p_F(2)], [P_Start(3) p_F(3)]);
                fprintf("Point of Intersection = [%13.4f, %13.4f, %13.4f]  |  Azimuth = %10.4f  |  Vertical Angle = %3.0f\n", ...
                    P_FL(1), P_FL(2), P_FL(3), Azimuth, Vertical_Angle);
            elseif (Delta > 0)
                syms d;
                s = solve((P_Start(1) + d*slope(1) - sphere_moving_x(position))^2+(P_Start(2) + d*slope(2) - sphere_moving_y(position))^2+(P_Start(3) + d*slope(3) - sphere_moving_z(position))^2 == r^2, d);
                
                P1 = [P_Start(1) + s(1)*slope(1), P_Start(2) + s(1)*slope(2), P_Start(3) + s(1)*slope(3)];
                P2 = [P_Start(1) + s(2)*slope(1), P_Start(2) + s(2)*slope(2), P_Start(3) + s(2)*slope(3)];
                
                if ((s(1) < 0) & (s(2) < 0))
                    continue
                elseif (s(1) < 0)
                    P_FL = P2
                elseif (s(2) < 0)
                    P_FL = P1
                elseif (norm(P1-P_Start) < norm(P2-P_Start))
                    P_FL = P1;
                else
                    P_FL = P2;
                end
                
                Plot_Print(P_Start, P_FL, Azimuth, Vertical_Angle, sphere_moving_x(position), sphere_moving_y(position), sphere_moving_z(position))
                Sphere(sphere_moving_x(position), sphere_moving_y(position), sphere_moving_z(position), r)    
            end
        end
        Azimuth = Azimuth + Azimuth_Resolution;
    end
    title('Moving Golf Ball Intersection')
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    daspect([1 1 1])
    fprintf("\n");
end