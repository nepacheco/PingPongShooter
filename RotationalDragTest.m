%% Drag from paper
lambda = 1.48E-5;
V = [0;0;1];
V = [1;0;0];
d = 0.040; Re = norm(V)*d/lambda;
Cd0 = 24/Re*(1 + 0.15*Re^(1/2) + 0.017*Re) - 0.208/(1 + 10^4*(Re)^-0.5);
% This result is similar to the 0.45 hardcoded value 