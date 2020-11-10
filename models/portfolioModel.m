classdef portfolioModel
    properties
        value
        valueHistory % matrix with columns : date, amount, return
        orders
    end
    
    properties (SetAccess = private)
       %---- private variables
    end
    
    methods
        % constructor
        function obj = portfolioModel(value,firstDate)
            obj.value = value;
            obj.valueHistory = [firstDate,value, NaN];
            obj.orders = [];
        end
        
        function obj = closeAllOrders(obj, price,date)
            for ordersIndex = 1: size(obj.orders,1)
                if obj.orders(ordersIndex).type =="OPEN"
                    obj = obj.closeOrder(obj,ordersIndex, price,date);
                end
            end    
        end
        
        function obj = addOrder(obj, order)
            obj.value = obj.value - order.amount;  
            obj.orders = [obj.orders;order];
        end
        
        function obj = closeOrder(obj, orderIndex,price, date)
            orderToClose = obj.orders(orderIndex)
            obj.orders(orderIndex) = orderToClose.closeOrder(price, date)
            netProfitLoss = obj.orders(orderIndex).profitLoss
            porfolioValueBeforeOrderClose =obj.valueHistory(end,2)
            portfolioValue =porfolioValueBeforeOrderClose+netProfitLoss
            obj.valueHistory = [obj.valueHistory; date, portfolioValue, portfolioValue/porfolioValueBeforeOrderClose-1]
            obj.value = portfolioValue;
        end
        
        function obj = checkForOrdersToClose(obj, price, date)
             for ordersIndex = 1: size(obj.orders,1)
                %check for orders open
                if obj.orders(ordersIndex).status =="OPEN"
                    if obj.orders(ordersIndex).type == "SELL"
                % if the price is above the stop loss or below the
                % takeprofit, close the order
                        if price >= obj.orders(ordersIndex).stopLoss || price <= obj.orders(ordersIndex).takeProfit
%                             obj.orders(ordersIndex) = obj.orders(ordersIndex).closeOrder(price, date)
                              obj = obj.closeOrder(ordersIndex, price, date);
                        end
                    elseif obj.orders(ordersIndex).type == "BUY"
                % if the price is below the stop loss or above the
                % takeprofit, close the order
                        if price <= obj.orders(ordersIndex).stopLoss || price >= obj.orders(ordersIndex).takeProfit
%                             obj.orders(ordersIndex) = obj.orders(ordersIndex).closeOrder(price, date);
                              obj = obj.closeOrder(ordersIndex, price, date);
                        end
                    end
                end
             end
        end
        

        function [ordersOpen, ordersIndex ]= checkForOpenOrders(obj,orderType)
            ordersOpen = [];
            orderIndex = [];
            for ordersIndex = 1: size(obj.orders,1)
                singleOrder = obj.orders(ordersIndex);
                if singleOrder.type == orderType && singleOrder.status == "OPEN"
                    ordersOpen = [ordersOpen; singleOrder];
                    orderIndex = [orderIndex; ordersIndex];
                end
            end
        end
    end
end