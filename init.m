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
indicatorsParameters = [4,30,70];

strategyChosen = "single RSI Strategy";
% data input from CSV,InvestingUSA, AlphaVantage, datafeed
importedData = readtable('C:\Users\Michelangelo\Desktop\Projects\Backtest-MVP-Platform-in-Matlab\inputTimeseries\S&P 500 Historical Data Reversed with missing data.csv');

%% Data validation
validatedData  = validateData(importedData,timeframe, origin);

%% Creation of the Portfolio
portfolio = portfolioModel(1000000, validatedData.firstDate);

%% Strategy Selection
% select the strategy
strategy = strategySelector(strategies, strategyChosen);
strategy = strategy.addIndicators(indicatorsParameters);

%% backtest the strategy
[portfolio] = backtestStrategy(portfolio, strategy, validatedData);
portfolio
%% Analysis of the data of the backtest
