SELECT *
INTO OUTFILE '/var/lib/mysql-files/marvel_movies.csv' 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
FROM marvel_movies;