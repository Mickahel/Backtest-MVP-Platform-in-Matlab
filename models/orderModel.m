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
            if type =="BUY"
                obj.takeProfit = openPrice + openPrice*0.006;
                obj.stopLoss = openPrice - openPrice*0.003;
            elseif type=="SELL"
                obj.takeProfit = openPrice - openPrice*0.006;
                obj.stopLoss = openPrice + openPrice*0.0003;
            end
            obj.riskRewardRatio = (0.01)/(0.005);
            obj.amount = amountInPortfolio*0.03;
            obj.status = "OPEN";
            
        end
        
        function obj = closeOrder(obj, closePrice, closeDate)
            obj.closePrice = closePrice;
            obj.status = "CLOSED";
            obj.closeDate = closeDate;
            
            if obj.type == "BUY"
                obj.profitLoss= obj.amount * ((closePrice-obj.openPrice)/obj.openPrice);
            elseif obj.type == "SELL"
                obj.profitLoss= obj.amount * ((obj.openPrice-closePrice)/obj.openPrice);
            end
        end
    end
end