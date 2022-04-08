%% Testing Spin Forward Kinematics
clc; clear; close all;

% Ping Pong table is 2.74 m by 1.525 m
% net height is 0.1525 m
ball_diam = 0.040; %[m];
length = 2.74; % [m]
width = 1.525; % [m]
height = 0.1525; % [m]
x0 = [-length/2;0;0.2];
theta = deg2rad(20);
v0 = 31*[cos(theta);0;sin(theta)];
w = [0;400;0]; % max angular speed is 950 rad/sec or 9000 rpm
% max speed might be 60 rps or 390 rad/sec

[traj,t,x] = CalculateForwardSpin(x0,v0,'spin',w);

DisplayTrajectoryOnTable(traj,[length,width,height])


%% Testing Spin Inverse Kinematics

% Ping Pong table is 2.74 m by 1.525 m
% net height is 0.1525 m
ball_diam = 0.040; %[m];
length = 2.74; % [m]
width = 1.525; % [m]
height = 0.1525; % [m]
x0 = [-length/2;0;0.2];
target = [length/2;-0.6;0];
theta = deg2rad(10);
v0 = 31*[cos(theta);0;sin(theta)];

[w, count, velocity] = CalculateInverseSpin(x0,target,v0);

[traj,t,x] = CalculateForwardSpin(x0,velocity,'spin',w);

DisplayTrajectoryOnTable(traj,[length,width,height])