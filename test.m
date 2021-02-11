hold on

Radius_Start = 0.04191;
Radius_End = 0.04267 * sind((180-Azimuth_Resolution) / 2) / sind(Azimuth_Resolution);

LiDAR_x = 2;
LiDAR_y = -0.5;
LiDAR_z = 0.5;

% sphere_moving_x2 = 0.61801589329417;
% sphere_moving_y2 = 0.145984274370986;
% sphere_moving_z2 = -0.0111412592798038;
% 
% fprintf("Moving Golf Ball Intersection:\n");
% Azimuth = 103.1159808;
% Vertical_Angle = 13;
%     P_Start = [Radius_Start*sind(Azimuth) + LiDAR_x, ...
%             Radius_Start*cosd(Azimuth) + LiDAR_y, ...
%             LiDAR_z];
% 
%     P_End = [Radius_End*sind(Azimuth)*cosd(Vertical_Angle) + LiDAR_x, ...
%             Radius_End*cosd(Azimuth)*cosd(Vertical_Angle) + LiDAR_y, ...
%             Radius_End*sind(Vertical_Angle) + LiDAR_z];
% 
%     slope = P_End - P_Start;
% 
%     A = slope(1)^2 + slope(2)^2 + slope(3)^2;
%     B = 2*(slope(1)*(P_Start(1) + sphere_moving_x2) + slope(2)*(P_Start(2) + sphere_moving_y2) + slope(3)*(P_Start(3) + sphere_moving_z2));
%     C = (P_Start(1) + sphere_moving_x2)^2 + (P_Start(2) + sphere_moving_y2)^2 + (P_Start(3) + sphere_moving_z2)^2 - r^2;
% 
%     Delta = B^2 - 4*A*C;
% 
%     if (Delta < 0)
%     elseif (Delta == 0)
%         s = -B/2*A;
%         SPOI = [(P_Start(1) + s*(slope(1))),(P_Start(2) + s*(slope(2))),(P_Start(3) + s*(slope(3)))]
%         plot3([P_Start(1) SPOI(1)], [P_Start(2) SPOI(2)], [P_Start(3) SPOI(3)]);
%         plot3([P_Start(1) P_End(1)], [P_Start(2) P_End(2)], [P_Start(3) P_End(3)], 'Color', 'Black');
%     elseif (Delta > 0)
%         syms d;
%         s = solve((P_Start(1) + d*(slope(1)) + sphere_moving_x2)^2 + (P_Start(2) + d*(slope(2)) + sphere_moving_y2)^2+(P_Start(3) + d*(slope(3)) + sphere_moving_z2)^2 == r^2, d);
%         p1 = [(P_Start(1) + s(1)*slope(1)), (P_Start(2) + s(1)*slope(2)), (P_Start(3) + s(1)*slope(3))];
%         p2 = [(P_Start(1) + s(2)*slope(1)), (P_Start(2) + s(2)*slope(2)), (P_Start(3) + s(2)*slope(3))];
% 
%         if (norm(p1 - P_Start) < norm(p2 - P_Start))
%             SPOI = -p1;
%         else
%             SPOI = -p2;
%         end
% 
%         if (-SPOI(1) < P_Start(1)) & (-SPOI(1) > P_End(1)) ...
%                 | (-SPOI(2) < P_Start(2)) & (-SPOI(2) > P_End(2)) ...
%                 | (-SPOI(3) < P_Start(3)) & (-SPOI(3) > P_End(3))
%         elseif (SPOI(1) < -P_Start(1)) & (SPOI(1) > -P_End(1)) ...
%                 | (SPOI(2) < -P_Start(2)) & (SPOI(2) > -P_End(2)) ...
%                 | (SPOI(3) < -P_Start(3)) & (SPOI(3) > -P_End(3))
%         end            
% 
%         [x y z] = sphere;
%         x = x * r;
%         y = y * r;
%         z = z * r;
%         surf(x + sphere_moving_x2, y + sphere_moving_y2, z + sphere_moving_z2);
% 
%         plot3([P_Start(1) SPOI(1)], [P_Start(2) SPOI(2)], [P_Start(3) SPOI(3)]);
%         plot3([P_Start(1) P_End(1)], [P_Start(2) P_End(2)], [P_Start(3) P_End(3)], 'Color', 'Black');
%         fprintf("Point of Intersection = [%13.4f, %13.4f, %13.4f]  |  Azimuth = %10.4f  |  Vertical Angle = %3.0f\n", ...
%             SPOI(1), SPOI(2), SPOI(3), Azimuth, Vertical_Angle);
%     end
% 
% title('LiDAR')
% xlabel('X')
% ylabel('Y')
% zlabel('Z')
% daspect([1 1 1])
% fprintf("\n");

P_Start = [Radius_Start*sind(0) + LiDAR_x, ...
    Radius_Start*cosd(0) + LiDAR_y, ...
    LiDAR_z];

P_End = [Radius_End*sind(0)*cosd(0) + LiDAR_x, ...
    Radius_End*cosd(0)*cosd(0) + LiDAR_y, ...
    Radius_End*sind(0) + LiDAR_z];

plot3([P_Start(1) P_End(1)], [P_Start(2) P_End(2)], [P_Start(3) P_End(3)], 'Color', 'Black');

RPM = 1200;
Azimuth_Resolution = RPM / 60 * 360 * 55.296*10^-6;

Azimuth = 0;
for position = 1:10
    for Vertical_Angle = -15:2:15
        P_Start = [Radius_Start*sind(Azimuth) + LiDAR_x, ...
                Radius_Start*cosd(Azimuth) + LiDAR_y, ...
                LiDAR_z];

        P_End = [Radius_End*sind(Azimuth)*cosd(Vertical_Angle) + LiDAR_x, ...
                Radius_End*cosd(Azimuth)*cosd(Vertical_Angle) + LiDAR_y, ...
                Radius_End*sind(Vertical_Angle) + LiDAR_z];

        slope = P_End - P_Start;

        plot3([P_Start(1) P_End(1)], [P_Start(2) P_End(2)], [P_Start(3) P_End(3)]);
    end
    Azimuth = Azimuth + 5;
end