%% Add paths
% add paths to the init file
addpath('./validation');
addpath('./inputTimeseries');
addpath('./models')    

%% Data input
% inputs are:
% data: the dates and the prices
% portfolio amount

% data input from CSV,InvestingUSA, AlphaVantage, datafeed
importedData = readtable('S&P 500 Historical Data Reversed with missing data.csv');

% input of related information

%% Data validation
validatedData  = validateData(importedData,"1D", "investingUSA" );

%% Creation of the Portfolio
portfolio = portfolioModel(1000000);

%% Backtest
plot(validatedData.dates,validatedData.prices)
%% Analysis of the data of the backtest