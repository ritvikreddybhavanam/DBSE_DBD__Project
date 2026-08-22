USE movie_analytics_db;


-- =========================================================
-- 1. Total number of movies
-- =========================================================

SELECT
    COUNT(*) AS total_movies
FROM movies;


-- =========================================================
-- 2. Total number of Film Buffs
-- =========================================================

SELECT
    COUNT(*) AS total_users
FROM users;


-- =========================================================
-- 3. Total number of reviews
-- =========================================================

SELECT
    COUNT(*) AS total_reviews
FROM reviews;


-- =========================================================
-- 4. Total number of favorites
-- =========================================================

SELECT
    COUNT(*) AS total_favorites
FROM favorites;


-- =========================================================
-- 5. Total number of movies in watchlists
-- =========================================================

SELECT
    COUNT(*) AS total_watchlist_entries
FROM watchlist;


-- =========================================================
-- 6. Average rating across all movies
-- =========================================================

SELECT
    ROUND(AVG(rating), 2) AS overall_average_rating
FROM reviews;


-- =========================================================
-- 7. Top rated movies
-- =========================================================

SELECT
    m.movie_id,
    m.title,
    ROUND(AVG(r.rating), 2) AS average_rating,
    COUNT(r.review_id) AS review_count
FROM movies m
JOIN reviews r
    ON m.movie_id = r.movie_id
GROUP BY
    m.movie_id,
    m.title
ORDER BY average_rating DESC
LIMIT 10;


-- =========================================================
-- 8. Most reviewed movies
-- =========================================================

SELECT
    m.movie_id,
    m.title,
    COUNT(r.review_id) AS review_count
FROM movies m
JOIN reviews r
    ON m.movie_id = r.movie_id
GROUP BY
    m.movie_id,
    m.title
ORDER BY review_count DESC
LIMIT 10;


-- =========================================================
-- 9. Most favorited movies
-- =========================================================

SELECT
    m.movie_id,
    m.title,
    COUNT(f.favorite_id) AS favorite_count
FROM movies m
JOIN favorites f
    ON m.movie_id = f.movie_id
GROUP BY
    m.movie_id,
    m.title
ORDER BY favorite_count DESC
LIMIT 10;


-- =========================================================
-- 10. Most watchlisted movies
-- =========================================================

SELECT
    m.movie_id,
    m.title,
    COUNT(w.watchlist_id) AS watchlist_count
FROM movies m
JOIN watchlist w
    ON m.movie_id = w.movie_id
GROUP BY
    m.movie_id,
    m.title
ORDER BY watchlist_count DESC
LIMIT 10;


-- =========================================================
-- 11. Most popular movies
-- Based on favorites + watchlist entries
-- =========================================================

SELECT
    m.movie_id,
    m.title,
    COUNT(DISTINCT f.favorite_id) AS favorite_count,
    COUNT(DISTINCT w.watchlist_id) AS watchlist_count
FROM movies m
LEFT JOIN favorites f
    ON m.movie_id = f.movie_id
LEFT JOIN watchlist w
    ON m.movie_id = w.movie_id
GROUP BY
    m.movie_id,
    m.title
ORDER BY
    (favorite_count + watchlist_count) DESC
LIMIT 10;


-- =========================================================
-- 12. Genre popularity
-- =========================================================

SELECT
    g.genre_id,
    g.genre_name,
    COUNT(mg.movie_id) AS movie_count
FROM genres g
LEFT JOIN movie_genres mg
    ON g.genre_id = mg.genre_id
GROUP BY
    g.genre_id,
    g.genre_name
ORDER BY movie_count DESC;


-- =========================================================
-- 13. Number of movies by release year
-- =========================================================

SELECT
    YEAR(release_date) AS release_year,
    COUNT(*) AS movie_count
FROM movies
GROUP BY YEAR(release_date)
ORDER BY release_year DESC;


-- =========================================================
-- 14. Most active Film Buffs
-- Based on number of reviews
-- =========================================================

SELECT
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    COUNT(r.review_id) AS review_count
FROM users u
JOIN reviews r
    ON u.user_id = r.user_id
GROUP BY
    u.user_id,
    u.first_name,
    u.last_name
ORDER BY review_count DESC
LIMIT 10;


-- =========================================================
-- 15. Movies with no reviews
-- =========================================================

SELECT
    m.movie_id,
    m.title
FROM movies m
LEFT JOIN reviews r
    ON m.movie_id = r.movie_id
WHERE r.review_id IS NULL;


-- =========================================================
-- 16. Movies with no favorites
-- =========================================================

SELECT
    m.movie_id,
    m.title
FROM movies m
LEFT JOIN favorites f
    ON m.movie_id = f.movie_id
WHERE f.favorite_id IS NULL;


-- =========================================================
-- 17. Movies with no watchlist entries
-- =========================================================

SELECT
    m.movie_id,
    m.title
FROM movies m
LEFT JOIN watchlist w
    ON m.movie_id = w.movie_id
WHERE w.watchlist_id IS NULL;