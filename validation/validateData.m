function [financialDataObject] = validateData(timeseriesData)
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
    % dateFormat = 'mm/dd/yyyy HH:MM:SS';
    %formattedDates = datestr(timeseriesData.Date,dateFormat);
    %formattedDates = string(formattedDates);
    formattedPrices=str2double(timeseriesData.Price);        % Note: "-" is interpreted as NaN
    % 2) sort the data
    [formattedDates, sortOrder] = sort(timeseriesData.Date);   
    formattedDates = datenum(formattedDates);
    formattedPrices = formattedPrices(sortOrder,:);
    [formattedPrices, missingData] = addMissingData(formattedPrices);
    
    % 3) calculate the returns 
    formattedReturns = [NaN;diff(formattedPrices)]./formattedPrices*100;
    
    financialDataObject = financialDataModel(...
        formattedDates,...      % dates
        formattedPrices,...     % prices
        formattedReturns,...    % returns
        missingData... %missingData
    );

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
            missingDataIndex=0;
            
            while  ~isa(prices(positionIndex+missingDataIndex), 'double')  || isnan(prices(positionIndex+missingDataIndex))
                missingDataIndex=missingDataIndex+1;
                missingData=missingData+1;
            end
            
            if missingDataIndex>0
                % if it's at the beginning
                if positionIndex==0 
                    lastPrice = prices(positionIndex+missingDataIndex);
                    firstPrice = lastPrice;
                % if the last price is NaN, then use FirstPrice
                elseif isnan(prices(positionIndex+missingDataIndex)) 
                    firstPrice = prices(positionIndex-1);
                    lastPrice = firstPrice;
                else
                    firstPrice = prices(positionIndex-1);
                    lastPrice = prices(positionIndex+missingDataIndex);    
                end
                
                % get the "m", the angular coefficient
                m=(lastPrice-firstPrice)/(missingDataIndex+1);
                % adding the new data
                for missingPriceIndex = 0:missingDataIndex-1
                    prices(positionIndex+missingPriceIndex) = firstPrice+m*(missingPriceIndex+1);
                end
            end
        end
    end
end

