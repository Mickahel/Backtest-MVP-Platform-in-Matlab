classdef MovingAverage
    properties
        periods
        start
        amountOfDataFromToday
    end
    
    properties (SetAccess = private)
       %---- private variables
    end
    
    methods
        % constructor
        function obj = MovingAverage(periods)
            obj.periods = periods;
            obj.start=periods+1;
            obj.amountOfDataFromToday=periods;
        end
        
        function value = calculateMovingAverage(obj,data)
            value = sum(data)/obj.periods;
        end
    end
    
end