USE movie_analytics_db;

-- 1. Check all tables
SHOW TABLES;

-- 2. Check table structures
DESCRIBE users;
DESCRIBE directors;
DESCRIBE actors;
DESCRIBE genres;
DESCRIBE movies;
DESCRIBE movie_genres;
DESCRIBE movie_cast;
DESCRIBE reviews;
DESCRIBE favorites;
DESCRIBE watchlist;

-- 3. Check row counts
SELECT 'users' AS table_name, COUNT(*) AS total_rows FROM users
UNION ALL
SELECT 'directors', COUNT(*) FROM directors
UNION ALL
SELECT 'actors', COUNT(*) FROM actors
UNION ALL
SELECT 'genres', COUNT(*) FROM genres
UNION ALL
SELECT 'movies', COUNT(*) FROM movies
UNION ALL
SELECT 'movie_genres', COUNT(*) FROM movie_genres
UNION ALL
SELECT 'movie_cast', COUNT(*) FROM movie_cast
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews
UNION ALL
SELECT 'favorites', COUNT(*) FROM favorites
UNION ALL
SELECT 'watchlist', COUNT(*) FROM watchlist;

-- Checking the relationships
SELECT
    m.title,
    CONCAT(d.first_name, ' ', d.last_name) AS director
FROM movies m
JOIN directors d
    ON m.director_id = d.director_id;


SELECT
    m.title,
    g.genre_name
FROM movies m
JOIN movie_genres mg
    ON m.movie_id = mg.movie_id
JOIN genres g
    ON mg.genre_id = g.genre_id
ORDER BY m.title;


SELECT
    m.title,
    CONCAT(a.first_name, ' ', a.last_name) AS actor,
    mc.character_name
FROM movies m
JOIN movie_cast mc
    ON m.movie_id = mc.movie_id
JOIN actors a
    ON mc.actor_id = a.actor_id
ORDER BY m.title, mc.cast_order;


SELECT
    m.title,
    CONCAT(u.first_name, ' ', u.last_name) AS reviewer,
    r.rating,
    r.review_text
FROM reviews r
JOIN users u
    ON r.user_id = u.user_id
JOIN movies m
    ON r.movie_id = m.movie_id
ORDER BY r.created_at DESC;

