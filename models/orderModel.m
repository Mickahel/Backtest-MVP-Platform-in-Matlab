classdef orderModel
    properties
        id
        openPrice
        openDate
        closePrice
        closeDate
        type
        stopLoss
        takeProfit
        riskRewardRatio
    end
    
    properties (SetAccess = private)
       %---- private variables
    end
    
    methods
        % constructor
        function obj = orderModel()
            
        end
        
        function obj = closeOrder(obj, closePrice, closeDate)
            
        end
    end
end