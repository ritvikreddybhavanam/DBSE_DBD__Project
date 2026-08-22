USE movie_analytics_db;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,

    first_name VARCHAR(50) NOT NULL,

    last_name VARCHAR(50) NOT NULL,

    username VARCHAR(50) NOT NULL UNIQUE,

    email VARCHAR(100) NOT NULL UNIQUE,

    password VARCHAR(255) NOT NULL,

    phone VARCHAR(15),

    profile_image VARCHAR(255),

    bio TEXT,

    role ENUM('USER', 'ADMIN') DEFAULT 'USER',

    is_verified BOOLEAN DEFAULT FALSE,

    status ENUM('ACTIVE', 'BLOCKED') DEFAULT 'ACTIVE',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

DESCRIBE users;

CREATE TABLE directors (
    director_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,

    last_name VARCHAR(50) NOT NULL,

    birth_date DATE,

    nationality VARCHAR(50),

    biography TEXT,

    profile_image VARCHAR(255),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

DESCRIBE directors;

CREATE TABLE actors (
    actor_id INT AUTO_INCREMENT PRIMARY KEY,

    first_name VARCHAR(50) NOT NULL,

    last_name VARCHAR(50) NOT NULL,

    birth_date DATE,

    gender ENUM('Male','Female','Other'),

    nationality VARCHAR(50),

    biography TEXT,

    profile_image VARCHAR(255),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

DESCRIBE actors;


CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,

    genre_name VARCHAR(50) NOT NULL UNIQUE,

    description TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

DESCRIBE genres;


CREATE TABLE movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,

    title VARCHAR(255) NOT NULL,

    description TEXT,

    release_date DATE,

    runtime INT,

    language VARCHAR(50),

    country VARCHAR(100),

    budget DECIMAL(15,2),

    revenue DECIMAL(15,2),

    imdb_rating DECIMAL(3,1),

    average_rating DECIMAL(3,1) DEFAULT 0.0,

    poster_url VARCHAR(255),

    backdrop_url VARCHAR(255),

    trailer_url VARCHAR(255),

    director_id INT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_movies_director
        FOREIGN KEY (director_id)
        REFERENCES directors(director_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

DESCRIBE movies;

SHOW CREATE TABLE movies;


CREATE TABLE movie_genres (

    movie_genre_id INT AUTO_INCREMENT PRIMARY KEY,

    movie_id INT NOT NULL,

    genre_id INT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_movie_genres_movie
        FOREIGN KEY (movie_id)
        REFERENCES movies(movie_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_movie_genres_genre
        FOREIGN KEY (genre_id)
        REFERENCES genres(genre_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT uq_movie_genre
        UNIQUE(movie_id, genre_id)

);

DESCRIBE movie_genres;

SHOW CREATE TABLE movie_genres;


-- movie cast

create table movie_cast (
    movie_cast_id int auto_increment primary key,
    movie_id int not null,
    actor_id int not null,
    character_name varchar(100),
    cast_order int,
    created_at timestamp default current_timestamp,

    constraint fk_movie_cast_movie
        foreign key (movie_id)
        references movies(movie_id)
        on delete cascade
        on update cascade,

    constraint fk_movie_cast_actor
        foreign key (actor_id)
        references actors(actor_id)
        on delete cascade
        on update cascade,

    constraint uq_movie_actor
        unique (movie_id, actor_id)
);

describe movie_cast;
show create table movie_cast;

-- reviews
create table reviews (
    review_id int auto_increment primary key,
    user_id int not null,
    movie_id int not null,
    rating decimal(2, 1) not null,
    review_title varchar(150),
    review_text text not null,
    is_spoiler boolean default false,
    is_edited boolean default false,
    created_at timestamp default current_timestamp,

    updated_at timestamp default current_timestamp on update current_timestamp,

    CONSTRAINT fk_reviews_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_reviews_movie
        FOREIGN KEY (movie_id)
        REFERENCES movies(movie_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT chk_review_rating
        CHECK (rating >= 0.0 AND rating <= 5.0),

    CONSTRAINT uq_user_movie_review
        UNIQUE (user_id, movie_id)
);

describe reviews;

-- favourites

create table favorites (
    favorite_id int auto_increment primary key,
    user_id int not null,
    movie_id int not null,
    created_at timestamp default current_timestamp,

    CONSTRAINT fk_favorites_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_favorites_movie
        FOREIGN KEY (movie_id)
        REFERENCES movies(movie_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT uq_user_movie_favorite
        UNIQUE (user_id, movie_id)

);

DESCRIBE favorites;
SHOW CREATE TABLE favorites;

-- watchlist
CREATE TABLE watchlist (
    watchlist_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    movie_id INT NOT NULL,

    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_watchlist_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_watchlist_movie
        FOREIGN KEY (movie_id)
        REFERENCES movies(movie_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT uq_user_movie_watchlist
        UNIQUE (user_id, movie_id)
);

DESCRIBE watchlist;
SHOW CREATE TABLE watchlist;
