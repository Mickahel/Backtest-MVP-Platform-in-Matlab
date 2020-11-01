# Backtest-MVP-Platform-in-Matlab

# Functional Analysis

# Objective

Create a script that manages a complete backtests and optimizes a trading strategy (built relying on one or more indicators) given a stock and a period of backtest.

# Logical Steps for the Backtest

The logical steps the script will execute will be:

## 1) User information input and data gathering

The user will insert in the script these information(by command input or GUI if possible):

- Ticker of the stock
- Start date of the backtest
- End date of the backtest

The script will search for the close price or the adjusted close price of the stock for the chosen period on [Alpha Vantage](https://www.alphavantage.co/) and will store the timeseries by parsing the JSON object provided by the Data Provider.

The user will be also able to upload the CSV of the prices.

## 2) Data Filtering and Validation

Data downloaded could have outliers, missing data  (maybe the data for the data interval provided is not available) or just weird data such as a string of text instead of the price: the data needs to be treated and analyzed in order to solve these problems.

In order to spot outliers, the code will check for first if the data requested for the interval exists (is the data available from and to the dates the user provided?).

Moreover, the timeseries will be scanned to check if there is missing data:

If some points of the timeseries are missing, they will be filled by the mean between the left and right point of the timeseries.

If more than one point of the timeseries are missing in an interval such as

[Untitled](https://www.notion.so/9cec13457e314a24a31e2538ba722af4)

Then, it will be calculated the interval not available(t=3) and the difference between the 2 available price (diffPrice=20-15=5).
The new data used as a fill for the missing points will be calculated as:

$m=(y_2-y_1)/(x_2-x_1)$

$q=y_2-m\cdot y_1$

$P_t=t\cdot m+q$

## 3) Backtest of the strategy and fake creation of sell and buy orders

The indicator chosen will be probably 2 Moving Average and the trading system will be based on the simple trading strategy:
BUY if the faster MA crosses upperward the slower one

SELL if the faster MA crosses downward the slower one

The backtest will 

## 4) Optimization of "optimizable input parameters"

The Inputs of the indicators aren't fine tuned as they're chosen by the user or hardcoded in the script.

the point 3 wil be run several times in order to create several scenarios: the parameters for each scenario will be different as it will have different inputs.

The input used for the scenario are:

- Input values of the Indicators
- Profit/StopLoss ratio
- % of capital to invest

## 5) Analysis of the data collected

there will be collected information as:

- Profit/Loss
- "Has the strategy beaten the market?"
- Variance of the profit
- % Drawdown
- Period of Sink of drawdown (if possible)
- Orders done
- Amount of Orders in profit
- % Orders in profit
- Profit made by Orders in profit
- Amount of Orders in loss
- % Orders in profit
- Profit made by Orders in profit
- Sharpe Ratio
- Sortino Ratio
- A Chart of the profit/loss

## 6) Pareto Efficiency on Fundamental Data in order to spot the best strategy

in all scenarios there has to be a best scenario. From the best scenario, it's possible to get the best input data for the timeseries chosen.

How to spot the best scenario?

with a pareto frontier computed by Profit and drawdown(or variance)