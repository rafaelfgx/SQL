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

DECLARE @OrderProperty VARCHAR(100) = 'Id';
DECLARE @OrderAscending BIT = 1;
DECLARE @PageIndex INT = 1;
DECLARE @PageSize INT = 2;
DECLARE @SkipRows INT = (@PageIndex-1) * @PageSize;

;WITH Filtered AS (SELECT Id, Name FROM @Table)

SELECT Filtered.*, Total.* FROM Filtered
CROSS JOIN (SELECT COUNT(*) AS Total FROM Filtered) AS Total
ORDER BY
    CASE WHEN @OrderAscending IS NULL OR @OrderProperty IS NULL THEN Id END ASC,
    CASE WHEN @OrderAscending = 1 AND @OrderProperty = 'Id' THEN Id END ASC,
    CASE WHEN @OrderAscending = 0 AND @OrderProperty = 'Id' THEN Id END DESC,
    CASE WHEN @OrderAscending = 1 AND @OrderProperty = 'Name' THEN [Name] END ASC,
    CASE WHEN @OrderAscending = 0 AND @OrderProperty = 'Name' THEN [Name] END DESC
OFFSET @SkipRows ROWS FETCH NEXT @PageSize ROWS ONLY;