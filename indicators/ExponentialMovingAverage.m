classdef ExponentialMovingAverage

    properties
        periods
        multiplier
        start
        amountOfDataFromToday
    end
    
    properties (SetAccess = private)
       %---- private variables
    end
    
    methods
        % constructor
        function obj = ExponentialMovingAverage(periods)
            obj.periods = periods;
            obj.multiplier = 2/(periods);
            obj.start = periods;
            obj.amountOfDataFromToday=periods;
        end
        
        function value = calculateExponentialMovingAverage(obj,data,lastValue)
                    value = (data - lastValue)*obj.multiplier + lastValue;
        end
    end
    
end