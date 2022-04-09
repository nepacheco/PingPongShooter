function [traj,t,x] = CalculateForwardSpin(start_pose,velocity,options)
arguments
    start_pose (3,1) double % x y z [m;m;m]
    velocity (3,1) double % speed of launch [m/s]
    options.end_condition (1,1) double = 0 %[m] the height at which to stop integrating
    options.ball_properties (3,1) =  [0.455;0.040;0.0027] % [C_d; diameter; mass]; 
    options.spin (3,1) = zeros(3,1); % vector of direction that indicates vector about which ball is spinning
    options.alpha (1,1) double = 0; % decay parameter for rotational spin
end

C_d = options.ball_properties(1); % Drag coefficient of ping-pong ball from
alpha = 0;
rho = 1.225; % [kg/m^3] Air density at sea level 
d = options.ball_properties(2); % [m] diamter of ping-pong ball 
m = options.ball_properties(3); % [kg] mass of ping pong ball
g = 9.81; % [m/s^2] gravity constant
A = pi*(d/2)^2; % [m^2] cross-sectional area
vol = 4/3*pi*(d/2)^3;
v_t = sqrt(2*m*g/(C_d*rho*A)); % [m/s] terminal velocity of ping pong ball


v0 = velocity;
x0 = start_pose;

tspan = linspace(0,10,10000);
w0 = options.spin;
% This function has the drag and gravity terms added to the magnus effect
% x_dot = f(x) -> x = [vx;vy;vz;x;y;z;wx;wy;wz]
% f = @(t,x) [-g/v_t^2 * norm(x(1:3)) * x(1);
%             -g/v_t^2 * norm(x(1:3)) * x(2);
%           -g/v_t^2 * (norm(x(1:3)) * x(3) + v_t^2);
%           x(1);
%           x(2);
%           x(3);
%           0;
%           0;
%           0] + [cross(w0,x(1:3))*8/3*pi*(d/2)^3*rho/m;zeros(3,1);w];
      
f = @(t,x) [-[0 0 g]' - x(1:3)*norm(x(1:3))*g/v_t^2 + cross(x(7:9),x(1:3))*2*vol*rho/m;
            [x(1) x(2) x(3)]';
            -alpha*x(7:9)*norm(x(7:9)*alpha)];

% Need to add magnus effect
% Force per unit length; need to integrate for sphere
% F/L = rho*v*G , rho is fluid density, v is speed of ball
% G = 2*pi*r^2*w , r is radius of cylinder, w is angular velocity of spin
% [rad/sec]

ode_opts = odeset('Events',@(t,x)myEventsFcn(t,x,options.end_condition,6));
[t,x] = ode45(f,tspan,[v0;x0;w0],ode_opts);

traj = [x(:,4), x(:,5), x(:,6)]';
end