classdef financialDataModel
    properties
        Dates
        Prices
        Returns
        Timeframe
        Origin
    end
    
    properties (SetAccess = private)
       %---- private variables
    end
    
    methods
        % constructor
        function obj = financialDataModel(dates, prices, returns, timeframe, origin)
            obj.Dates = dates;
            obj.Prices = prices;
            obj.Returns = returns;
            obj.Timeframe= timeframe;
            obj.Origin = origin;
        end

        function obj = lastDate(obj)
            % TODO    
        end
        
        function obj = firstDate(obj)
            % TODO 
        end
        
    end
end