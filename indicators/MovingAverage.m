classdef MovingAverage
    properties
        periods
        start
    end
    
    properties (SetAccess = private)
       %---- private variables
    end
    
    methods
        % constructor
        function obj = MovingAverage(periods)
            obj.periods = periods;
            obj.start=periods;
        end
        
        function value = calculateMovingAverage(obj,data)
            value = sum(data)/obj.periods;
        end
    end
    
end