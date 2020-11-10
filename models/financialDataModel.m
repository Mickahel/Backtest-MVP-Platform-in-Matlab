classdef financialDataModel
    properties
        dates
        prices
        returns
        missingData
        
    end
    
    properties (SetAccess = private)
       %---- private variables
    end
    
    methods
        % constructor
        function obj = financialDataModel(dates, prices, returns, missingData)
            obj.dates = dates;
            obj.prices = prices;
            obj.returns = returns;
            obj.missingData = missingData;
        end
        
        % get last date
        function lastDate = lastDate(obj)
            lastDate = obj.dates(end);
        end
        
        % get first date
        function firstDate = firstDate(obj)
            firstDate = obj.dates(1);
        end
        
        % get mean of the prices
        function meanPrice = meanPrice(obj)
            meanPrice = mean(obj.prices);
        end
        
        % get Standard Deviation of the prices
        function sdPrice = sdPrice(obj)
            sdPrice = std(obj.prices,1);
        end
        
    end
      methods (Static)
%         function out = staticMethod()
%             out="test";
%         end
      end
end