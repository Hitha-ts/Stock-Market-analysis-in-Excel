use stock ;
SELECT * FROM stock.stockmarket;


-- KPI 1 Average daily trading volume---
SELECT Ticker, concat(Format(Avg(Volume)/1000000,3)," M") AS "Volume" 
FROM stockmarket 
GROUP BY Ticker;


-- KPI2---
-- Most Volite Stock--
SELECT Ticker,Round(Avg(Beta),4) AS Avg_Beta
FROM stockmarket
GROUP BY Ticker;


/*Kpi 3
Stocks with Highest Dividend and Lowest Dividend */

SELECT Ticker,Round(Sum(`Dividend Amount`),1) As Dividend_Amount
FROM stockmarket
GROUP BY Ticker
order by Dividend_Amount desc;


/*Kpi 4
Highest and Lowest P/E Ratios */

SELECT Ticker,MAX(`PE Ratio`) AS Max_PE_Ratio, MIN(`PE Ratio`) AS Min_PE_Ratio
FROM stockmarket
GROUP BY Ticker;


/*Kpi 5
Stocks with Highest Market Cap */

SELECT Ticker,concat(Format(SUM(`Market Cap`)/1000000000,2)," B") As MarketCap
FROM stockmarket
GROUP BY Ticker
ORDER BY MarketCap desc;


/*Kpi 6
52 week high */
SELECT Ticker, Year, MAX(`52 Week High`) AS "52_week_high"
FROM stockmarket
GROUP BY Ticker, Year;


/*Kpi 6
52 week low */
SELECT Ticker, Year, MIN(`52 Week Low`) AS "52_week_low"
FROM stockmarket
GROUP BY Ticker, Year;


/*Kpi 8
Stocks with Strong Buy Signals and stocks with Strong Selling Signal */

 WITH Signals as (
	SELECT Ticker, case
	WHEN `stockmarket`.`RSI (14 days)` >=69 AND MACD<0 then "Strong_sell_signal"
	WHEN `stockmarket`.`RSI (14 days)` <69 AND MACD>0 then "Strong_buy_signal"
	ELSE "-"
	END AS "Signl"
	FROM stockmarket)
select Ticker, count(Signl) as "Total Strong sell signal" from Signals where Signl="Strong_sell_signal"
GROUP BY ticker;

 WITH Signals as (
	SELECT Ticker, case
	WHEN `stockmarket`.`RSI (14 days)` >=69 AND MACD<0 then "Strong_sell_signal"
	WHEN `stockmarket`.`RSI (14 days)` <69 AND MACD>0 then "Strong_buy_signal"
	ELSE "-"
	END AS "Signl"
	FROM stockmarket)
select Ticker, count(Signl) as "Total Strong buy signal" from Signals where Signl="Strong_buy_signal"
GROUP BY ticker;