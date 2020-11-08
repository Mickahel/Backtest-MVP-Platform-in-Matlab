classdef portfolioModel
    properties
        initialValue
        valueHistory % matrix with columns : date, amount, return
        orders
    end
    
    properties (SetAccess = private)
       %---- private variables
    end
    
    methods
        % constructor
        function obj = portfolioModel(initialValue,firstDate)
            obj.initialValue = initialValue;
            obj.valueHistory = [firstDate,initialValue, NaN];
        end
        
        function obj = addOrder(obj, order)
        end
        
        function obj = removeOrder(obj, order)
            
        end
        
        function amount = amount(obj)
            amount = obj.valueHistory(end, 2);
        end
        function [ordersOpen, ordersIndex ]= checkForOpenOrders(obj,orderType)
            ordersOpen = [];
            ordersIndex = [];
            for ordersIndex = 1: size(ordersOpen,1)
                singleOrder = obj.orders(ordersIndex);
                if singleOrder.type == orderType && singleOrder.status == "OPEN"
                    ordersOpen = [ordersOpen; singleOrder];
                    ordersIndex = [ordersIndex; ordersIndex];
                end
            end
        end
    end
end