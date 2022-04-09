function [spin, count, velocity] = CalculateInverseSpin(initial_pose, final_pose, velocity, ball_properties, options)
% CALCULATEINVERSEDRAG - Determines the initial velocity and angle of
% launch to hit the target point.
%
% The input is 3 poses [initial_pose, intermediate_pose, final_pose]. The
% intermediate pose must be linearly related in the x-y directions. 

arguments
    % Set 3 points that must be hit by parabola [start mid end]
    initial_pose (3,1) double
    final_pose (3,1) double
    velocity (3,1) double
    ball_properties (3,1) double = [0.455;0.040;0.0027] % [C_d; diameter; mass];
    options.min_spin (1,1) double = 0;
    options.max_spin (1,1) double = 10000;
    options.spin_gains (1,2) double = [100 100];
    options.vel_gains (1,3) double = [1 1 1];
end
mustBeLessThan(options.max_spin,options.min_spin);
% Gradient descent to converge on launch angle and launch speed
spin = options.min_spin*[0; sqrt(2)/2; sqrt(2)/2];
pos_error = [100;100];
count = 0;
vel_dir = velocity/norm(velocity);
while norm(pos_error) > 1E-4 && count < 1000
    
    [~,t,x] = CalculateForwardSpin(initial_pose,velocity,'spin',spin,'ball_properties',ball_properties);
    % Get Final Position error
    pos_error = final_pose - x(end,4:6)';
    if norm(spin) >= options.max_spin
        % If we are over the max spin, set spin magnitude to max but
        % preserve direction. Instead adjust velocity
        spin = max(options.max_spin*spin/norm(spin),0);
        velocity = velocity + diag(options.vel_gains)*...
            [pos_error(1)*vel_dir(1);pos_error(2);pos_error(1)*vel_dir(3)];
    elseif norm(spin) < options.min_spin
        % If we are below the min spin, then preserve spin direction but
        % increase the spin magnitude. Adjust velocity
        spin = min(options.min_spin*spin/norm(spin),0);
        velocity = velocity + diag(options.vel_gains)*...
            [pos_error(1)*vel_dir(1);pos_error(2);pos_error(1)*vel_dir(2)];
    else
        % If we are not over max or under min spin, then adjust the spin as normal
        spin = spin + diag([0 options.spin_gains])*[0;-pos_error(1);pos_error(2)] ;
    end
    count = count + 1;
end


end

%% Validators
function mustBeLessThan(b,a)
    if (b < a)
        eid = 'Value:ValueTooLarge';
        msg = ['Must be greater than ', num2str(a)];
        throwAsCaller(MException(eid,msg));
    end
end