DECLARE @Users TABLE (Id INT, [Name] VARCHAR(MAX))

INSERT INTO @Users VALUES (1, 'Name 1')
INSERT INTO @Users VALUES (2, 'Name 2')
INSERT INTO @Users VALUES (3, 'Name 3')
INSERT INTO @Users VALUES (4, 'Name 4')
INSERT INTO @Users VALUES (5, 'Name 5')

SELECT STUFF((SELECT ', ' + [Name] FROM @Users GROUP BY [Name] ORDER BY [Name] FOR XML PATH('')), 1, 1, '') AS Users