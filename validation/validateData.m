function [newData] = validateData(timeseriesData, timeframe, origin)
%VALIDATEDATA validates the input data by filling the gaps(anomalies), sorting ascending and  
% Inputs :
%     timeseriesData     : the raw data imported from the CSV
%     timeframe            : the timeframe of the data
%     origin                  : origin of the data
%
% Outputs:
%     newData             : a financialDataModel Object


    % add  paths
    addpath('./models')
    % 1) change dataType to timeseries dataType
    dateFormat = 'mm/dd/yyyy';
    formattedDates = datestr(timeseriesData.Date,dateFormat);
    formattedDates = string(formattedDates);
    formattedPrices=str2double(timeseriesData.Price);
    % calculate the returns 
    formattedReturns = [NaN;diff(formattedPrices)]./formattedPrices*100;
    
    newData = financialDataModel(...
        formattedDates,...      % dates
        formattedPrices,...     % prices
        formattedReturns,...    % returns
        timeframe,...            % timeframe
        origin...%origin
    )

end

