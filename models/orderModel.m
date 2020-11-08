classdef orderModel
    properties
        openPrice
        openDate
        closePrice
        closeDate
        type
        stopLoss
        takeProfit
        riskRewardRatio
        amount
        status
    end
    
    properties (SetAccess = private)
       %---- private variables
    end
    
    methods
        % constructor
        function obj = orderModel(openPrice, openDate, type, amountInPortfolio)
            obj.openPrice = openPrice;
            obj.openDate = openDate;
%             obj.closePrice
%             obj.closeDate
            obj.type = type;
            obj.takeProfit = openPrice + openPrice*0.05;
            obj.stopLoss = openPrice - openPrice*0.04;
            obj.riskRewardRatio = (obj.takeProfit-openPrice)/(openPrice-openPrice*0.04);
            obj.amount = amountInPortfolio*0.03;
            obj.status = "OPEN";
            
        end
        
        function obj = closeOrder(obj, closePrice, closeDate)
            
        end
    end
end