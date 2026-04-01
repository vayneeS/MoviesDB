SELECT DISTINCT LOWER(jt.character_name) AS character_name
INTO OUTFILE
    '/var/lib/mysql-files/marvel_characters.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM crew AS c
INNER JOIN marvel_movies m
    ON c.title_id = m.title_id
-- cross join is the syntax to create all array elements in a json table 
-- reference all three tables to filter out only marvel movies and characters
CROSS JOIN JSON_TABLE(
    c.show_characters,
    '$[*]' COLUMNS (character_name VARCHAR(255) PATH '$')
) AS jt
WHERE
    c.show_characters IS NOT NULL
    -- AND c.show_characters NOT LIKE '%Self%'
    -- AND LOWER(c.category) != 'self'
    -- AND c.category NOT LIKE 'archive_%'
    -- AND jt.character_name NOT LIKE '%Self%'
ORDER BY character_name;