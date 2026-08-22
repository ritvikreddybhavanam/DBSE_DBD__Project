# Database Normalization

## Database Name

movie_analytics_db

## Purpose

The database is designed for a movie discovery and social review platform where Film Buffs can browse movies, view movie information, write reviews, rate movies, add movies to favorites, and maintain a personal watchlist.

The database is normalized up to Third Normal Form (3NF) to reduce data redundancy, improve data consistency, and maintain proper relationships between entities.

# 1. First Normal Form (1NF)

The database follows First Normal Form because each column stores atomic values and there are no repeating groups.

For example, a movie can have multiple actors and multiple genres. Instead of storing multiple actors or genres in a single column, separate tables and junction tables are used.

The following tables handle these relationships:

- `actors`
- `genres`
- `movie_cast`
- `movie_genres`

Therefore, each field contains a single value and repeating groups are avoided.

# 2. Second Normal Form (2NF)

The database follows Second Normal Form because non-key attributes depend on the complete primary key of their respective tables.

Many-to-many relationships are separated using junction tables.

For example:

`movie_genres` stores the relationship between movies and genres instead of storing movie details or genre details repeatedly.

Similarly, `movie_cast` stores the relationship between movies and actors.

Movie-specific information is stored in `movies`, genre information is stored in `genres`, and actor information is stored in `actors`.

This avoids partial dependencies and unnecessary duplication.

# 3. Third Normal Form (3NF)

The database follows Third Normal Form because non-key attributes depend on the primary key of their own table and there are no unnecessary transitive dependencies.

Different types of information are stored in separate tables.

For example:

- User information is stored in `users`.
- Movie information is stored in `movies`.
- Actor information is stored in `actors`.
- Director information is stored in `directors`.
- Genre information is stored in `genres`.
- Review information is stored in `reviews`.

Relationship tables such as `movie_genres`, `movie_cast`, `favorites`, and `watchlist` contain references to the related entities rather than duplicating their information.

This reduces redundancy and improves data consistency.

# 4. Normalization Conclusion

The `movie_analytics_db` database is designed according to normalization principles up to Third Normal Form (3NF).

Normalization provides the following benefits:

1. Reduces duplicate data.
2. Prevents inconsistent data.
3. Separates different entities logically.
4. Makes relationships easier to maintain.
5. Improves database integrity.
6. Makes future modifications easier.
7. Provides a structured foundation for the Film Buff website.