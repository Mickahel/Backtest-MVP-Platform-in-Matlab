function [portfolio, validatedData ] = init(initialPortfolioValue, timeseriesPath, strategyChosen, optimize, indicatorsParameters)
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

    % indicatorsParameters = [4,30,70];
    % strategyChosen = "single RSI Strategy";

    % indicatorsParameters = [4;8];

    % data input from CSV,InvestingUSA
     
    importedData = readtable(timeseriesPath);
    %% Data validation
    validatedData  = validateData(importedData);

    %% Creation of the Portfolio
    portfolio = portfolioModel(initialPortfolioValue, validatedData.firstDate);

    %% Strategy Selection
    % select the strategy
    strategy = strategySelector(strategies, strategyChosen);


    %% if not optimization
    if optimize == false
        strategy = strategy.addIndicators(indicatorsParameters);

        %% backtest the strategy
        [portfolio] = backtestStrategy(portfolio, strategy, validatedData);

        %% Analysis of the data of the backtest
        portfolio.analytics = analyticsModel(portfolio);

    %% if optimization
    elseif optimize == true
        portfolios = [];
        %% RSI
        if strategy.name =="single RSI Strategy"
            % for each period
            for periodIndex = 3:indicatorsParameters(1)
                % for each lowerBand
                for lowerBandIndex = 3:indicatorsParameters(2)
                    % for each higherBand
                    for higherBandIndex = 3:indicatorsParameters(3)
                        params = [periodIndex, lowerBandIndex, higherBandIndex]
                         strategy = strategy.addIndicators(params);
                          [portfolio] = backtestStrategy(portfolio, strategy, validatedData);
                         portfolio.analytics = analyticsModel(portfolio);
                         portfolios = [portfolios;portfolio];
                    end
                end
            end

        %% 2 MA
        elseif strategy.name =="two Moving Average Strategy"
            % for each fast MA period
            for fastMAIndex = 1:indicatorsParameters(1)
                % for each slow MA period
                for slowMAIndex = 2:indicatorsParameters(2)
                    params = [fastMAIndex,slowMAIndex]
                        strategy = strategy.addIndicators(params);
                        [portfolio] = backtestStrategy(portfolio, strategy, validatedData);
                        portfolio.analytics = analyticsModel(portfolio);
                        portfolios = [portfolios;portfolio];
                end
            end
        end
        %% check for best portfolio
        portfolio = portfolios(1);
        portfolio.analytics.sharpeRatio
        for portIndex = 1: size(portfolios,1)
            if portfolios(portIndex).analytics.sharpeRatio>portfolio.analytics.sharpeRatio
                portfolio = portfolios(portIndex);
            end
        end    
    end
end
