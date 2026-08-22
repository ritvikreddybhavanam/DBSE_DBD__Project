use movie_analytics_db;

-- movie title
create index idx_movie_title
on movies(title);

-- movie release date
create index idx_movie_release_date
on movies(release_date);

-- user email
create index idx_user_email
on users(email);

-- review movie
create index idx_review_movie
on reviews(movie_id);

-- review user
create index idx_review_user
on reviews(user_id);

-- favorite user
create index idx_favorites_user
on favorites(user_id);

-- watchlist user
create index idx_watchlist_user
on watchlist(user_id);

show index from movies;