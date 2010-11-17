
\set ON_ERROR_STOP 1
BEGIN;

ALTER TABLE medium_format ADD COLUMN child_order INTEGER;
ALTER TABLE medium_format ADD COLUMN parent INTEGER;

ALTER TABLE medium_format
   ADD CONSTRAINT medium_format_fk_parent
   FOREIGN KEY (parent)
   REFERENCES medium_format(id);

INSERT INTO medium_format (id, name, year, child_order, parent) VALUES
    (29, '7"', NULL, 0, 7),
    (30, '10"', NULL, 1, 7),
    (31, '12"', NULL, 2, 7),
    (32, 'DVD-Audio', NULL, 0, 2),
    (33, 'DVD-Video', NULL, 1, 2);

COMMIT;