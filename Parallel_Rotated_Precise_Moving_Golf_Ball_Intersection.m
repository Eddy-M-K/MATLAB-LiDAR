function [Export] = Parallel_Rotated_Precise_Moving_Golf_Ball_Intersection(Precise_Azimuth, sphere_moving_x, sphere_moving_y, sphere_moving_z, r, Precise_Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z, Export)
    fprintf("Rotated Precise Moving Golf Ball Intersection (Parallel to Golf Ball Flight):\n");
    position = 1;
    while position <= length(sphere_moving_x)
        for Vertical_Angle = 15:-2:-15
            P_Start = [Radius_Start*cosd(Precise_Azimuth) + LiDAR_x, ...
                    LiDAR_y, ...
                    Radius_Start*sind(Precise_Azimuth) + LiDAR_z];

            P_End = [Radius_End*cosd(Precise_Azimuth)*cosd(Vertical_Angle) + LiDAR_x, ...
                    Radius_End*sind(Vertical_Angle) + LiDAR_y, ...
                    Radius_End*sind(Precise_Azimuth)*cosd(Vertical_Angle) + LiDAR_z];
            
            slope = P_End - P_Start;

            A = slope(1)^2 + slope(2)^2 + slope(3)^2;
            B = 2*(slope(1)*(P_Start(1) - sphere_moving_x(position)) + slope(2)*(P_Start(2) - sphere_moving_y(position)) + slope(3)*(P_Start(3) - sphere_moving_z(position)));
            C = (P_Start(1) - sphere_moving_x(position))^2 + (P_Start(2) - sphere_moving_y(position))^2 + (P_Start(3) - sphere_moving_z(position))^2 - r^2;
            
            Delta = B^2 - 4*A*C;

            if (Delta == 0)
                s = -B/2*A;
                p_FL = [P_Start(1) + s*slope(1), P_Start(2) + s*slope(2), P_Start(3) + s*slope(3)];
                plot3([P_Start(1) p_FL(1)], [P_Start(2) p_FL(2)], [P_Start(3) p_FL(3)]);
                fprintf("Point of Intersection = [%13.4f, %13.4f, %13.4f]  |  Azimuth = %10.4f  |  Vertical Angle = %3.0f\n", ...
                    P_FL(1), P_FL(2), P_FL(3), Precise_Azimuth, Vertical_Angle);
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
                
                Plot_Print_H(P_Start, P_FL, Precise_Azimuth, Vertical_Angle, sphere_moving_x(position), sphere_moving_y(position), sphere_moving_z(position))
                Sphere_H(sphere_moving_x(position), sphere_moving_y(position), sphere_moving_z(position), r) 
                Data = {double(P_FL(1)), double(P_FL(2)), double(P_FL(3)), Precise_Azimuth, Vertical_Angle, sphere_moving_x(position), sphere_moving_y(position), sphere_moving_z(position)};
                Export = [Export; Data];
            end
            Precise_Azimuth = Precise_Azimuth + Precise_Azimuth_Resolution;
            position = position + 1;
            if position > length(sphere_moving_x)
                break
            end
        end
        Precise_Azimuth = Precise_Azimuth + 8*Precise_Azimuth_Resolution;
        position = position + 8;
    end
    title('Parallel Rotated Precise Moving Golf Ball Intersection')
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    daspect([1 1 1])
    fprintf("\n");
end