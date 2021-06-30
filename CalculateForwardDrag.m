function [traj,t,x] = CalculateForwardDrag(V,theta,start_pose,phi,end_condition,options)
arguments
    V (1,1) double % [m/s]
    theta (1,1) double %[rad]
    start_pose (3,1) double = [0;0;0] % [m;m;m]
    phi (1,1) double = 0; %[rad]
    end_condition (1,1) double = 0 %[m] the height at which to stop integrating
    options.ball_properties (3,1) =  [0.455;0.040;0.0027] % [C_d; diameter; mass]; 
end

C_d = options.ball_properties(1); % Drag coefficient of ping-pong ball from
rho = 1.225; % [kg/m^3] Air density at sea level 
d = options.ball_properties(2); % [m] diamter of ping-pong ball 
m = options.ball_properties(3); % [kg] mass of ping pong ball
g = 9.81; % [m/s^2] gravity constant
A = pi*(d/2)^2; % [m^2] cross-sectional area
v_t = sqrt(2*m*g/(C_d*rho*A)); % [m/s] terminal velocity of ping pong ball


v0 = V*[cos(theta);sin(theta)];
x0 = [0;start_pose(3)];

tspan = linspace(0,2,10000);
% x_dot = f(x) -> x = [vx;vz;x;z]
f = @(t,x) [-g/v_t^2 * sqrt(x(1)^2 + x(2)^2) * x(1);
          -g/v_t^2 * (sqrt(x(1)^2 + x(2)^2) * x(2) + v_t^2);
          x(1);
          x(2)];

ode_opts = odeset('Events',@(t,x)myEventsFcn(t,x,end_condition));
[t,x] = ode45(f,tspan,[v0;x0],ode_opts);

traj = [x(:,3)*cos(phi) + start_pose(1), x(:,3)*sin(phi) + start_pose(2), x(:,4)]';
end