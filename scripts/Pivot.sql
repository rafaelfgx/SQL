DROP TABLE IF EXISTS #Table

CREATE TABLE #Table ([Year] INT, Product VARCHAR(MAX), Quantity INT)

INSERT INTO #Table VALUES (2019, 'Product 1', 25)
INSERT INTO #Table VALUES (2019, 'Product 2', 15)
INSERT INTO #Table VALUES (2019, 'Product 3', 45)
INSERT INTO #Table VALUES (2020, 'Product 1', 50)
INSERT INTO #Table VALUES (2020, 'Product 2', 45)

SELECT * FROM #Table

DECLARE @Columns VARCHAR(MAX) = STUFF((SELECT ', ' + QUOTENAME(Product) FROM #Table GROUP BY Product FOR XML PATH('')), 1, 1, '')

EXECUTE('SELECT [Year],' + @Columns + ' FROM #Table PIVOT (SUM(Quantity) FOR Product IN (' + @Columns + ')) AS P ORDER BY 1;')

DROP TABLE IF EXISTS #Table