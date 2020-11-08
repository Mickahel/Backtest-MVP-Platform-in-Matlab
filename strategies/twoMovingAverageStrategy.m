classdef twoMovingAverageStrategy
    %twoMovingAverageStrategy  strategy based on two moving average with
    %different periods
    
    properties
        name = "two Moving Average Strategy"
        MA1
        MA2
    end
    
    methods
        function obj = twoMovingAverageStrategy()
            %twoMovingAverageStrategy Construct an instance of this class
            %   Detailed explanation goes here
        end
        
        function startingPoint = startingPoint(obj)
            %startingPoint gets the starting point of the strategy
             startingPoint = max(obj.MA1.amountOfDataFromToday,obj.MA1.amountOfDataFromToday);
        end
        
        function obj = addIndicators(obj, inputParameters)
            inputParametersOfMA1= inputParameters(1);
            inputParametersOfMA2= inputParameters(2);
            obj.MA1 = MovingAverage(inputParametersOfMA1(1,1));
            obj.MA2 = MovingAverage(inputParametersOfMA2(1,1));
        end
    end
end

