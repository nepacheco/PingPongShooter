function [V,theta,phi,t] = CalculateInverseProjectileMotion(poses)
% CALCULATEINVERSEPROJECTILEMOTION - Determines the initial velocity and
% angle in order to fire a projectile from starting point to ending point
% passing through one intermediate point using simple projectile
% kinematics.
arguments
    % Set 3 points that must be hit by parabola [start mid end]
    poses (3,3) double 
end


% Make the starting point of the motion (0,0)
poses = poses - poses(:,1);

% error checking on positions
if ~(abs(poses(1,2)*poses(2,3) - poses(1,3)*poses(2,2)) < eps)
    error("Nonlinear relationship between x and y values");
end

g = -9.8; %[m/s^2] % Gravitational constat
% Combine x and y direction to single direction with rotation 
% about the z-axis equal to phi
r = vecnorm(poses(1:2,:));
phi = atan2(poses(2,3),poses(1,3));
% z = a*r^2 + b*r + c
% with 3 points we can solve the above equation using linear algebra
r_mat = [(r.^2)' r' ones(3,1)]; 
z_vec = poses(3,:)';
coef = r_mat\z_vec;

% use the relationship between r and time to determine Vr and Vz
Vr = sqrt(g/(2*coef(1))); % [m/s]
Vz_o = (2*coef(1)*poses(1,1) + coef(2))*Vr; % [m/s]

% Find remaining parameters
V = norm([Vr;Vz_o]); % [m/s]
theta = atan2(Vz_o,Vr); % [rad]
t = -Vz_o*2/g; % [s]
end