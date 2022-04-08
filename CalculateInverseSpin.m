function [spin, count] = CalculateInverseSpin(initial_pose, final_pose, initial_velocity, ball_properties)
% CALCULATEINVERSEDRAG - Determines the initial velocity and angle of
% launch to hit the target point.
%
% The input is 3 poses [initial_pose, intermediate_pose, final_pose]. The
% intermediate pose must be linearly related in the x-y directions. 

arguments
    % Set 3 points that must be hit by parabola [start mid end]
    initial_pose (3,1) double
    final_pose (3,1) double
    initial_velocity (3,1) double
    ball_properties (3,1) double = [0.455;0.040;0.0027] % [C_d; diameter; mass]; 
end

% source:  https://link.springer.com/content/pdf/10.1111%2Fj.1747-1567.2006.00017.x.pdf
C_d = ball_properties(1); % Drag coefficient of ping-pong ball from
rho = 1.225; % [kg/m^3] Air density at sea level 
d = ball_properties(2); % [m] diamter of ping-pong ball 
m = ball_properties(3); % [kg] mass of ping pong ball
g = 9.81; % [m/s^2] gravity constant
A = pi*(d/2)^2; % [m^2] cross-sectional area
vol = (4/3)*pi*(d/2)^3;
v_t = sqrt(2*m*g/(C_d*rho*A)); % [m/s] terminal velocity of ping pong ball

% Gradient descent to converge on launch angle and launch speed
spin = zeros(3,1);
pos_error = [100;100];
count = 0;
while norm(pos_error) > 1E-4 && count < 1000
    
    [~,t,x] = CalculateForwardSpin(initial_pose,initial_velocity,'spin',spin,'ball_properties',ball_properties);
    % Get Final Position error
    pos_error = final_pose - x(end,4:6)';
    x_error = final_pose(1) - x(end,4); % Can be handled by top spin
    y_error = final_pose(2) - x(end,6); % can be handled by side spin
    spin = spin + diag([0 100 100])*[0;-pos_error(1);pos_error(2)] ;
    count = count + 1;
end


end