function [value,isterminal,direction] = myEventsFcn(t,y,end_condition,elem_check)
arguments
    t
    y
    end_condition
    elem_check = 4;
end
value = y(elem_check)-end_condition;
isterminal = 1;    
direction = -1;
end