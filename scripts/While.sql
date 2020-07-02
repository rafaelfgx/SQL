DECLARE @Table TABLE (Id INT, [Name] VARCHAR(MAX), [Line] INT)

INSERT INTO @Table VALUES (1, 'Name 1', NULL)
INSERT INTO @Table VALUES (2, 'Name 2', NULL)
INSERT INTO @Table VALUES (3, 'Name 3', NULL)
INSERT INTO @Table VALUES (4, 'Name 4', NULL)
INSERT INTO @Table VALUES (5, 'Name 5', NULL)

DECLARE	@Line INT = 0;
DECLARE @CurrentLine INT = NULL;
DECLARE @FinalLine INT = NULL;

UPDATE @Table SET @Line = [Line] = @Line + 1;

SELECT @CurrentLine = MIN([Line]) FROM @Table

WHILE @CurrentLine IS NOT NULL
BEGIN
	SET @FinalLine = @CurrentLine;

	--START
	PRINT @CurrentLine
	--END

	SELECT @CurrentLine = MIN([Line]) FROM @Table WHERE [Line] > @FinalLine
END