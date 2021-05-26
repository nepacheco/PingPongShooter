function DisplayTrajectoryOnTable(traj,table_size)

% Side View
subplot(2,1,1);
DisplayTrajectory(traj);
hold on
DisplayTennisTable(table_size(1),table_size(2),table_size(3));
hold off
view(0,0);

% Top View
subplot(2,1,2);
DisplayTrajectory(traj);
hold on
DisplayTennisTable(table_size(1),table_size(2),table_size(3));
hold off
view(0,90);

end