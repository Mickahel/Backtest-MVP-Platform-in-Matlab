classdef analyticsModel
    properties
        profitLoss
        interest
        volatility
        amountOfOrders
        percentageMaxDrawDown
        amountOfBuyOrders
        profitLossBuyOrders
        amountOfSellOrders
        profitLossSellOrders
        sharpeRatio
%         percentageOfBuyOrders
%         percentageOfSellOrders
%         hasBeatenTheMarket

%         drawDownTimeseries
                
    end
    
    
    methods
        % constructor
        function obj = analyticsModel(portfolio)
            obj.profitLoss = portfolio.valueHistory(end,2)-portfolio.valueHistory(1,2);
            obj.interest = (portfolio.valueHistory(end,2)/portfolio.valueHistory(1,2)-1)*100;
            obj.volatility = std(portfolio.valueHistory(:,2));
            obj.amountOfOrders = size(portfolio.orders,1);
            if not(portfolio.valueHistory(1,2)-min(portfolio.valueHistory(:,2))==0) 
                obj.percentageMaxDrawDown = 100*(portfolio.valueHistory(1,2)-min(portfolio.valueHistory(:,2)))/portfolio.valueHistory(1,2);
            else
                obj.percentageMaxDrawDown=0;
            end
            obj.sharpeRatio = obj.interest/obj.volatility;
            
            obj.amountOfBuyOrders=0;
            obj.amountOfSellOrders=0;
            obj.profitLossBuyOrders = 0;
            obj.profitLossSellOrders = 0;
            for ordersIndex = 1:size(portfolio.orders,1)
                if portfolio.orders(ordersIndex).type == "BUY"
                    obj.amountOfBuyOrders=obj.amountOfBuyOrders+1;
                     obj.profitLossBuyOrders=obj.profitLossBuyOrders+portfolio.orders(ordersIndex).profitLoss;
                elseif portfolio.orders(ordersIndex).type == "SELL"
                    obj.amountOfSellOrders=obj.amountOfSellOrders+1;
                    obj.profitLossSellOrders=obj.profitLossSellOrders+portfolio.orders(ordersIndex).profitLoss;
                end
            end
        end
    end
end