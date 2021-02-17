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

direction = [0 0 1];
for alpha=0:1:360
   rotate(plot3(x, y, z, 'LineWidth', 2.0, 'color', 'r'), direction, alpha);
   xlim([-5 5]);
   ylim([-5 5]);
   zlim([-5 5]);
   title('LiDAR Sensor Infra-Red Laser Projection');
   xlabel('Horizontal');
   ylabel('Horizontal');
   zlabel('Vertical');
   drawnow;
end