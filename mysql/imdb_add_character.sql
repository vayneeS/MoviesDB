-- Manual corrections to crew data missing from IMDB source
-- These rows are absent from title.principals.tsv and must be added explicitly.

USE IMDb;

INSERT INTO crew (title_id, person_id, category, job, show_characters)
SELECT 'tt0371746', 'nm0000375', 'actor', NULL, '["Iron Man"]'
WHERE NOT EXISTS (
    SELECT 1 FROM crew
    WHERE title_id = 'tt0371746'
    AND person_id = 'nm0000375'
    AND show_characters = '["Iron Man"]'
);