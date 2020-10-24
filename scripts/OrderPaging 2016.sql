DECLARE @Table TABLE (Id INT, [Name] VARCHAR(250));

INSERT INTO @Table VALUES (1, 'Name 01');
INSERT INTO @Table VALUES (2, 'Name 02');
INSERT INTO @Table VALUES (3, 'Name 03');
INSERT INTO @Table VALUES (4, 'Name 04');
INSERT INTO @Table VALUES (5, 'Name 05');
INSERT INTO @Table VALUES (6, 'Name 06');
INSERT INTO @Table VALUES (7, 'Name 07');
INSERT INTO @Table VALUES (8, 'Name 08');
INSERT INTO @Table VALUES (9, 'Name 09');

DECLARE @PageIndex INT = 1;
DECLARE @PageSize INT = 2;
DECLARE @OrderProperty VARCHAR(100) = 'Id';
DECLARE @OrderAsc BIT = 1;
DECLARE @InitialPage INT = (@PageIndex	* @PageSize) - 1;
DECLARE @FinalPage INT = (@InitialPage	+ @PageSize) - 1;

;WITH FilteredOrdered AS
(
	SELECT *,
		COUNT(*) OVER () AS Total,
		ROW_NUMBER() OVER (ORDER BY
			CASE WHEN @OrderAsc	IS NULL	OR @OrderProperty IS NULL THEN Id END ASC,
			CASE WHEN @OrderAsc	= 1 AND @OrderProperty = 'Id' THEN Id END ASC,
			CASE WHEN @OrderAsc	= 0 AND @OrderProperty = 'Id' THEN Id END DESC,
			CASE WHEN @OrderAsc	= 1 AND @OrderProperty = 'Name' THEN [Name] END ASC,
			CASE WHEN @OrderAsc	= 0 AND @OrderProperty = 'Name' THEN [Name] END DESC
		) AS Line
	FROM @Table
)

SELECT * FROM FilteredOrdered WHERE @PageSize IS NULL OR (Line BETWEEN @InitialPage AND @FinalPage);