SELECT p.*
FROM producer AS p
  INNER JOIN (SELECT *
              FROM movies
              WHERE year = 2000) AS m
    ON p.best_movie_id = m.id;

ALTER TABLE producer
  DROP COLUMN movie_id CASCADE;
ALTER TABLE movies
  ADD COLUMN prodecer_id INTEGER REFERENCES producer (id);

SELECT p.*
FROM producer AS p
  INNER JOIN
  (SELECT prodecer_id
   FROM movies
   GROUP BY prodecer_id
   HAVING count(*) > 5) AS m
    ON p.id = m.prodecer_id;

ALTER TABLE actors
  DROP COLUMN movie_id CASCADE;
CREATE TABLE actors_movies (
  id       SERIAL PRIMARY KEY,
  actor_id INTEGER REFERENCES actors (id),
  movie_id INTEGER REFERENCES movies (id)
);

SELECT movie_id
FROM actors_movies
GROUP BY movie_id
HAVING count(*) > 10;

ALTER TABLE movies
  ADD COLUMN rating FLOAT;

SELECT *
FROM movies
WHERE country = 'USA'
ORDER BY rating DESC
LIMIT 10;

SELECT m.*
FROM actors_movies AS am
  INNER JOIN (SELECT id
              FROM actors
              WHERE motherland = 'UK') AS a
    ON actor_id = a.id
  INNER JOIN (SELECT *
              FROM movies
              WHERE genre_id = (SELECT id
                                FROM genres
                                WHERE name = 'Ужасы')) AS m
    ON movie_id = m.id;

SELECT DISTINCT actors.*
FROM actors
  INNER JOIN actors_movies
    ON actors.id = actors_movies.actor_id
  INNER JOIN (SELECT
                id,
                prodecer_id
              FROM movies
              WHERE year BETWEEN 2007 AND 2010) AS m
    ON movie_id = m.id
  INNER JOIN (SELECT id
              FROM producer
              WHERE motherland = 'UK') AS p
    ON m.prodecer_id = p.id;

SELECT
  CASE
  WHEN (year < 2000)
    THEN 'до 2000'
  WHEN (year >= 2000 AND year < 2005)
    THEN '2000-2005'
  WHEN (year >= 2005 AND year < 2010)
    THEN '2005-2010'
  ELSE 'после 2010' END AS p,
  avg(budget)
FROM movies
GROUP BY p;

SELECT sum(budget)
FROM movies AS m INNER JOIN (SELECT *
                             FROM producer
                             WHERE surname SIMILAR TO '%(v|n)') AS p
    ON m.prodecer_id = p.id;

SELECT
  year,
  max(budget)
FROM movies
GROUP BY year
ORDER BY year;

SELECT *
FROM movies
WHERE (year < 2010 AND budget < ALL (SELECT DISTINCT budget
                                     FROM movies
                                     WHERE year >= 2010));

SELECT p.*
FROM producer AS p
  INNER JOIN movies AS m ON p.best_movie_id = m.id
WHERE m.budget > (SELECT min(budget)
                  FROM movies
                  WHERE year = 2015) AND
      m.budget < (SELECT max(budget)
                  FROM movies
                  WHERE year = 2016);

SELECT p.*
FROM producer AS p
WHERE p.id IN (SELECT DISTINCT prodecer_id
               FROM movies
               WHERE year < 2000)
      OR p.id IN (SELECT prodecer_id
                  FROM movies
                  GROUP BY prodecer_id
                  HAVING count(*) = 10);