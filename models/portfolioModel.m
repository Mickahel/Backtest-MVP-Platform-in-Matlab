classdef portfolioModel
    properties
        initialValue
        valueHistory % matrix with columns : date, amount, return
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
    end
end