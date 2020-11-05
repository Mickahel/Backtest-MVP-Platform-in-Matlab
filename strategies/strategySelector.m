function [strategy] = strategySelector(strategies,strategyChosen)
%STRATEGYSELECTOR Summary of this function goes here
%   Detailed explanation goes here
    for index = 1: size(strategies,2)
        if strategies{index}.name  == strategyChosen
            strategy= strategies{index};
        end
        break
    end
end

