%% Asdd paths
%add paths to the init file
addpath('./validation');
addpath('./inputTimeseries');
    

%% data input
% data input from CSV, AlphaVantage/datafeed
importedData = readtable('S&P 500 Historical Data Reversed with missing data.csv');

% input of related information
%% Data validation
validatedData  = validateData(importedData,"1D", "investingUSA" );

%% Backtest 


%% Analysis of the data of the backtest