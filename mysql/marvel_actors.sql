SELECT
DISTINCT p.person_id, p.person_name, p.born, p.died
INTO OUTFILE 
    '/var/lib/mysql-files/marvel_actors.csv' 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
FROM people p
INNER JOIN crew c 
    ON p.person_id = c.person_id
INNER JOIN marvel_movies m 
    ON c.title_id = m.title_id
WHERE
    --  c.show_characters IS NOT NULL
    -- AND c.show_characters NOT LIKE '%Self%'
    -- AND LOWER(c.category) != 'self'
    -- AND c.category NOT LIKE 'archive_%'
    ( LOWER(c.category) = 'actor'
        OR LOWER(c.category) = 'actress' 
    )
ORDER BY p.person_id;