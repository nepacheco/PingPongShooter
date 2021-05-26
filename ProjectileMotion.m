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
length = 2.74; % [m]
width = 1.525; % [m]
height = 0.1525; % [m]

p_o = [-length/2;0;0]; % [m]
p_i = [0;0;height]; % [m]
p_f = [length/2;0; 0]; % [m]
g = -9.8; %[m/s^2]
syms a b c
eq1 = a*p_o(1)^2 + b*p_o(1) + c == p_o(2);
eq2 = a*p_i(1)^2 + b*p_i(1) + c == p_i(2);
eq3 = a*p_f(1)^2 + b*p_f(1) + c == p_f(2);
solution = solve([eq1 eq2 eq3]);

y = @(x)solution.a.*x.^2 + solution.b.*x + solution.c;
Vx = sqrt(g/(2*solution.a));%[m/s]
Vy_o = (2*solution.a*p_o(1) + solution.b)*Vx;%[m/s]

V = norm([Vx;Vy_o]); %[m/s]
theta = atan2(Vy_o,Vx); %[rad]
t = -Vy_o*2/g; %[s]
time_range = 0:0.001:t;

y_test = p_o(2) + Vy_o*t + 1/2*g*t^2;
x = -length/2:0.01:length/2;
traj = [x;zeros(size(x));y(x)];

DisplayTrajectoryOnTable(traj,[length,width,height])

figure
plot(time_range, p_o(2) + Vy_o.*time_range + 1/2.*g.*time_range.^2);
axis equal
grid on
