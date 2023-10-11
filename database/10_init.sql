CREATE EXTENSION IF NOT EXISTS postgis;

SET standard_conforming_strings = OFF;

\set schema 'public'

DROP TABLE IF EXISTS :schema."location" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'location' AND f_table_schema = :'schema';
BEGIN;
CREATE TABLE :schema."location" ( "id" BIGINT, CONSTRAINT "location_pk" PRIMARY KEY ("id") );
SELECT AddGeometryColumn(:'schema','location','geometry',3857,'POINT',2);
CREATE INDEX "location_geometry_geom_idx" ON :schema."location" USING GIST ("geometry");
ALTER TABLE :schema."location" ADD COLUMN "status" VARCHAR;
COMMIT;

BEGIN;
INSERT INTO "public"."location" ("geometry" , "id", "status") VALUES ('0101000020110F00002FD0C6BE713F29413797E8ED99A35641', 2, 'Bbb');
INSERT INTO "public"."location" ("geometry" , "id", "status") VALUES ('0101000020110F00008A6AB0148C41294179FD894878A35641', 3, 'Ccc');
INSERT INTO "public"."location" ("geometry" , "id", "status") VALUES ('0101000020110F000077387E7A414329412E177CD045A35641', 4, 'Ddé');
INSERT INTO "public"."location" ("geometry" , "id", "status") VALUES ('0101000020110F0000FA996D5FCF41294115FC628320A45641', 1, 'Aaä');
INSERT INTO "public"."location" ("geometry" , "id", "status") VALUES ('0101000020110F00009C17470AA13F294174C9C74F7DA35641', 5, 'Aaä');
INSERT INTO "public"."location" ("geometry" , "id", "status") VALUES ('0101000020110F00007FA9B9ABC540294117C40F466EA35641', 6, 'Aaä');
INSERT INTO "public"."location" ("geometry" , "id", "status") VALUES ('0101000020110F00005A1D334AD0412941717F04645CA35641', 7, 'Aaä');
INSERT INTO "public"."location" ("geometry" , "id", "status") VALUES ('0101000020110F00001D5534E0604029418E63629882A35641', 11, 'Bbb');
INSERT INTO "public"."location" ("geometry" , "id", "status") VALUES ('0101000020110F0000BAF6DD69B5402941CFC9758357A35641', 12, 'Bbb');
INSERT INTO "public"."location" ("geometry" , "id", "status") VALUES ('0101000020110F000066599F4DBE3F29417C2770924EA35641', 13, 'Bbb');
COMMIT;
