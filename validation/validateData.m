function [financialDataObject] = validateData(timeseriesData, timeframe, origin)
%VALIDATEDATA validates the input data by filling the gaps(anomalies), sorting ascending and  
% Inputs :
%     timeseriesData     : the raw data imported from the CSV
%     timeframe            : the timeframe of the data
%     origin                  : origin of the data
%
% Outputs:
%     newData             : a financialDataModel Object

    % 0) add  paths
    addpath('./models')
    % 1) change dataType to timeseries dataType
    % dateFormat = 'mm/dd/yyyy';
    %formattedDates = datestr(timeseriesData.Date,dateFormat);
    %formattedDates = string(formattedDates);
    formattedPrices=str2double(timeseriesData.Price);        % Note: "-" is interpreted as NaN
    % 2) sort the data
    [formattedDates, sortOrder] = sort(timeseriesData.Date);   
    formattedPrices = formattedPrices(sortOrder,:);
    [formattedPrices, missingData] = addMissingData(formattedPrices) ;
    formattedPrices
    % 3) calculate the returns 
    formattedReturns = [NaN;diff(formattedPrices)]./formattedPrices*100;
    
    financialDataObject = financialDataModel(...
        formattedDates,...      % dates
        formattedPrices,...     % prices
        formattedReturns,...    % returns
        timeframe,...            % timeframe
        origin,...%origin
        missingData... %missingData
    )

end


function [prices, missingData] = addMissingData(prices)
%ADDMISSINGDATA fills the anomalies with linear data 
% Inputs :
%     prices     : the prices vector Nx1
%
% Outputs:
%     prices             : the prices vector Nx1 with filled data
%     missingData    : amount of missing
    missingData=0;

    for positionIndex = 1:size(prices,1)
        %search for the first anomaly
        if prices(positionIndex) <= 0  || isnan(prices(positionIndex)) || isempty(prices(positionIndex))
            % TODO: if it is the first element of the series
            missingData= missingData+1; 
            missingDataIndex=0;
            firstPrice = prices(positionIndex-1); 
            while  ~isa(prices(positionIndex+missingDataIndex), 'double')  
                missingDataIndex=missingDataIndex+1;
                missingData=missingData+1;
            end   
            lastPrice = prices(positionIndex+missingDataIndex+1);
            % get the "m", the angular coefficient
            m=(lastPrice-firstPrice)/(missingDataIndex-1);
            coefficientToAdd = m/(missingDataIndex+1);
            % adding the new data
            for missingPriceIndex = 1:missingDataIndex
                prices(positionIndex+missingPriceIndex) = firstPrice+coefficientToAdd*missingDataIndex;
            end
        end
    end

end

