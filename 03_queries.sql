-- ============================================
-- Dragon Ball Legends Character Database
-- Midterm Phase - Required Queries
-- Group 37
-- ============================================

-- ============================================
-- INSERT QUERY (Required Demo)
-- Adds a new character to the database
-- ============================================

INSERT INTO Characters 
(name, type_id, rarity_id, is_ll, is_zenkai)
VALUES
('Test Character', 1, 2, FALSE, FALSE);

-- Verify insert worked
SELECT 'After INSERT' AS step, *
FROM Characters
WHERE name = 'Test Character';



-- ============================================
-- UPDATE QUERY (Required Demo)
-- Update Zenkai status
-- ============================================

UPDATE Characters
SET is_zenkai = TRUE
WHERE name = 'Test Character';

-- Verify update worked
SELECT 'After UPDATE' AS step, name, is_zenkai
FROM Characters
WHERE name = 'Test Character';



-- ============================================
-- DELETE QUERY (Required Demo)
-- Remove test character
-- ============================================

DELETE FROM Characters
WHERE name = 'Test Character';

-- Verify delete worked
SELECT 'After DELETE' AS step, *
FROM Characters
WHERE name = 'Test Character';



-- ============================================
-- SELECT QUERY #1
-- Filter characters by type
-- (Simulates dropdown filter)
-- ============================================

SELECT c.name, t.type_name
FROM Characters c
JOIN Types t
    ON c.type_id = t.type_id
WHERE t.type_name = 'RED';



-- ============================================
-- SELECT QUERY #2
-- View character stats
-- (Simulates clicking character)
-- ============================================

SELECT 
    c.name,
    s.stat_name,
    cs.stat_value
FROM Characters c
JOIN CharacterStats cs
    ON c.char_id = cs.char_id
JOIN StatTypes s
    ON cs.stat_id = s.stat_id
WHERE c.name = 'Super Vegito';

-- ============================================
-- SELECT QUERY #3
-- Filters characters by tags
-- (Simulates tag filtering)
-- ============================================

SELECT c.name, tg.tag_name
FROM Characters c
JOIN CharacterTags ct
    ON c.char_id = ct.char_id
JOIN Tags tg
    ON ct.tag_id = tg.tag_id
WHERE tg.tag_name = 'Saiyan';