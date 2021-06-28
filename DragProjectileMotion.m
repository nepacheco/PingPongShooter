%% Falling Ping Pong Ball
% Ping Pong table is 2.74 m by 1.525 m
% net height is 0.1525 m
ball_diam = 0.040; %[m];
length = 2.74; % [m]
width = 1.525; % [m]
height = 0.1525; % [m]
g = 9.8;

p_o = [0;0;0]; % [m]
p_i = [0;0;height + ball_diam/2]; % [m]
p_f = [length;0.5;0]; % [m]

% source:  https://link.springer.com/content/pdf/10.1111%2Fj.1747-1567.2006.00017.x.pdf
C_d = 0.445; % Drag coefficient of ping-pong ball from
rho = 1.225; % [kg/m^3] Air density at sea level 
d = 0.040; % [m] diamter of ping-pong ball 
m = 0.0027; % [kg] mass of ping pong ball
g = 9.81; % [m/s^2] gravity constant
A = pi*(d/2)^2; % [m^2] cross-sectional area

v_t = sqrt(2*m*g/(C_d*rho*A)); % [m/s] terminal velocity of ping pong ball

c = m*g/v_t^2;
v = @(t,t_o,v_o,g) sqrt(m*g/c)*tanh(sqrt(m*g*c)/m.*(t-t_o) + atanh(v_o*c/sqrt(m*g*c)));

points = 100;
t = linspace(0,3,points);
t_o = zeros(1,points);
v_o = zeros(1,points);


theta = deg2rad(30);
V = 15;
plot(t,v(t,t_o,v_o,g))


%% Solving differential equations
close all
syms x1(t) x2(t)
C_d = 0.445; % Drag coefficient of ping-pong ball from
rho = 1.225; % [kg/m^3] Air density at sea level 
d = 0.040; % [m] diamter of ping-pong ball 
m = 0.0027; % [kg] mass of ping pong ball
g = 9.81; % [m/s^2] gravity constant
A = pi*(d/2)^2; % [m^2] cross-sectional area

v_t = sqrt(2*m*g/(C_d*rho*A)); % [m/s] terminal velocity of ping pong ball
theta = 5; % [deg]
speed = 11.176; % [m/s]
v0 = speed*[cosd(theta);sind(theta)];
tspan = linspace(0,20,10000);%[0,0.4];

f = @(t,x) [-g/v_t^2 * sqrt(x(1)^2 + x(2)^2) * x(1);
              -g/v_t^2 * (sqrt(x(1)^2 + x(2)^2) * x(2) + v_t^2)];
[t,x] = ode45(f,tspan,v0);

% NASA Equations that seem to be too simple
x_pos = v_t^2/g * log((v_t^2 + g*v0(1)*t)/v_t^2);
% % y_pos = v_t^2/g * log((v0(2)^2 + v_t^2)/(vy^2 + v_t^2));

traj = [x(:,1);zeros(1,10000),x(:,2)];

% Plotting
figure
plot(cumtrapz(t,x(:,1)),cumtrapz(t,x(:,2)),'b-','Linewidth',2);
hold on
plot(x_pos,cumtrapz(t,x(:,2)),'r--','Linewidth',2);
xlabel('X position (m)')
ylabel('Z position (m)')
title('Position of Ping Pong Ball with simulated drag')
% axis equal
ylim([0,inf]);
xlim([0,3]);
grid on
hold off

figure
plot(t,x(:,2));
xlabel('time (s)')
ylabel('Z velocity (m/s)')
title('Z velocity of Ping Pong Ball with simulated drag')
grid on

figure
plot(t,x(:,1));
xlabel('time (s)')
ylabel('X velocity (m/s)')
title('X Velocity of Ping Pong Ball with simulated drag')
grid on
