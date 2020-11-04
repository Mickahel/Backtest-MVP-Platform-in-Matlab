classdef ExponentialMovingAverage

    properties
        periods
        multiplier
        
    end
    
    properties (SetAccess = private)
       %---- private variables
    end
    
    methods
        % constructor
        function obj = ExponentialMovingAverage(periods)
            obj.periods = periods;
            obj.multiplier = 2/(periods+1);
            obj.start = periods;
        end
        
        function value = calculateExponentialMovingAverage(obj,data,lastValue)
                    value = (data - lastValue)*obj.multiplier + lastValue;
        end
    end
    
end