CREATE TABLE movies (
  name        VARCHAR(50),
  description TEXT,
  year        SMALLINT CHECK (year > 1900 AND year < date_part('year', CURRENT_DATE) + 10),
  genres      VARCHAR(50),
  country     VARCHAR(50),
  budget      NUMERIC CHECK (budget > 10000)
);

CREATE TABLE person (
  surname    VARCHAR(50) UNIQUE,
  name       VARCHAR(50) UNIQUE,
  birthday   DATE,
  motherland VARCHAR(50)
);

CREATE TABLE actors (
  number_of_movies INTEGER CHECK (number_of_movies > 5)
) INHERITS (person);

CREATE TABLE producer (
  motherland VARCHAR(50) DEFAULT 'USA'
) INHERITS (person);

ALTER TABLE movies ADD movie_id SERIAL PRIMARY KEY;
ALTER TABLE actors ADD movie_id INTEGER REFERENCES filmography.public.movies (id);
ALTER TABLE producer
  ADD movie_id INTEGER REFERENCES filmography.public.movies (id),
  ADD best_movie_id INTEGER REFERENCES filmography.public.movies (id);

ALTER TABLE movies ALTER country SET DEFAULT 'UK';

ALTER TABLE actors DROP CONSTRAINT actors_number_of_movies_check;

ALTER TABLE movies ADD CONSTRAINT ch_min_price CHECK (budget > 1000);

CREATE TABLE genres (
  id   SERIAL PRIMARY KEY,
  name VARCHAR(50)
);

ALTER TABLE movies
  DROP genres,
  ADD genre_id INTEGER REFERENCES genres (id);

CREATE TYPE COUNTRY AS ENUM ('USA', 'UK', 'Russia', 'France', 'Germany');

ALTER TABLE person
  DROP motherland,
  ADD motherland COUNTRY;

ALTER TABLE person
  ADD CONSTRAINT ch_right_date CHECK (birthday <= CURRENT_DATE);

CREATE INDEX ON actors (name, surname);

UPDATE movies SET name = concat(name, '(', year, ')');