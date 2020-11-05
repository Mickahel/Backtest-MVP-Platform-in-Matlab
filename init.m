%% Add paths
% add paths to the init file
addpath('./validation');
addpath('./inputTimeseries');
addpath('./models')    
addpath('./backtest')  
% add strategies
addpath('./strategies')

%add indicators
addpath('./indicators')
% import strategies
twoMovingAverageStrat = twoMovingAverageStrategy();
singleRSIStrat = singleRSIStrategy(); 
strategies = {singleRSIStrat,twoMovingAverageStrat};

%% Data input
origin = originEnumeration.InvestingUSA;
timeframe = timeframeEnumeration.Daily;
indicatorsParameters = [10,0.2,0.8];

strategyChosen = "single RSI Strategy";
% data input from CSV,InvestingUSA, AlphaVantage, datafeed
importedData = readtable('S&P 500 Historical Data Reversed with missing data.csv');

%% Data validation
validatedData  = validateData(importedData,timeframe, origin);

%% Creation of the Portfolio
portfolio = portfolioModel(1000000, validatedData.firstDate);

%% Backtest
% select the strategy
    strategy = strategySelector(strategies, strategyChosen);
    strategy= strategy.addIndicators(indicatorsParameters);

%backtest the strategy
    [portfolio, analytics] = backtestStrategy(portfolio, strategy, validatedData);
%% Analysis of the data of the backtest
