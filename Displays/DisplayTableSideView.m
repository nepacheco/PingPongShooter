function a = DisplayTableSideView(length,height,options)
%DISPLAYTABLESIDEVIEW Displays Side View of Table Tennis
%   Detailed explanation goes here

arguments
    length (1,1) double = 1.0
    height (1,1) double = 0.1
    options.TableThickness (1,1) double = 0.1;
    options.NetThickness (1,1) double = 0.01;
    options.TableColor (1,3) double = [0,1,0];
    options.NetColor (1,3) double = [0,0,0];
end


% Table
options.TableThickness = 0.1; % [m]
start_x = -length/2;
start_z = -options.TableThickness;
rectangle('Position',[start_x,start_z,length,options.TableThickness],...
    'FaceColor',options.TableColor,'EdgeColor',[0,0,0]);

%Net
hold on
options.NetThickness = 0.01; % [m]
start_x = -options.NetThickness/2;
start_z = 0;
rectangle('Position',[start_x,start_z,options.NetThickness,height],...
    'FaceColor',options.NetColor,'EdgeColor',[0,0,0])
hold off
axis equal

a = gca;

end

