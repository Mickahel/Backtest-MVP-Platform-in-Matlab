classdef analyticsModel
    properties
        profitLoss
        interest
        volatility
        amountOfOrders
        percentageMaxDrawDown
%         amountOfBuyOrders
%         amountOfSellOrders
%         percentageOfBuyOrders
%         percentageOfSellOrders
%         hasBeatenTheMarket
        sharpeRatio
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
                obj.percentageMaxDrawDown = portfolio.valueHistory(1,2)/(portfolio.valueHistory(1,2)-min(portfolio.valueHistory(:,2)));
            else
                obj.percentageMaxDrawDown=0;
            end
            obj.sharpeRatio = obj.interest/obj.volatility;
        end
    end
end