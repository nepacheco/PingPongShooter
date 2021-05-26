function a = DisplayTennisTable(length,width,height)

points = 2;
% Table
x = linspace(-length/2,length/2,points);
y = linspace(-width/2,width/2,points);
% z = linspace(0,0,points);
[X,Y] = meshgrid(x,y);
surf(X,Y,zeros(2,2),'FaceColor',[0,1,0])

% Net
z = linspace(0,height,points);
[Y,Z] = meshgrid(y,z);
hold on
surf(zeros(2,2),Y,Z,'FaceColor',[0,0,0]);
hold off
axis equal
end