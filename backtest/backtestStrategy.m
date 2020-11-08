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
        todayPrice = financialData.prices(dateIndex)
        todayDate = financialData.dates(dateIndex)
        amountInPortfolio = portfolio.value
        % For Each Day Check if you can open or close an order

        % 0) check if you can close orders that go in take profit or stop
        % loss
        
        % TODO
        portfolio = portofolio.checkForOrdersToClose();
        % in the last day, close all orders that are open at the close
        % price
        if dateIndex == size(financialData.dates, 1)
            break
        else
            % 1) check what strategy says (buy/sell)
            orderType = strategy.checkForSignals(dataInputForStrategy);

            if orderType==orderTypeEnumeration.IDLE
                continue
            end
            % 2) check if there are orders open
            [orderOpen,orderIndex] = portfolio.checkForOpenOrders(orderType)
            
            % 3) if no order is open, open the order
             if isempty(orderOpen)
                orderPlaced = orderModel(todayPrice, todayDate, orderType, amountInPortfolio)          
                portfolio = portfolio.addOrder(orderPlaced)
 
%             % 4) check if the order is the same of the signal
%             elseif isOrderOfThisType(orderOpen, orderType) % if true
%             % 5) hold the order
%             
%             % 6) check if the order is the opposite of the signal
%             else not(isOrderOfThisType(orderOpen, orderType)
%                 
%             % 2-2) check if the order is the opposite of the signal
%         
             end
        end
    end
%% Set Analytics
    analytics = "banana";
end

function areTheSameType = isOrderOfThisType(order,orderType)
    if order.type == orderType
        areTheSameType= true
    else
        areTheSameType= false
    end
end