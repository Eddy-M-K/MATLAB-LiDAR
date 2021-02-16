function Plot_Print_H(P_Start, P_FL, Azimuth, Vertical_Angle, X, Y, Z)
    plot3([P_Start(1) P_FL(1)], [P_Start(2) P_FL(2)], [P_Start(3) P_FL(3)]);
    fprintf("Point of Intersection = [%10.4f, %10.4f, %10.4f]  |  Azimuth = %10.4f  |  Vertical Angle = %3.0f  |  Sphere Center = [%10.4f, %10.4f, %10.4f]\n", ...
        P_FL(1), P_FL(2), P_FL(3), Azimuth, Vertical_Angle, X, Y, Z); 
end