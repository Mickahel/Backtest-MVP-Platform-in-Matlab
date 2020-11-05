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

        
        function startingPoint = startingPoint(indicatorsInput)
            %startingPoint gets the starting point of the strategy
             startingPoint = indicatorsInput(1,2);
        end
    end
end

