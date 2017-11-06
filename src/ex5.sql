CREATE TABLE ex5.base (
  comment TEXT
);

CREATE TABLE ex5.materials (
  name VARCHAR(15),
  CONSTRAINT PK_materials_name PRIMARY KEY (name)
);

CREATE TABLE ex5.districts (
  name VARCHAR(15),
  CONSTRAINT PK_districts_name PRIMARY KEY (name)
);

CREATE TABLE ex5.building_locations (
  kadastr  VARCHAR(20),
  address  VARCHAR(60),
  district VARCHAR(15)
);

CREATE TABLE ex5.buildings (
  land              NUMERIC(12, 2) CHECK (line > 0),
  year              SMALLINT,
  walls_material    VARCHAR(15),
  basement_material VARCHAR(15),
  wear              SMALLINT,
  flow              SMALLINT,
  line              SMALLINT,
  square            INTEGER CHECK (square > 0),
  picture           TEXT,
  hall              SMALLINT,
  elevator          BOOLEAN,
  CONSTRAINT PK_buildings_kadastr PRIMARY KEY (kadastr),
  CONSTRAINT FK_buildings_district FOREIGN KEY (district) REFERENCES ex5.districts (name),
  CONSTRAINT FK_buildings_walls_material FOREIGN KEY (walls_material) REFERENCES ex5.materials (name),
  CONSTRAINT FK_buildings_basement_material FOREIGN KEY (walls_material) REFERENCES ex5.materials (name)

) INHERITS (ex5.base);

CREATE TABLE ex5.halls (
  num              SMALLINT,
  storey           SMALLINT,
  room_count       SMALLINT,
  level            BOOLEAN,
  square           INTEGER,
  branch           INTEGER,
  balcony          INTEGER,
  height           SMALLINT,
  socket           SMALLINT,
  section          SMALLINT,
  building_kadastr VARCHAR(20),
  CONSTRAINT PK_halls_id PRIMARY KEY (num, building_kadastr),
  CONSTRAINT FK_halls_building_kadastr FOREIGN KEY (building_kadastr) REFERENCES ex5.buildings (address)
) INHERITS (ex5.base);

CREATE TABLE ex5.rooms (
  record           INTEGER,
  square           INTEGER,
  size             VARCHAR(40),
  name             VARCHAR(30),
  decoration       VARCHAR(60),
  height           INTEGER,
  hall_num         SMALLINT,
  building_kadastr VARCHAR(20),
  CONSTRAINT PK_rooms_id PRIMARY KEY (record, hall_num, building_kadastr),
  CONSTRAINT FK_rooms_hall_id FOREIGN KEY (hall_num, building_kadastr) REFERENCES ex5.halls (num, building_address)
) INHERITS (ex5.base);