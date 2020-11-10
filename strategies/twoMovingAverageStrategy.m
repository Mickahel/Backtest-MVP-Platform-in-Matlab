classdef twoMovingAverageStrategy
    %twoMovingAverageStrategy  strategy based on two moving average with
    %different periods
    
    properties
        name = "two Moving Average Strategy"
        MA1 %fast
        MA2 %slow
    end
    
    methods
        function obj = twoMovingAverageStrategy()
            %twoMovingAverageStrategy Construct an instance of this class
            %   Detailed explanation goes here
        end
        
        function startingPoint = startingPoint(obj)
            %startingPoint gets the starting point of the strategy
             startingPoint = max(obj.MA1.amountOfDataFromToday,obj.MA2.amountOfDataFromToday);
        end
        
        function orderType = checkForSignals(obj,data)
            dataAmount = size(data,1);
            %calculate fast MA
            MAFastValue = obj.MA1.calculateMovingAverage(data(dataAmount-obj.MA1.periods+1:end));
            %calculate slow MA
            MASlowValue = obj.MA2.calculateMovingAverage(data(dataAmount-obj.MA2.periods+1:end));
            
            %if fast > slow, buy
            if MAFastValue>= MASlowValue
                orderType="BUY";
            %if fast < slow, buy
            elseif MAFastValue< MASlowValue
                orderType="SELL";
            else
                orderType="IDLE";
            end
        end
        function obj = addIndicators(obj, inputParameters)
            inputParametersOfMA1= inputParameters(1);
            inputParametersOfMA2= inputParameters(2);
            obj.MA1 = MovingAverage(inputParametersOfMA1(1,1));
            obj.MA2 = MovingAverage(inputParametersOfMA2(1,1));
        end
        
        function amountOfDataFromToday = amountOfDataFromToday(obj)
            amountOfDataFromToday = max(obj.MA1.amountOfDataFromToday,obj.MA2.amountOfDataFromToday);
        end
    end
end

