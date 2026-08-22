USE movie_analytics_db;


-- =========================================================
-- 1. Display all users
-- =========================================================

SELECT *
FROM users;


-- =========================================================
-- 2. Display basic user information
-- =========================================================

SELECT
    user_id,
    first_name,
    last_name,
    email,
    created_at
FROM users
ORDER BY created_at DESC;


-- =========================================================
-- 3. Find user by email
-- =========================================================

SELECT
    user_id,
    first_name,
    last_name,
    email
FROM users
WHERE email = 'user@example.com';


-- =========================================================
-- 4. Search users by name
-- =========================================================

SELECT
    user_id,
    first_name,
    last_name,
    email
FROM users
WHERE first_name LIKE '%John%'
   OR last_name LIKE '%John%';


-- =========================================================
-- 5. Display a user's profile
-- =========================================================

SELECT
    user_id,
    first_name,
    last_name,
    email,
    profile_image,
    bio,
    created_at
FROM users
WHERE user_id = 2;


-- =========================================================
-- 6. Count total Film Buffs
-- =========================================================

SELECT COUNT(*) AS FilmBuffs
FROM users;


-- =========================================================
-- 7. Get user's favorite movies
-- =========================================================

SELECT
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    m.movie_id,
    m.title,
    f.created_at
FROM users u
JOIN favorites f
    ON u.user_id = f.user_id
JOIN movies m
    ON f.movie_id = m.movie_id
WHERE u.user_id = 2
ORDER BY f.created_at DESC;


-- =========================================================
-- 8. Get user's watchlist
-- =========================================================

SELECT
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    m.movie_id,
    m.title,
    w.added_at
FROM users u
JOIN watchlist w
    ON u.user_id = w.user_id
JOIN movies m
    ON w.movie_id = m.movie_id
WHERE u.user_id = 2
ORDER BY w.added_at DESC;


-- =========================================================
-- 9. Get user's reviews
-- =========================================================

SELECT
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    m.title,
    r.rating,
    r.review_title,
    r.review_text,
    r.created_at
FROM users u
JOIN reviews r
    ON u.user_id = r.user_id
JOIN movies m
    ON r.movie_id = m.movie_id
WHERE u.user_id = 2
ORDER BY r.created_at DESC;


-- =========================================================
-- 10. Count user's favorites
-- =========================================================

SELECT
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    COUNT(f.favorite_id) AS total_favorites
FROM users u
LEFT JOIN favorites f
    ON u.user_id = f.user_id
WHERE u.user_id = 2
GROUP BY
    u.user_id,
    u.first_name,
    u.last_name;


-- =========================================================
-- 11. Count user's watchlist movies
-- =========================================================

SELECT
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    COUNT(w.watchlist_id) AS total_watchlist
FROM users u
LEFT JOIN watchlist w
    ON u.user_id = w.user_id
WHERE u.user_id = 2
GROUP BY
    u.user_id,
    u.first_name,
    u.last_name;


-- =========================================================
-- 12. Count reviews written by a user
-- =========================================================

SELECT
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    COUNT(r.review_id) AS total_reviews
FROM users u
LEFT JOIN reviews r
    ON u.user_id = r.user_id
WHERE u.user_id = 2
GROUP BY
    u.user_id,
    u.first_name,
    u.last_name;