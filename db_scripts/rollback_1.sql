ALTER TABLE musician RENAME TO singer;
SELECT CONSTRAINT_NAME INTO @nameConstraint FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                where TABLE_NAME = 'album' AND COLUMN_NAME = 'singerName';
SET @alterStmt = CONCAT('ALTER TABLE album DROP FOREIGN KEY ', @nameConstraint);
PREPARE stmt FROM @alterStmt;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
ALTER TABLE singer DROP PRIMARY KEY;
ALTER TABLE singer CHANGE COLUMN musicianName singerName varchar(50);
ALTER TABLE singer ADD PRIMARY KEY (singerName);
ALTER TABLE album ADD CONSTRAINT singerName FOREIGN KEY (singerName)
  REFERENCES singer(singerName);

ALTER TABLE singer DROP COLUMN role, DROP COLUMN bandName;

DROP TABLE IF EXISTS band;
