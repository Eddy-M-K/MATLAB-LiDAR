clc
close all
clearvars
hold on
format long

% -------------------------------------------------------------------------

    % RPM must be in increments of 60 from 300 to 1200
    RPM = 1200; 

    % Golf ball radius
    r = 0.021335; 
    
    % LiDAR Sensor Location Shift
    LiDAR_x = 2;
    LiDAR_y = 1;
    LiDAR_z = 0.5;
    
    Azimuth_Resolution = RPM / 60 * 360 * 55.296*10^-6;
    Radius_Start = 0.04191;
    Radius_End = 0.04267 * sind((180-Azimuth_Resolution) / 2) / sind(Azimuth_Resolution);

% -------------------------------------------------------------------------

    % Change triangles' vertices; use values as arguments for additional
    % function calls to Triangle_Intersection
    P1 = [1 0 2];
    P2 = [0 1 0];
    P3 = [2 2 -3];

    % Function Calls
    % Triangle_Intersection(P1, P2, P3, Azimuth_Resolution, Radius_Start, Radius_End)

% -------------------------------------------------------------------------

    % Shift sphere's center:
    sphere_shift_x = 0.5;
    sphere_shift_y = -0.5;
    sphere_shift_z = 0.1;

    % Function Calls

%     Golf_Ball_Intersection(sphere_shift_x, sphere_shift_y, sphere_shift_z, r, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z)

% -------------------------------------------------------------------------

    FOV_Start = 270;
    FOV_End = 450;
    Lower_Angle = -15;
    Upper_Angle = 15;
    
    % Function Calls
%     Laser_Emission_Pattern(FOV_Start, FOV_End, Lower_Angle, Upper_Angle, 10, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z)

% -------------------------------------------------------------------------

    sphere_moving_position1 = readmatrix('LiDAR.xlsx');
    sphere_moving_x1 = sphere_moving_position1(:,1);
    sphere_moving_y1 = sphere_moving_position1(:,3);
    sphere_moving_z1 = sphere_moving_position1(:,2);   
    
    Golf_Ball_Trajectory(sphere_moving_x1, sphere_moving_y1, sphere_moving_z1, r)

    hold off
    figure 
    hold on
    
    sphere_moving_position1 = readmatrix('LiDAR.xlsx');
    sphere_moving_x1 = sphere_moving_position1(:,1);
    sphere_moving_y1 = sphere_moving_position1(:,3);
    sphere_moving_z1 = sphere_moving_position1(:,2);   
    
    Golf_Ball_Trajectory(sphere_moving_x1, sphere_moving_y1, sphere_moving_z1, r)
    Laser_Emission_Pattern(FOV_Start, FOV_End, Lower_Angle, Upper_Angle, 10, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z)
    
    sphere_moving_position2 = readmatrix('LiDAR_Precise.xlsx');
    sphere_moving_x2 = sphere_moving_position2(:,1);
    sphere_moving_y2 = sphere_moving_position2(:,3);
    sphere_moving_z2 = sphere_moving_position2(:,2);
    hold off
    figure
    hold on
    Moving_Golf_Ball_Intersection(sphere_moving_x2, sphere_moving_y2, sphere_moving_z2, r, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z)

% -------------------------------------------------------------------------

function Golf_Ball_Trajectory(sphere_moving_x, sphere_moving_y, sphere_moving_z, r)
    for position = 1:length(sphere_moving_x)
        [x y z] = sphere;
        x = x * r;
        y = y * r;
        z = z * r;
        surf(x + sphere_moving_x(position), y + sphere_moving_y(position), z + sphere_moving_z(position));
    end
    title('LiDAR')
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    daspect([1 1 1])
end

function Moving_Golf_Ball_Intersection(sphere_moving_x, sphere_moving_y, sphere_moving_z, r, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z)
    P_Start = [Radius_Start*sind(0) + LiDAR_x, ...
        Radius_Start*cosd(0) + LiDAR_y, ...
        LiDAR_z];

    P_End = [Radius_End*sind(0)*cosd(0) + LiDAR_x, ...
        Radius_End*cosd(0)*cosd(0) + LiDAR_y, ...
        Radius_End*sind(0) + LiDAR_z];
    
    plot3([P_Start(1) P_End(1)], [P_Start(2) P_End(2)], [P_Start(3) P_End(3)], 'Color', 'Black');
    
    clear P_Start P_End

    fprintf("Moving Golf Ball Intersection:\n");
    Azimuth = 0;
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

            if (Delta < 0)
                continue
            elseif (Delta == 0)
                s = -B/2*A;
                SPOI = [(P_Start(1) + s*(slope(1))),(P_Start(2) + s*(slope(2))),(P_Start(3) + s*(slope(3)))]
                plot3([P_Start(1) SPOI(1)], [P_Start(2) SPOI(2)], [P_Start(3) SPOI(3)]);
                plot3([P_Start(1) P_End(1)], [P_Start(2) P_End(2)], [P_Start(3) P_End(3)], 'Color', 'Black');
            elseif (Delta > 0)
                disp(Delta)
                syms d;
                s = solve((P_Start(1) + d*(slope(1)) - sphere_moving_x(position))^2 + (P_Start(2) + d*(slope(2)) - sphere_moving_y(position))^2+(P_Start(3) + d*(slope(3)) - sphere_moving_z(position))^2 == r^2, d);
                p1 = [(P_Start(1) + s(1)*slope(1)), (P_Start(2) + s(1)*slope(2)), (P_Start(3) + s(1)*slope(3))];
                p2 = [(P_Start(1) + s(2)*slope(1)), (P_Start(2) + s(2)*slope(2)), (P_Start(3) + s(2)*slope(3))];

                if (norm(p1 - P_Start) > norm(p2 - P_Start))
                    SPOI = -p1;
                else
                    SPOI = -p2;
                end
                
%                 if (-SPOI(1) < P_Start(1)) & (-SPOI(1) > P_End(1)) ...
%                         | (-SPOI(2) < P_Start(2)) & (-SPOI(2) > P_End(2)) ...
%                         | (-SPOI(3) < P_Start(3)) & (-SPOI(3) > P_End(3))
%                     continue
%                 end
%                 if (SPOI(1) < -P_Start(1)) & (SPOI(1) > -P_End(1)) ...
%                         | (SPOI(2) < -P_Start(2)) & (SPOI(2) > -P_End(2)) ...
%                         | (SPOI(3) < -P_Start(3)) & (SPOI(3) > -P_End(3))
%                     continue
%                 end        

                [x y z] = sphere;
                x = x * r;
                y = y * r;
                z = z * r;
                surf(x - sphere_moving_x(position), y - sphere_moving_y(position), z - sphere_moving_z(position));

                plot3([P_Start(1) SPOI(1)], [P_Start(2) SPOI(2)], [P_Start(3) SPOI(3)]);
                plot3([P_Start(1) P_End(1)], [P_Start(2) P_End(2)], [P_Start(3) P_End(3)], 'Color', 'Black');
                fprintf("Point of Intersection = [%13.4f, %13.4f, %13.4f]  |  Azimuth = %13.4f |  Vertical Angle = %3.0f\n", ...
                    SPOI(1), SPOI(2), SPOI(3), Azimuth, Vertical_Angle);
                fprintf("%f %f %f\n", sphere_moving_x(position), sphere_moving_y(position), sphere_moving_y(position));
                
                clear P_Start P_End slope A B C Delta
            end
        end
        Azimuth = Azimuth + Azimuth_Resolution;
    end
    title('LiDAR')
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    daspect([1 1 1])
    fprintf("\n");
end

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
    title('LiDAR')
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    daspect([1 1 1])
    fprintf("\n");
end

function Golf_Ball_Intersection(sphere_shift_x, sphere_shift_y, sphere_shift_z, r, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z)
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

            if (Delta < 0)
            elseif (Delta == 0)
                s = -B/2*A;
                SPOI = [(P_Start(1) + s*(slope(1))),(P_Start(2) + s*(slope(2))),(P_Start(3) + s*(slope(3)))]
                plot3([P_Start(1) SPOI(1)], [P_Start(2) SPOI(2)], [P_Start(3) SPOI(3)]);
            elseif (Delta > 0)
                syms d; 
                s = solve((P_Start(1) + d*(slope(1)) - sphere_shift_x)^2 + (P_Start(2) + d*(slope(2)) - sphere_shift_y)^2+(P_Start(3) + d*(slope(3)) - sphere_shift_z)^2 == r^2, d);
                p1 = [(P_Start(1) + s(1)*slope(1)), (P_Start(2) + s(1)*slope(2)), (P_Start(3) + s(1)*slope(3))];
                p2 = [(P_Start(1) + s(2)*slope(1)), (P_Start(2) + s(2)*slope(2)), (P_Start(3) + s(2)*slope(3))];
                if (norm(p1 - P_Start) < norm(p2 - P_Start))
                    SPOI = -p1;
                else
                    SPOI = -p2;
                end
%                 if ((sign(SPOI(1)) ~= sign(P_Start(1))) & (sign(SPOI(2)) ~= sign(P_Start(2))) & (sign(SPOI(3)) ~= sign(P_Start(3))))
%                     continue
%                 end            
                if (-SPOI(1) < P_Start(1)) & (-SPOI(1) > P_End(1)) ...
                        | (-SPOI(2) < P_Start(2)) & (-SPOI(2) > P_End(2)) ...
                        | (-SPOI(3) < P_Start(3)) & (-SPOI(3) > P_End(3))
                    continue
                end
                if (SPOI(1) < -P_Start(1)) & (SPOI(1) > -P_End(1)) ...
                        | (SPOI(2) < -P_Start(2)) & (SPOI(2) > -P_End(2)) ...
                        | (SPOI(3) < -P_Start(3)) & (SPOI(3) > -P_End(3))
                    continue
                end    
                plot3([P_Start(1) SPOI(1)], [P_Start(2) SPOI(2)], [P_Start(3) SPOI(3)]);
                plot3([P_Start(1) P_End(1)], [P_Start(2) P_End(2)], [P_Start(3) P_End(3)], 'Color', 'Black');
                fprintf("Point of Intersection = [%13.4f, %13.4f, %13.4f]  |  Azimuth = %10.4f  |  Vertical Angle = %3.0f\n", ...
                    SPOI(1), SPOI(2), SPOI(3), Azimuth, Vertical_Angle);
            end 
        end
    end
    [x y z] = sphere;
    x = x * r;
    y = y * r;
    z = z * r;
    surf(x - sphere_shift_x, y - sphere_shift_y, z - sphere_shift_z);
    
    title('LiDAR')
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    daspect([1 1 1])
    fprintf("\n");
end

function Laser_Emission_Pattern(FOV_Start, FOV_End, Lower_Angle, Upper_Angle, Azimuth_Resolution, Radius_Start, Radius_End, LiDAR_x, LiDAR_y, LiDAR_z)
    for Azimuth=FOV_Start:Azimuth_Resolution:FOV_End
        for Vertical_Angle=Lower_Angle:2:Upper_Angle
            P_Start = [Radius_Start*sind(Azimuth) + LiDAR_x, ...
                    Radius_Start*cosd(Azimuth) + LiDAR_y, ...
                    LiDAR_z];

            P_End = [Radius_End*sind(Azimuth)*cosd(Vertical_Angle) + LiDAR_x, ...
                    Radius_End*cosd(Azimuth)*cosd(Vertical_Angle) + LiDAR_y, ...
                    Radius_End*sind(Vertical_Angle) + LiDAR_z];

            plot3([P_Start(1) P_End(1)], [P_Start(2) P_End(2)], [P_Start(3) P_End(3)], 'LineWidth', 2.0);
        end
    end
    title('LiDAR')
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    daspect([1 1 1])
end