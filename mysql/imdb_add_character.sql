-- Manual corrections to crew data missing from IMDB source
-- These rows are absent from title.principals.tsv and must be added explicitly.

USE IMDb;

-- INSERT INTO crew (title_id, person_id, category, job, show_characters)
-- VALUES ('tt0371746', 'nm0000375', 'actor', NULL, '["Iron Man"]'),
--        ('tt1228705', 'nm0000375', 'actor', NULL, '["Iron Man"]'),
--        ('tt1300854', 'nm0000375', 'actor', NULL, '["Iron Man"]');

UPDATE crew
SET show_characters = JSON_ARRAY_APPEND(show_characters, '$', 'Iron Man')
WHERE title_id = 'tt0371746'
  AND person_id = 'nm0000375'
  AND JSON_CONTAINS(show_characters, '"Iron Man"') = 0;

UPDATE crew
SET show_characters = JSON_ARRAY_APPEND(show_characters, '$', 'Iron Man')
WHERE title_id = 'tt1228705'
  AND person_id = 'nm0000375'
  AND JSON_CONTAINS(show_characters, '"Iron Man"') = 0;

UPDATE crew
SET show_characters = JSON_ARRAY_APPEND(show_characters, '$', 'Iron Man')
WHERE title_id = 'tt1300854'
  AND person_id = 'nm0000375'
  AND JSON_CONTAINS(show_characters, '"Iron Man"') = 0;