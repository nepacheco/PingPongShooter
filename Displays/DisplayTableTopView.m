function a = DisplayTableTopView(length,width,options)
%DISPLAYTABLETOPVIEW Displays Top View of Table Tennis
%   Detailed explanation goes here

arguments
    length (1,1) double = 1.0
    width (1,1) double = 0.1
    options.NetThickness (1,1) double = 0.01;
    options.TableColor (1,3) double = [0,1,0];
    options.NetColor (1,3) double = [0,0,0];
end


% Table
start_x = -width/2;
start_y = -length/2;
rectangle('Position',[start_x,start_y,width,length],...
    'FaceColor',options.TableColor,'EdgeColor',[0,0,0]);

%Net
hold on
options.NetThickness = 0.01; % [m]
start_x = -width/2;
start_y = -options.NetThickness/2;
rectangle('Position',[start_x,start_y,width,options.NetThickness],...
    'FaceColor',options.NetColor,'EdgeColor',[0,0,0])
hold off
axis equal
a = gca;
end

