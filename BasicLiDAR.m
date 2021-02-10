% Edit only the start_angle, interval, end_angle, and second number of the
% radius

clear all
hold on

start_angle=0;  % angle to start the FOV from (0 to 360 and less than end_angle)
interval=10;    % interval to calculate data points between start_angle and end_angle
end_angle=360;   % angle to end the FOV (greater than start_angle)

% to view only the 16 vertical laser points, set 'FOV' to a singular number

for FOV=start_angle:interval:end_angle 
    for vertical_angle=-13:2:13
        for radius=1:5 % change second number to affect length of laser
            x(radius)=radius*cosd(vertical_angle)*sind(FOV);
            y(radius)=radius*cosd(vertical_angle)*cosd(FOV);
            z(radius)=radius*sind(vertical_angle);            
            plot3(x, y, z, 'LineWidth', 2.0);
        end
        clear x y z;
    end
end

title('LiDAR Sensor Infra-Red Laser Projection');
xlabel('Horizontal');
ylabel('Horizontal');
zlabel('Vertical');