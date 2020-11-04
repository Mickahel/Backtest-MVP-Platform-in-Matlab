classdef portfolioModel
    properties
        initialValue
        history
    end
    
    properties (SetAccess = private)
       %---- private variables
    end
    
    methods
        % constructor
        function obj = portfolioModel(initialValue)
            obj.initialValue = initialValue;
            obj.history = [0,history];
        end
        
        function obj = addOrder(obj, order)
        end
        
        function obj = removeOrder(obj, order)
            
        end
    end
end