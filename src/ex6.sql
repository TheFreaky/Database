SELECT *
FROM actors
WHERE motherland = 'Russia' AND current_date - actors.birthday > 40;

SELECT *
FROM actors AS a, producer AS p
WHERE a.motherland = p.motherland;

SELECT *
FROM producer, actors
WHERE (producer.id = 1 OR producer.id = 2) AND producer.best_movie_id = actors.movie_id;

SELECT
  year,
  COUNT(*)
FROM movies
WHERE movies.budget > 100
GROUP BY year;

SELECT *
FROM actors, movies
WHERE actors.movie_id = movies.id AND movies.year >= 2010 AND substring(actors.name, 1, 1) = 'В'
LIMIT 3;

