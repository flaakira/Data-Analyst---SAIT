--Set Database to AdventureWorksDW2019.

-- What are the top 10 selling products online?
SELECT TOP 10
			dp.EnglishProductName						AS	'Product Name'		, 
			SUM(fis.OrderQuantity)						AS	'Order Quantity'	,
			MAX(dpc.EnglishProductCategoryName)			AS	'Category'			,
			MAX(dps.EnglishProductsubCategoryName)		AS	'Subcategory'

FROM		FactInternetSales							AS fis 
	JOIN		DimProduct								AS dp
		ON	fis.productkey				=	dp.productkey
	JOIN		DimProductSubcategory					AS dps
		ON	dps.ProductSubcategoryKey	=	dp.ProductSubcategoryKey
	JOIN		DimProductCategory						AS dpc
		ON	dpc.ProductCategoryKey		=	dps.ProductCategoryKey

GROUP BY	dp.EnglishProductName
ORDER BY	'Order Quantity' DESC

--What was the revenue generated for each product in each country for 2013?
SELECT 
			dbo.DimDate.CalendarYear					AS	'Year'			,
			Territory.SalesTerritoryCountry				AS	'Country'		,
			Product.EnglishProductName					AS	'Product Name'	,
			COUNT(Sales.OrderQuantity)					AS	'Quantity'		,
			FORMAT(AVG(Sales.UnitPrice), '###,###.##')	AS	'Unit Price'	,
			SUM(Sales.UnitPrice)						AS	'Revenue'

FROM		dbo.FactInternetSales						AS Sales
	LEFT JOIN	dbo.DimProduct							AS Product
		ON Sales.ProductKey				=	Product.ProductKey
	LEFT JOIN	dbo.DimDate
		ON Sales.OrderDateKey			=	dbo.DimDate.DateKey
	LEFT JOIN	dbo.DimSalesTerritory					AS Territory
		ON Sales.SalesTerritoryKey		=	Territory.SalesTerritoryKey
	LEFT JOIN	dbo.DimCustomer							AS Customer
		ON Sales.CustomerKey			=	Customer.CustomerKey

WHERE		dbo.DimDate.CalendarYear	=	2013
GROUP BY	Product.EnglishProductName			,
			dbo.DimDate.CalendarYear			,
			Territory.SalesTerritoryCountry
ORDER BY	'Year'								,
			'Country'							,
			'Revenue' DESC						,
			'Product Name'
