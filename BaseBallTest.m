clear;close all; clc
%% Based on https://dynref.engr.illinois.edu/afp.html

ball_diam = 0.075; %[m]
ball_mass = 0.145; %[kg]
length = 2.74; % [m]
width = 1.525; % [m]
height = 0.1525; % [m]

vo = 54;
Cd = 1/2;
theta = deg2rad(36);
xo = [0 0 1.25]';
w = [0;0;0]; % max angular speed is 950 rad/sec or 9000 rpm
% max speed might be 60 rps or 390 rad/sec
ball_prop = [Cd, ball_diam, ball_mass];
[traj,t,x] = CalculateForwardSpin(vo, theta, xo,'ball_properties', ball_prop, 'spin',w);

DisplayTrajectoryOnTable(traj,[length,width,height])

