%% Basic Projectile Motion with a point mass
close all; clear; clc;
% vo - initial velocity in 2D
% po - initial position in 2D
% vf - final velocity in 2D
% pf - final position in 2D
% acceleration is only in y-direction

% y = y_o + vy_o*t + 1/2*g*t^2
% x = x_o + vx_o*t + 0
% vy_f = vy_o + g*t
% vy^2 = vy_o^2 + 2*g*DeltaY

% vx = cos(theta)*||v||
% vy = sin(theta)*||v||

% if we have p_o and p_f, can we solve for ||v|| and theta

% Ping Pong table is 2.74 m by 1.525 m
% net height is 0.1525 m
ball_diam = 0.040; %[m];
length = 2.74; % [m]
width = 1.525; % [m]
height = 0.1525; % [m]

p_o = [-length/2;0;0]; % [m]
p_i = [0;0;height + ball_diam/2]; % [m]
p_f = [length/2;0;0]; % [m]

[V,theta,phi,t] = CalculateInverseProjectileMotion([p_o p_i p_f]);

% Determine Trajectory based on time
traj = @(t) p_o + V.*[cos(phi)*cos(theta);sin(phi)*cos(theta); sin(theta)].*t...
    + 1/2.*t.^2.*[0;0;-9.8];
time_range = 0:0.001:t;

DisplayTrajectoryOnTable(traj(time_range),[length,width,height])

Vz_o = V*sin(theta);
g = -9.81;

figure
plot(time_range, p_o(2) + Vz_o.*time_range + 1/2.*g.*time_range.^2);
xlabel("Time")
ylabel("Y Position")
axis equal
grid on
