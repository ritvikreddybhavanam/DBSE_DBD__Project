USE movie_analytics_db;


-- =========================================================
-- 1. Display all movies
-- =========================================================

SELECT *
FROM movies;


-- =========================================================
-- 2. Display basic movie information
-- =========================================================

SELECT
    movie_id,
    title,
    release_date,
    language,
    average_rating
FROM movies
ORDER BY release_date DESC;


-- =========================================================
-- 3. Search movie by title
-- =========================================================

SELECT
    movie_id,
    title,
    release_date,
    average_rating
FROM movies
WHERE title LIKE '%Inception%';


-- =========================================================
-- 4. Search movies by partial title
-- Example: entering "inter" can find "Interstellar"
-- =========================================================

SELECT
    movie_id,
    title,
    release_date,
    average_rating
FROM movies
WHERE title LIKE '%inter%';


-- =========================================================
-- 5. Movies sorted by newest release
-- =========================================================

SELECT
    movie_id,
    title,
    release_date,
    average_rating
FROM movies
ORDER BY release_date DESC;


-- =========================================================
-- 6. Movies sorted by rating
-- =========================================================

SELECT
    movie_id,
    title,
    average_rating
FROM movies
ORDER BY average_rating DESC;

-- =========================================================
-- 7. Top 10 rated movies
-- =========================================================

SELECT
    movie_id,
    title,
    average_rating
FROM movies
ORDER BY average_rating DESC
LIMIT 10;


-- =========================================================
-- 8. Get movie with director
-- =========================================================

SELECT
    m.movie_id,
    m.title,
    m.release_date,
    CONCAT(d.first_name, ' ', d.last_name) AS director
FROM movies m
JOIN directors d
    ON m.director_id = d.director_id;


-- =========================================================
-- 9. Get complete movie information with director
-- =========================================================

SELECT
    m.movie_id,
    m.title,
    m.release_date,
    m.language,
    m.average_rating,
    m.description,
    CONCAT(d.first_name, ' ', d.last_name) AS director
FROM movies m
JOIN directors d
    ON m.director_id = d.director_id
WHERE m.movie_id = 1;


-- =========================================================
-- 10. Get movies belonging to a particular genre
-- =========================================================

SELECT
    m.movie_id,
    m.title,
    g.genre_name
FROM movies m
JOIN movie_genres mg
    ON m.movie_id = mg.movie_id
JOIN genres g
    ON mg.genre_id = g.genre_id
WHERE g.genre_name = 'Action';


-- =========================================================
-- 11. Display movie genres
-- =========================================================

SELECT
    m.movie_id,
    m.title,
    GROUP_CONCAT(g.genre_name SEPARATOR ', ') AS genres
FROM movies m
JOIN movie_genres mg
    ON m.movie_id = mg.movie_id
JOIN genres g
    ON mg.genre_id = g.genre_id
GROUP BY
    m.movie_id,
    m.title
ORDER BY m.title;


-- =========================================================
-- 12. Display movie cast
-- =========================================================

SELECT
    m.movie_id,
    m.title,
    CONCAT(a.first_name, ' ', a.last_name) AS actor,
    mc.character_name,
    mc.cast_order
FROM movies m
JOIN movie_cast mc
    ON m.movie_id = mc.movie_id
JOIN actors a
    ON mc.actor_id = a.actor_id
WHERE m.movie_id = 1
ORDER BY mc.cast_order;


-- =========================================================
-- 13. Count total movies
-- =========================================================

SELECT COUNT(*) AS total_movies
FROM movies;