function Static_Golf_Ball_Intersection(sphere_shift_x, sphere_shift_y, sphere_shift_z, r, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z)
    fprintf("Golf Ball Intersection:\n");
    for Azimuth = 0:Azimuth_Resolution:359
        for Vertical_Angle = -15:2:15
            P_Start = [Radius_Start*sind(Azimuth) + LiDAR_x, ...
                    Radius_Start*cosd(Azimuth) + LiDAR_y, ...
                    LiDAR_z];

            P_End = [Radius_End*sind(Azimuth)*cosd(Vertical_Angle) + LiDAR_x, ...
                    Radius_End*cosd(Azimuth)*cosd(Vertical_Angle) + LiDAR_y, ...
                    Radius_End*sind(Vertical_Angle) + LiDAR_z];
            
            slope = P_End - P_Start;
            
            A = slope(1)^2 + slope(2)^2 + slope(3)^2;
            B = 2*(slope(1)*(P_Start(1) - sphere_shift_x) + slope(2)*(P_Start(2) - sphere_shift_y) + slope(3)*(P_Start(3) - sphere_shift_z));
            C = (P_Start(1) - sphere_shift_x)^2 + (P_Start(2) - sphere_shift_y)^2 + (P_Start(3) - sphere_shift_z)^2 - r^2;

            Delta = B^2 - 4*A*C;

            if (Delta == 0)
                s = -B/2*A;
                p_FL = [P_Start(1) + s*slope(1), P_Start(2) + s*slope(2), P_Start(3) + s*slope(3)];
                plot3([P_Start(1) p_FL(1)], [P_Start(2) p_FL(2)], [P_Start(3) p_FL(3)]);
                fprintf("Point of Intersection = [%13.4f, %13.4f, %13.4f]  |  Azimuth = %10.4f  |  Vertical Angle = %3.0f\n", ...
                    P_FL(1), P_FL(2), P_FL(3), Azimuth, Vertical_Angle);
            elseif (Delta > 0)
                syms d;
                s = solve((P_Start(1) + d*slope(1) - sphere_shift_x)^2+(P_Start(2) + d*slope(2) - sphere_shift_y)^2+(P_Start(3) + d*slope(3) - sphere_shift_z)^2 == r^2, d);
                P1 = [P_Start(1) + s(1)*slope(1), P_Start(2) + s(1)*slope(2), P_Start(3) + s(1)*slope(3)];
                P2 = [P_Start(1) + s(2)*slope(1), P_Start(2) + s(2)*slope(2), P_Start(3) + s(2)*slope(3)];
                disp(s)
                
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

                Plot_Print(P_Start, P_FL, Azimuth, Vertical_Angle, sphere_shift_x, sphere_shift_y, sphere_shift_z)
            end 
        end
    end 
    Sphere(sphere_shift_x, sphere_shift_y, sphere_shift_z, r)
    title('Static Golf Ball Intersection')
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    daspect([1 1 1])
    fprintf("\n");
end