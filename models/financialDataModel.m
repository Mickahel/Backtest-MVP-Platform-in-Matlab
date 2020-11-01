classdef financialDataModel
    properties
        dates
        prices
        returns
        timeframe
        origin
        missingData
        
    end
    
    properties (SetAccess = private)
       %---- private variables
    end
    
    methods
        % constructor
        function obj = financialDataModel(dates, prices, returns, timeframe, origin, missingData)
            obj.dates = dates;
            obj.prices = prices;
            obj.returns = returns;
            obj.timeframe= timeframe;
            obj.origin = origin;
            obj.missingData = missingData;
        end

        function obj = lastDate(obj)
            % TODO    
        end
        
        function obj = firstDate(obj)
            % TODO 
        end
        
    end
end