CREATE TABLE IF NOT EXISTS band (       bandName varchar(50),
                                        creation YEAR,
                                        genre varchar(50),
                                        PRIMARY KEY(bandName));

INSERT INTO band VALUES ('Crazy Duo', 2015, 'rock');
INSERT INTO band VALUES ('Luna', 2009, 'classical');
INSERT INTO band VALUES ('Mysterio' , 2019, 'pop');


ALTER TABLE singer RENAME TO musician;
SELECT CONSTRAINT_NAME INTO @nameConstraint FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                where TABLE_NAME = 'album' AND COLUMN_NAME = 'singerName';
SET @alterStmt = CONCAT('ALTER TABLE album DROP FOREIGN KEY ', @nameConstraint);
PREPARE stmt FROM @alterStmt;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
ALTER TABLE musician DROP PRIMARY KEY;
ALTER TABLE musician CHANGE COLUMN singerName musicianName varchar(50);
ALTER TABLE musician ADD PRIMARY KEY (musicianName);
ALTER TABLE album ADD CONSTRAINT singerName FOREIGN KEY (singerName)
  REFERENCES musician(musicianName);

ALTER TABLE musician ADD COLUMN role varchar(50);
ALTER TABLE musician ADD COLUMN bandName varchar(50);

UPDATE musician SET role = 'vocals', bandName = 'Crazy Duo' WHERE musicianName = 'Alina';
UPDATE musician SET role = 'guitar', bandName = 'Mysterio' WHERE musicianName = 'Mysterio';
UPDATE musician SET role = 'percussion', bandName = 'Crazy Duo' WHERE musicianName = 'Rainbow';
UPDATE musician SET role = 'piano', bandName = 'Luna' WHERE musicianName = 'Luna';

