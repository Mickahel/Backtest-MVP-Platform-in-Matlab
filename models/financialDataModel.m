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
        
        % get last date
        function lastDate = lastDate(self)
            lastDate = self.dates(end);
        end
        
        % get first date
        function firstDate = firstDate(self)
            firstDate = self.dates(1);
        end
        
        % get mean of the prices
        function meanPrice = meanPrice(self)
            meanPrice = mean(self.prices);
        end
        
        % get Standard Deviation of the prices
        function sdPrice = sdPrice(self)
            sdPrice = std(self.prices,1);
        end
        
    end
      methods (Static)
%         function out = staticMethod()
%             out="test";
%         end
      end
end