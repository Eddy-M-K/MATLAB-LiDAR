function Triangle_Intersection(P1, P2, P3, Azimuth_Resolution, Radius_Start, Radius_End)
    fprintf("Triangle Intersection:\n");
    normal1 = cross(P2 - P1, P3 - P1);
    fill3([P1(1) P2(1) P3(1)], ...
            [P1(2) P2(2) P3(2)], ...
            [P1(3) P2(3) P3(3)],'b');

    for Azimuth = 0:Azimuth_Resolution:359
       for Vertical_Angle = -15:2:15
            P_Start = [Radius_Start*sind(Azimuth) + LiDAR_x, ...
                    Radius_Start*cosd(Azimuth) + LiDAR_y, ...
                    LiDAR_z];

            P_End = [Radius_End*sind(Azimuth)*cosd(Vertical_Angle) + LiDAR_x, ...
                    Radius_End*cosd(Azimuth)*cosd(Vertical_Angle) + LiDAR_y, ...
                    Radius_End*sind(Vertical_Angle) + LiDAR_z];

            Point_of_Intersection1 = P_Start + dot(P1 - P_Start, normal1) / dot(P_End - P_Start, normal1) * (P_End - P_Start);

            if (-Point_of_Intersection1(1) < P_Start(1)) & (-Point_of_Intersection1(1) > P_End(1)) ...
                | (-Point_of_Intersection1(2) < P_Start(2)) & (-Point_of_Intersection1(2) > P_End(2)) ...
                | (-Point_of_Intersection1(3) < P_Start(3)) & (-Point_of_Intersection1(3) > P_End(3))
                continue
            end

            if ((dot(cross(P2 - P1, Point_of_Intersection1 - P1),normal1) >= 0 ...
                && dot(cross(P3-P2, Point_of_Intersection1 - P2), normal1) >= 0) ...
                && dot(cross(P1-P3, Point_of_Intersection1 - P3), normal1) >= 0)

                fprintf("Point of Intersection = [%13.4f, %13.4f, %13.4f]  |  Azimuth = %10.4f  |  Vertical Angle = %3.0f\n", ...
                    Point_of_Intersection1(1), Point_of_Intersection1(2), Point_of_Intersection1(3), Azimuth, Vertical_Angle);

                plot3([P_Start(1) Point_of_Intersection1(1)], [P_Start(2) Point_of_Intersection1(2)], [P_Start(3) Point_of_Intersection1(3)]);
            end
        end
    end
    title('Triangle Intersection')
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    daspect([1 1 1])
    fprintf("\n");
end