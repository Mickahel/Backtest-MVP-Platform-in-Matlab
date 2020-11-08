function [portfolio, analytics] = backtestStrategy(portfolio, strategy, financialData)
%BACKTESTSTRATEGY 

%% Add paths
    addpath('./models')
    addpath('./indicators')
    addpath('./strategies')

%% Get the max start of each indicator
    startingValue = strategy.startingPoint()+1;

%% Get the amount of data to use for the indicators
    amountOfDataFromToday = strategy.amountOfDataFromToday();

    %% Cycle through dates
    for dateIndex  = startingValue : size(financialData.dates, 1)
        dataInputForStrategy = financialData.prices((dateIndex-amountOfDataFromToday):dateIndex-1);
        % For Each Day Check if you can open or close an order
        %dataAsInputForTheIndicator = financialData
        % 1) check what strategy says (buy/sell)
        orderType = strategy.checkForSignals(dataInputForStrategy);
        if orderType==orderTypeEnumeration.IDLE
            return
        end
        % 2) check if there are orders open
        % 2-1) check if the order is the same of the signal
        orderOpen = portfolio.checkForOpenOrders(orderType)
        % 2-1-1) hold the order
        % 2-2) check if the order is the opposite of the signal
        
        % 2-2) check if the order is the opposite of the signal
        
        % 3) open the order
        
        % in the last day, close all orders that are open at the close
        % price
        if dateIndex == size(financialData.dates, 1)
        
        end
    end
%% Set Analytics
    analytics = "banana";
end

