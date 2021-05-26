function p = DisplayTrajectory(traj,options)
arguments
    traj (3,:) double 
    options.LineWidth = 2;
    options.Color (1,3) double = [0 0 1];
    options.LineStyle = '--'
end
p = plot3(traj(1,:),traj(2,:),traj(3,:),'LineWidth',options.LineWidth,...
    'Color',options.Color,'LineStyle',options.LineStyle);
xlabel('X Axis (m)');
ylabel('Y Axis (m)');
zlabel('Z Axis (m)');
axis equal
grid on
end