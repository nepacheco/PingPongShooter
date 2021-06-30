function [value,isterminal,direction] = myEventsFcn(t,y,end_condition)
value = y(4)-end_condition;
isterminal = 1;    
direction = -1;
end