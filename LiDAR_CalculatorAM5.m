clear all
hold on

% Only edit the following:
% ------------------------
RPM = 1200; % Must be in increments of 60 from 300 to 1200

Triangle_P1 = [1 0 2];
Triangle_P2 = [0 1 0];
Triangle_P3 = [2 2 -3];

Triangle_P4 = [0 0 -1];
Triangle_P5 = [0 -1 0];
Triangle_P6 = [-1 0 0];

r = 0.021335;

% ------------------------

xC = 0.50;
yC = -0.50;
zC = 0.1;

[x y z] = sphere;
x = x * r;
y = y * r;
z = z * r;
surf(x + xC, y + yC, z + zC);

origin = [0, 0, 0];

Azimuth_Resolution = RPM / 60 * 360 * 55.296*10^-6;
Radius_Start = 0.04191;
%Radius_End = 0.04267 * sind((180-Azimuth_Resolution) / 2) / sind(Azimuth_Resolution);
Radius_End = 3;
for Azimuth = 0:Azimuth_Resolution:359
   for Vertical_Angle = -15:2:15
        P_Start = [Radius_Start*sind(Azimuth), ...
            Radius_Start*cosd(Azimuth), ...
            0];
                
        P_End = [Radius_End*cosd(Vertical_Angle)*sind(Azimuth), ...
                Radius_End*cosd(Vertical_Angle)*cosd(Azimuth), ...
                Radius_End*sind(Vertical_Angle)];
       
        xA = P_Start(:,1);
        yA = P_Start(:,2);
        zA = P_Start(:,3);
        xB = P_End(:,1);
        zB = P_End(:,3);
        yB = P_End(:,2);
%         xC = 0.50;
%         yC = -0.50;
%         zC = 0.1;
        
        A = (xB-xA)^2+(yB-yA)^2+(zB-zA)^2;
        B = 2*((xB-xA)*(xA-xC)+(yB-yA)*(yA-yC)+(zB-zA)*(zA-zC));
        C = (xA-xC)^2+(yA-yC)^2+(zA-zC)^2-r^2;

        Delta = B^2 - 4*A*C;
        
        if (Delta == 0)
            s = -B/2*A;
            p_F = [(xA + s*(xB-xA)),(yA + s*(yB-yA)),(zA + s*(zB-zA))]
            plot3([P_Start(:,1) p_F(:,1)], [P_Start(:,2) p_F(:,2)], [P_Start(:,3) p_F(:,3)]);
        end
        if (Delta > 0)
            %fprintf('%f', Delta)
            syms d;
            s = solve((xA + d*(xB-xA) - xC)^2+(yA + d*(yB-yA) - yC)^2+(zA + d*(zB-zA) - zC)^2==r^2, d);
            s1 = s(1,:);
            s2 = s(2,:);
            p1 = [(xA + s1*(xB-xA)),(yA + s1*(yB-yA)),(zA + s1*(zB-zA))];
            p2 = [(xA + s2*(xB-xA)),(yA + s2*(yB-yA)),(zA + s2*(zB-zA))];
            if (norm(p1-P_Start) < norm(p2-P_Start))
                p_FL = p1;
            else
                p_FL = p2;
            end
            if (-p_FL(1) < P_Start(1)) & (-p_FL(1) > P_End(1)) ...
                    | (-p_FL(2) < P_Start(2)) & (-p_FL(2) > P_End(2)) ...
                    | (-p_FL(3) < P_Start(3)) & (-p_FL(3) > P_End(3))
                continue
            elseif (p_FL(1) < -P_Start(1)) & (p_FL(1) > -P_End(1)) ...
                    | (p_FL(2) < -P_Start(2)) & (p_FL(2) > -P_End(2)) ...
                    | (p_FL(3) < -P_Start(3)) & (p_FL(3) > -P_End(3))
                continue
            end   
            
            %if (norm(origin-P_Start) + norm(p_FL-origin) == norm(p_FL-P_Start))
                plot3([P_Start(:,1) p_FL(:,1)], [P_Start(:,2) p_FL(:,2)], [P_Start(:,3) p_FL(:,3)]);
                fprintf("[%f, %f, %f], Azimuth = %f, Vertical Angle = %f\n", ...
                p_FL(:,1), p_FL(:,2), p_FL(:,3), Azimuth, Vertical_Angle);
                %plot3([P_Start(1) P_End(1)], [P_Start(2) P_End(2)], [P_Start(3) P_End(3)], 'Color', 'Black');
            %end
        end
   end
end



% Triangle 1
% ------------------------------------ 
% 
% normal1 = cross(Triangle_P2 - Triangle_P1, Triangle_P3 - Triangle_P1);
% fill3([Triangle_P1(1,1) Triangle_P2(1,1) Triangle_P3(1,1)], ...
%         [Triangle_P1(1,2) Triangle_P2(1,2) Triangle_P3(1,2)], ...
%         [Triangle_P1(1,3) Triangle_P2(1,3) Triangle_P3(1,3)],'b');
% for Azimuth = 0:Azimuth_Resolution:359
%    for Vertical_Angle = -15:2:15
%         P_Start = [Radius_Start*cosd(Vertical_Angle)*sind(Azimuth), ...
%                     Radius_Start*cosd(Vertical_Angle)*cosd(Azimuth), ...
%                     Radius_Start*sind(Vertical_Angle)];
%                 
%         P_End = [Radius_End*cosd(Vertical_Angle)*sind(Azimuth), ...
%                 Radius_End*cosd(Vertical_Angle)*cosd(Azimuth), ...
%                 Radius_End*sind(Vertical_Angle)];
%             
%         Point_of_Intersection1 = P_Start + dot(Triangle_P1 - P_Start, normal1) / dot(P_End - P_Start, normal1) * (P_End - P_Start);
%         
%         if (-Point_of_Intersection1(:,1) < P_Start(:,1)) & (-Point_of_Intersection1(:,1) > P_End(:,1)) ...
%                 | (-Point_of_Intersection1(:,2) < P_Start(:,2)) & (-Point_of_Intersection1(:,2) > P_End(:,2)) ...
%                 | (-Point_of_Intersection1(:,3) < P_Start(:,3)) & (-Point_of_Intersection1(:,3) > P_End(:,3))
%             continue
%         end
%         
%         if ((dot(cross(Triangle_P2 - Triangle_P1, Point_of_Intersection1 - Triangle_P1),normal1) >= 0 ...
%                 && dot(cross(Triangle_P3-Triangle_P2, Point_of_Intersection1 - Triangle_P2), normal1) >= 0) ...
%                 && dot(cross(Triangle_P1-Triangle_P3, Point_of_Intersection1 - Triangle_P3), normal1) >= 0)
%             
%             fprintf("[%f, %f, %f], Azimuth = %f, Vertical Angle = %f\n", ...
%                 Point_of_Intersection1(:,1), Point_of_Intersection1(:,2), Point_of_Intersection1(:,3), Azimuth, Vertical_Angle);
%             
%             plot3([P_Start(:,1) Point_of_Intersection1(:,1)], [P_Start(:,2) Point_of_Intersection1(:,2)], [P_Start(:,3) Point_of_Intersection1(:,3)]);
%             
%             Below command extends the lasers beyond the Point of Intersection
%             plot3([P_Start(:,1) P_End(:,1)], [P_Start(:,2) P_End(:,2)], [P_Start(:,3) P_End(:,3)]);
%         end
%    end
% end
% 
% Triangle 2
% -----------------------------------------
% 
% fprintf("\nSecond Triangle Intersection:\n");
% normal2 = cross(Triangle_P5 - Triangle_P4, Triangle_P6 - Triangle_P4);
% fill3([Triangle_P4(1,1) Triangle_P5(1,1) Triangle_P6(1,1)],[Triangle_P4(1,2) Triangle_P5(1,2) Triangle_P6(1,2)],[Triangle_P4(1,3) Triangle_P5(1,3) Triangle_P6(1,3)],'r');
% 
% for Azimuth = 0:Azimuth_Resolution:359
%    for Vertical_Angle = -15:2:15
%         P_Start = [Radius_Start*cosd(Vertical_Angle)*sind(Azimuth), ...
%                     Radius_Start*cosd(Vertical_Angle)*cosd(Azimuth), ...
%                     Radius_Start*sind(Vertical_Angle)];
%                 
%         P_End = [Radius_End*cosd(Vertical_Angle)*sind(Azimuth), ...
%                 Radius_End*cosd(Vertical_Angle)*cosd(Azimuth), ...
%                 Radius_End*sind(Vertical_Angle)];
%         
%         Point_of_Intersection2 = P_Start + dot(Triangle_P4 - P_Start, normal2) / dot(P_End - P_Start, normal2) * (P_End - P_Start);
%         
%         if (-Point_of_Intersection2(:,1) < P_Start(:,1)) & (-Point_of_Intersection2(:,1) > P_End(:,1)) ...
%                 | (-Point_of_Intersection2(:,2) < P_Start(:,2)) & (-Point_of_Intersection2(:,2) > P_End(:,2)) ...
%                 | (-Point_of_Intersection2(:,3) < P_Start(:,3)) & (-Point_of_Intersection2(:,3) > P_End(:,3))
%             continue
%         end
%         
%         if ((dot(cross(Triangle_P5-Triangle_P4, Point_of_Intersection2 - Triangle_P4),normal2) >= 0 ...
%                 && dot(cross(Triangle_P6-Triangle_P5, Point_of_Intersection2 - Triangle_P5), normal2) >= 0) ...
%                 && dot(cross(Triangle_P4-Triangle_P6, Point_of_Intersection2 - Triangle_P6), normal2) >=0)
%             
%             fprintf("[%f, %f, %f], Azimuth = %f, Vertical Angle = %f\n", ...
%                 Point_of_Intersection2(:,1), Point_of_Intersection2(:,2), Point_of_Intersection2(:,3), Azimuth, Vertical_Angle);
%             
%             plot3([P_Start(:,1) Point_of_Intersection2(:,1)], [P_Start(:,2) Point_of_Intersection2(:,2)], [P_Start(:,3) Point_of_Intersection2(:,3)]);
%             
%             Below command extends the lasers beyond the Point of Intersection
%             plot3([P_Start(:,1) P_End(:,1)], [P_Start(:,2) P_End(:,2)], [P_Start(:,3) P_End(:,3)]);
%         end
%    end
% end

% Sphere
% ----------------------

% [x y z] = sphere;
% x = x * r;
% y = y * r;
% z = z * r;
% surf(x - Radius_End, y, z);

% clear x y z
% 
% % Laser Emission Pattern
% % ----------------------
% 
% increment = 0.04191:0.01:Radius_End;
% i = 0;
% j = size(increment, 1);
% k = j - i;
% 
% for FOV=269:Azimuth_Resolution:271
%     for vertical_angle=-3:2:3
%         for radius = 0.04191:0.01:Radius_End
%             for index=(i+1):(j+1)
%                 x(index)=radius*cosd(vertical_angle)*sind(FOV);
%                 y(index)=radius*cosd(vertical_angle)*cosd(FOV);
%                 z(index)=radius*sind(vertical_angle);
%             end
%             i = i + k + 1;
%             j = j + k + 1;
%         end
%         plot3(x, y, z, 'LineWidth', 2.0);
%         clear x y z
%     end
% end 

% Graph related configuration:
% ----------------------------
xlim([-5 5]);
ylim([-5 5]);
zlim([-0.3 0.3]);
title('LiDAR Sensor and Triangle Intersection');
xlabel('x');
ylabel('y');
zlabel('z');