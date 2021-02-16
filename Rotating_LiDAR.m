% You will need to uncomment the below command 'hold on' if you want to
% simultaenously see the triangle and the rotating LiDAR but this means
% that all the laser emissions will show up, instead of just rotating:

hold on
clear all

r = 5;
i = 0;
j = r;
k = j - i;

for vertical_angle=-15:2:15
    for radius=0.04191:r
        for index=(i+1):(j+1)
            x(index)=radius*cosd(vertical_angle)*sind(90);
            y(index)=radius*cosd(vertical_angle)*cosd(0);
            z(index)=radius*sind(vertical_angle);
        end
        i = i + k + 1;
        j = j + k + 1;
    end
end

% Triangle model (Only works with 'hold on'):
X_pos = [0; 1; 0];
Y_pos = [0; 0; 1];
Z_pos = [1; 0; 0];
fill3(X_pos,Y_pos,Z_pos,'b');

% Use either method 1 or 2, not both
% ----------------------------------------

% Method 1:
% vector = [x; y; z];
% for a=0:0.1:360 % This is a bit bugged and continues to spin after 360 degrees 
%     R = [cos(a) sin(a) 0; -sin(a) cos(a) 0; 0 0 1];
%     rotated_vector = R * vector;
%     plot3(rotated_vector(1,:), rotated_vector(2,:), rotated_vector(3,:), 'LineWidth', 2.0, 'color', 'r');
%     xlim([-5 5]);
%     ylim([-5 5]);
%     zlim([-5 5]);
%     title('LiDAR Sensor Infra-Red Laser Projection');
%     xlabel('Horizontal');
%     ylabel('Horizontal');
%     zlabel('Vertical');
%     drawnow;
% end

% ----------------------------------------
 
% Method 2 (less bugged):
% direction = [0 0 1];
% for alpha=0:1:360
%    rotate(plot3(x, y, z, 'LineWidth', 2.0, 'color', 'r'), direction, alpha);
%    xlim([-5 5]);
%    ylim([-5 5]);
%    zlim([-5 5]);
%    title('LiDAR Sensor Infra-Red Laser Projection');
%    xlabel('Horizontal');
%    ylabel('Horizontal');
%    zlabel('Vertical');
%    drawnow;
% end

% ----------------------------------------