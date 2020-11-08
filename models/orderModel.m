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
        profitLoss
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
            obj.closePrice = closePrice;
            obj.status = "CLOSED";
            obj.closeDate = closeDate;
            
            if obj.type == "BUY"
                obj.profitLoss= obj.amount * (closePrice/obj.openPrice);
            elseif obj.type == "SELL"
                obj.profitLoss= obj.amount * (obj.openPrice/closePrice);
            end
        end
    end
end