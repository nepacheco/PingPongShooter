function [V,theta,phi,t,coef] = CalculateInverseProjectileMotion(p)
% CALCULATEINVERSEPROJECTILEMOTION - Determines the initial velocity and
% angle in order to fire a projectile from starting point to ending point
% passing through one intermediate point using simple projectile
% kinematics.
arguments
    % Set 3 points that must be hit by parabola [start mid end]
    p (3,3) double 
end

g = -9.8; %[m/s^2] % Gravitational constat
% Combine x and y direction to single direction with base rotation phi
r = vecnorm(p(1:2,:));
phi = atan2(p(1,1),p(2,1));
% y = a*x^2 + b*x + c
% with 3 points we can solve the above equation using linear algebra
x_mat = [(r.^2)' r' ones(3,1)]; 
y_vec = p(3,:)';
coef = x_mat\y_vec;

% use the relationship between x and time to determine Vx and Vy
Vx = sqrt(g/(2*coef(1))); % [m/s]
Vy_o = (2*coef(1)*p(1,1) + coef(2))*Vx; % [m/s]

% Find remaining parameters
V = norm([Vx;Vy_o]); % [m/s]
theta = atan2(Vy_o,Vx); % [rad]
t = -Vy_o*2/g; % [s]
end