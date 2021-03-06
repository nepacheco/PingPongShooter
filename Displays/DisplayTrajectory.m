function p = DisplayTrajectory(traj,options)
arguments
    traj (3,:) double 
    options.LineWidth = 2;
    options.Color (1,3) double = [0 0 1];
    options.LineStyle = 'none'
    options.Marker = 'o';
    options.MarkerSize = 3;
end
p = plot3(traj(1,:),traj(2,:),traj(3,:),'LineWidth',options.LineWidth,...
    'Color',options.Color,'LineStyle',options.LineStyle,...
    'Marker',options.Marker,'MarkerSize',options.MarkerSize);
xlabel('X Axis (m)');
ylabel('Y Axis (m)');
zlabel('Z Axis (m)');
axis equal
grid on
end