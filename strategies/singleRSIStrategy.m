classdef singleRSIStrategy
    %singleRSIStrategy  strategy based on RSI
    
    properties
        name = "single RSI Strategy"
        RSI
    end
    
    methods
        function obj = singleRSIStrategy()

        end

        function obj = addIndicators(obj, inputParameters)
            obj.RSI = RelativeStrengthIndex(...
                inputParameters(1),...
                inputParameters(2),...
                inputParameters(3)...
                );
        end

        function orderType = checkForSignals(obj,data)
            %get value of the RSI
%           disp("---------------------------------------")
            rsiValue = obj.RSI.calculateRSI(data);
            %if < lowerband buy
            if rsiValue < obj.RSI.lowerBand
                orderType = orderTypeEnumeration.BUY;
            %if > upperband, sell
            elseif rsiValue > obj.RSI.upperBand
                orderType = orderTypeEnumeration.SELL;
            else    
                orderType = orderTypeEnumeration.IDLE;
            end
        end
        
        function startingPoint = startingPoint(obj)
            %startingPoint gets the starting point of the strategy
             startingPoint = obj.RSI.amountOfDataFromToday;
        end
        
        function amountOfDataFromToday = amountOfDataFromToday(obj)
            amountOfDataFromToday = obj.RSI.amountOfDataFromToday;
        end
    end
end

