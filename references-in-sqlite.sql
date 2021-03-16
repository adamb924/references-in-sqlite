-- wrap the whole business in a single transaction so sqlite doesn't do commits all the time
BEGIN TRANSACTION;

CREATE TEMP TABLE _csv_import ( osisRef text );

.separator "\t"
.import Bible.txt _csv_import

DROP TABLE IF EXISTS refs;
CREATE TABLE refs ( _id INTEGER PRIMARY KEY AUTOINCREMENT, osisRef text, lxxRef text, mtRef text );

INSERT INTO refs (osisRef) 
					SELECT osisRef
					FROM _csv_import WHERE 1;


-- For the Masoretic Text

DROP TABLE IF EXISTS mtRefs;
CREATE TABLE mtRefs ( fromRef text, toRef text );
.separator "\t"
.import Bible.ORG.txt mtRefs

UPDATE refs SET mtRef=(SELECT toRef FROM mtRefs WHERE refs.osisRef=mtRefs.fromRef);
INSERT INTO refs (osisRef, mtRef) SELECT fromRef,toRef FROM mtRefs WHERE fromRef NOT IN (SELECT osisRef FROM refs);

-- For the Septuagint

DROP TABLE IF EXISTS lxxRefs;
CREATE TABLE lxxRefs ( fromRef text, toRef text );
.separator "\t"
.import Bible.LXX.txt lxxRefs

UPDATE refs SET lxxRef=(SELECT toRef FROM lxxRefs WHERE refs.osisRef=lxxRefs.fromRef);
INSERT INTO refs (osisRef, lxxRef) SELECT fromRef,toRef FROM lxxRefs WHERE fromRef NOT IN (SELECT osisRef FROM refs);

-- Fill in the blanks
UPDATE refs SET lxxRef=osisRef WHERE lxxRef IS NULL;
UPDATE refs SET mtRef=osisRef WHERE mtRef IS NULL;

COMMIT TRANSACTION;
