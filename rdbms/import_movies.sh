#!/bin/bash

# Function to check if PostgreSQL server is already running
check_postgres_running() {
  pg_isready >/dev/null 2>&1
  return $?
}

# Function to check if PostgreSQL server is ready
check_postgres() {
  until check_postgres_running
  do
    echo "Waiting for PostgreSQL server to start..."
    sleep 1
  done
}

# Call the function to check if PostgreSQL server is ready
check_postgres

# Import movies CSV file
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "CREATE TABLE MOVIES (budget float, genres json ,homepage varchar,id int primary key,keywords json, original_language varchar ,original_title varchar ,overview varchar, popularity varchar ,production_companies json,production_countries json,release_date varchar,revenue float,runtime float,spoken_languages json,status varchar,tagline varchar,title varchar,vote_average float ,vote_count integer)"
# Import the data from the CSV file into the table
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "COPY MOVIES FROM '/rdbms/movies.csv' DELIMITER ',' CSV HEADER"

# Import genres CSV file
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "CREATE TABLE GENRES (genre varchar, genre_id integer , movie_id integer)"
# Import the data from the CSV file into the table
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "COPY GENRES FROM '/rdbms/genres.csv' DELIMITER ',' CSV HEADER"

# Import keywords CSV file

psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "CREATE TABLE KEYWORDS (keyword varchar, keyword_id integer , movie_id integer)"
# Import the data from the CSV file into the table
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "COPY KEYWORDS FROM '/rdbms/keywords.csv' DELIMITER ',' CSV HEADER"

# Import credits CSV file
#psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "CREATE TABLE CREDITS (movie_id integer primary key,title varchar ,casting json, crew json)"
# Import the data from the CSV file into the table
#psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "COPY CREDITS FROM '/csvs/tmdb_5000_credits.csv' DELIMITER ',' CSV HEADER"