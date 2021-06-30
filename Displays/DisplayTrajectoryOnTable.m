function DisplayTrajectoryOnTable(traj,table_size)

arguments
    traj(3,:) double 
    table_size(1,3) = [2.74,1.525,0.1525];
end

% Side View
subplot(3,1,1);
DisplayTrajectory(traj);
hold on
DisplayTennisTable(table_size(1),table_size(2),table_size(3));
hold off
view(0,0);

% Top View
subplot(3,1,2);
DisplayTrajectory(traj);
hold on
DisplayTennisTable(table_size(1),table_size(2),table_size(3));
hold off
view(0,90);

% Iso View
subplot(3,1,3);
DisplayTrajectory(traj);
hold on
DisplayTennisTable(table_size(1),table_size(2),table_size(3));
hold off
view(30,10);

end