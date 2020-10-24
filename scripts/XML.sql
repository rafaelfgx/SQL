DECLARE @Table TABLE (Id INT, [Name] VARCHAR(MAX))

INSERT INTO @Table VALUES (1, 'Name 1')
INSERT INTO @Table VALUES (2, 'Name 2')
INSERT INTO @Table VALUES (3, 'Name 3')
INSERT INTO @Table VALUES (4, 'Name 4')
INSERT INTO @Table VALUES (5, 'Name 5')

DECLARE @Xml XML = (SELECT * FROM @Table AS TableXml FOR XML AUTO, ELEMENTS)

SELECT
	TableXml.Columns.value('Id[1]', 'INT') AS Id,
	TableXml.Columns.value('Name[1]', 'VARCHAR(MAX)') AS [Name]
FROM @Xml.nodes('TableXml') AS TableXml(Columns)