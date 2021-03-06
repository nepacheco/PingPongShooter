%% Falling Ping Pong Ball
% Ping Pong table is 2.74 m by 1.525 m
% net height is 0.1525 m
ball_diam = 0.040; %[m];
length = 2.74; % [m]
width = 1.525; % [m]
height = 0.1525; % [m]
g = 9.8;

po = [0;0;0]; % [m]
pi = [0;0;height + ball_diam/2]; % [m]
pf = [length;0.5;0]; % [m]

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

C_d = 0.445; % Drag coefficient of ping-pong ball from
rho = 1.225; % [kg/m^3] Air density at sea level 
d = 0.040; % [m] diamter of ping-pong ball 
m = 0.0027; % [kg] mass of ping pong ball
g = 9.81; % [m/s^2] gravity constant
A = pi*(d/2)^2; % [m^2] cross-sectional area

v_t = sqrt(2*m*g/(C_d*rho*A)); % [m/s] terminal velocity of ping pong ball
theta = deg2rad(45); % [rad]
speed = 30; % [m/s]

length = 2.74; % [m]
width = 1.525; % [m]
height = 0.1525; % [m]

[traj,t,x] = CalculateForwardDrag(speed,theta,[0;0;0],deg2rad(0),0,'ball_properties',[1/2,0.075,0.145]     );

DisplayTrajectoryOnTable(traj)

% Plotting
figure
plot(x(:,3),x(:,4),'b-','Linewidth',2);
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


%% Using functions to perform inverse drag kinematics and plotting the result

po = [-length/2;-0.25;0.4]; % [m]
pi = [0;0.0;height + ball_diam/2+0.1]; % [m]
pf = [length/2;0.25;0]; % [m]

poses = [po pi pf];

[V,theta,phi,t] = CalculateInverseDrag(poses);
[traj,t,x] = CalculateForwardDrag(V,theta,po,phi,0);

DisplayTrajectoryOnTable(traj)
for i = 1:3
    subplot(3,1,i);
    hold on
    plot3(poses(1,:),poses(2,:),poses(3,:),'r.','MarkerSize',30)
    hold off
end