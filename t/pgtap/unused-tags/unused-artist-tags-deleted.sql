SET search_path = 'musicbrainz', 'public';

--------------------------------------------------------------------------------
BEGIN;
SELECT no_plan();

INSERT INTO artist_name (id, name) VALUES (1, 'Artist');
INSERT INTO artist (id, gid, name, sort_name)
  VALUES (1, '82ac9811-db47-4c05-9792-83cf4208afd0', 1, 1);

INSERT INTO tag (id, name) VALUES (2, 'Unused tag');
INSERT INTO artist_tag (artist, tag, count) VALUES (1, 2, 1);
DELETE FROM artist_tag;

SELECT set_eq(
  'SELECT id FROM tag', '{2}'::INT[],
  'Tag exists before commit'
);

-- Simulate the commit
SET CONSTRAINTS ALL IMMEDIATE;

SELECT set_eq(
  'SELECT id FROM tag', '{}'::INT[],
  'Tag collected after commit'
);

SELECT finish();
ROLLBACK;
