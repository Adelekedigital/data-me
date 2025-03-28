

--create table for meteorites.db

CREATE TABLE "meteorites" (
    "id" INTEGER,
    "name" TEXT,
    "class" TEXT,
    "mass" TEXT,
    "discovery" TEXT,
    "year" TEXT,
    "lat" TEXT,
    "long" TEXT,
    PRIMARY KEY (id)
);

--create temporary table for cleaning data
CREATE TABLE "temp_meter" (
    "id" integer,
    "name" TEXT,
    "nametype" TEXT,
    "class" TEXT,
    "mass" TEXT,
    "discovery" TEXT,
    "year" TEXT,
    "lat" TEXT,
    "long" TEXT
);

--import csv data to temp_meter
.import meteorites.csv temp_meter

--updating mass, year, lat, and long column with empty value

UPDATE "temp_meter" SET "mass" = NULL
WHERE "mass" = '';

UPDATE "temp_meter" SET "year" = NULL
WHERE "year" = '';

UPDATE "temp_meter" SET "lat" = NULL
WHERE "lat" = '';

UPDATE "temp_meter" SET "long" = NULL
WHERE "long" = '';

--round all decimal value to nearest hundredths(2 decimal places)

UPDATE "temp_meter" SET "mass" = ROUND("mass", 2);

UPDATE "temp_meter" SET "lat" = ROUND("lat", 2);

UPDATE "temp_meter" SET "long" = ROUND("long", 2);

--delete rows with the nametype Relict
DELETE FROM "temp_meter" WHERE "nametype" = 'Relict';


--Sort by year(oldest to newest) and by name(if 2 meteorites landed in same year)

SELECT * FROM "temp_meter" WHERE "year" != 'NULL' ORDER BY "year", "name";

--insert clean data from temp_meter into m,eteorites
INSERT INTO "meteorites"("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name", "class", "mass", "discovery", "year", "lat", "long" FROM "temp_meter"
ORDER BY "year", "name";

--delete temp_meter
DROP TABLE "temp_meter";
