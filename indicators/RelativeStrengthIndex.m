classdef RelativeStrengthIndex
    properties
        periods
        upperBand
        lowerBand
    end
    
    properties (SetAccess = private)
       %---- private variables
    end
    
    methods
        % constructor
        function obj = RelativeStrengthIndex(periods, upperBand,lowerBand)
            obj.periods = periods;
            obj.upperBand = upperBand;
            obj.lowerBand = lowerBand;
        end
        
        function RSI = calculateRSI(obj,prices) 
            % prices length = obj.periods + 1.
            % prices goes from t to (t-obj.periods - 1)
            % prices_(t-obj.periods - 1) will be discarded
            % prices is a matrix N x 1, a column vector
            
            % calculate the returns of prices
            returns = [NaN;diff(prices)]./prices*100;
            returns = returns(2:end, :);
            upReturns = returns(returns>=0);
            downReturns = returns(returns<0);
            AvgU= mean(upReturns);
            AvgD = mean(abs(downReturns));
            RS = AvgU / AvgD;
            RSI = 100 - 100 / ( 1 + RS );
        end
    end
    
end