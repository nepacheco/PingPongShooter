function [speed,theta,phi,t] = CalculateInverseDrag(poses,ball_properties)
% CALCULATEINVERSEDRAG - Determines the initial velocity and angle of
% launch to hit the target point.
%
% The input is 3 poses [initial_pose, intermediate_pose, final_pose]. The
% intermediate pose must be linearly related in the x-y directions. 

arguments
    % Set 3 points that must be hit by parabola [start mid end]
    poses (3,3) double
    ball_properties (3,1) double = [0.455;0.040;0.0027] % [C_d; diameter; mass]; 
end

% Make the starting point of the motion (0,0)
poses = poses - poses(:,1);

% error checking on positions
if ~(abs(poses(1,2)*poses(2,3) - poses(1,3)*poses(2,2)) < eps)
    error("Nonlinear relationship between x and y values");
end

% Combine x and y direction to single direction with rotation 
% about the z-axis equal to phi
r = vecnorm(poses(1:2,:));
phi = atan2(poses(2,3),poses(1,3));

% source:  https://link.springer.com/content/pdf/10.1111%2Fj.1747-1567.2006.00017.x.pdf
C_d = ball_properties(1); % Drag coefficient of ping-pong ball from
rho = 1.225; % [kg/m^3] Air density at sea level 
d = ball_properties(2); % [m] diamter of ping-pong ball 
m = ball_properties(3); % [kg] mass of ping pong ball
g = 9.81; % [m/s^2] gravity constant
A = pi*(d/2)^2; % [m^2] cross-sectional area
v_t = sqrt(2*m*g/(C_d*rho*A)); % [m/s] terminal velocity of ping pong ball

% Gradient descent to converge on launch angle and launch speed
theta = 0.1; % [rad]
speed = 11.176; % [m/s]
pos_error = [100;100];
count = 0;
while norm(pos_error) > 1E-4 && count < 100
    
    [~,t,x] = CalculateForwardDrag(speed,theta,[0;0;0],deg2rad(0),poses(3,3));
    % Get Final Position error
    dist_error = r(3) - x(end,3);
%     dist_error_z = poses(3,3) - x(end,4);
%     dist_error = norm([dist_error_x,dist_error_z]);
    % Get midway height error 
    midway_point = r(1,2);
    midway_height = poses(3,2);
    model_height = interp1(x(:,3),x(:,4),midway_point);
    height_error = midway_height - model_height;
    
    pos_error = [dist_error;height_error];
    
    speed = speed + 0.5*dist_error; 
    theta = theta + 0.2*height_error;
    count = count + 1;
end


end