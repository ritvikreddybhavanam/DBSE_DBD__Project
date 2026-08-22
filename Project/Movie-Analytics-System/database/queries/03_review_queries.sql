USE movie_analytics_db;


-- =========================================================
-- 1. Display all reviews
-- =========================================================

SELECT *
FROM reviews;


-- =========================================================
-- 2. Display reviews with user and movie information
-- =========================================================

SELECT
    r.review_id,
    CONCAT(u.first_name, ' ', u.last_name) AS reviewer,
    m.title AS movie,
    r.rating,
    r.review_title,
    r.review_text,
    r.is_spoiler,
    r.created_at
FROM reviews r
JOIN users u
    ON r.user_id = u.user_id
JOIN movies m
    ON r.movie_id = m.movie_id
ORDER BY r.created_at DESC;


-- =========================================================
-- 3. Get reviews for a particular movie
-- =========================================================

SELECT
    r.review_id,
    CONCAT(u.first_name, ' ', u.last_name) AS reviewer,
    r.rating,
    r.review_title,
    r.review_text,
    r.is_spoiler,
    r.created_at
FROM reviews r
JOIN users u
    ON r.user_id = u.user_id
WHERE r.movie_id = 1
ORDER BY r.created_at DESC;


-- =========================================================
-- 4. Get reviews written by a particular Film Buff
-- =========================================================

SELECT
    r.review_id,
    m.title,
    r.rating,
    r.review_title,
    r.review_text,
    r.created_at
FROM reviews r
JOIN movies m
    ON r.movie_id = m.movie_id
WHERE r.user_id = 2
ORDER BY r.created_at DESC;


-- =========================================================
-- 5. Calculate average rating of a movie
-- =========================================================

SELECT
    m.movie_id,
    m.title,
    ROUND(AVG(r.rating), 2) AS average_rating
FROM movies m
JOIN reviews r
    ON m.movie_id = r.movie_id
WHERE m.movie_id = 1
GROUP BY
    m.movie_id,
    m.title;


-- =========================================================
-- 6. Count reviews for a movie
-- =========================================================

SELECT
    m.movie_id,
    m.title,
    COUNT(r.review_id) AS total_reviews
FROM movies m
LEFT JOIN reviews r
    ON m.movie_id = r.movie_id
WHERE m.movie_id = 1
GROUP BY
    m.movie_id,
    m.title;


-- =========================================================
-- 7. Average rating and review count for every movie
-- =========================================================

SELECT
    m.movie_id,
    m.title,
    ROUND(AVG(r.rating), 2) AS average_rating,
    COUNT(r.review_id) AS total_reviews
FROM movies m
LEFT JOIN reviews r
    ON m.movie_id = r.movie_id
GROUP BY
    m.movie_id,
    m.title
ORDER BY average_rating DESC;


-- =========================================================
-- 8. Highest-rated movies based on user reviews
-- =========================================================

SELECT
    m.movie_id,
    m.title,
    ROUND(AVG(r.rating), 2) AS average_rating,
    COUNT(r.review_id) AS total_reviews
FROM movies m
JOIN reviews r
    ON m.movie_id = r.movie_id
GROUP BY
    m.movie_id,
    m.title
HAVING COUNT(r.review_id) >= 1
ORDER BY average_rating DESC
LIMIT 10;


-- =========================================================
-- 9. Reviews containing a particular word
-- =========================================================

SELECT
    r.review_id,
    m.title,
    CONCAT(u.first_name, ' ', u.last_name) AS reviewer,
    r.rating,
    r.review_text
FROM reviews r
JOIN users u
    ON r.user_id = u.user_id
JOIN movies m
    ON r.movie_id = m.movie_id
WHERE r.review_text LIKE '%great%';


-- =========================================================
-- 10. Display spoiler reviews
-- =========================================================

SELECT
    r.review_id,
    m.title,
    CONCAT(u.first_name, ' ', u.last_name) AS reviewer,
    r.rating,
    r.review_text
FROM reviews r
JOIN users u
    ON r.user_id = u.user_id
JOIN movies m
    ON r.movie_id = m.movie_id
WHERE r.is_spoiler = TRUE;


-- =========================================================
-- 11. Most reviewed movies
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
ORDER BY review_count DESC;


-- =========================================================
-- 12. Rating distribution for a movie
-- =========================================================

SELECT
    rating,
    COUNT(*) AS number_of_reviews
FROM reviews
WHERE movie_id = 1
GROUP BY rating
ORDER BY rating DESC;