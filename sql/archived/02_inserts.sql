-- ============================================
-- Dragon Ball Legends Character Database
-- Midterm Phase - Sample Data Inserts
-- Group 37
-- ============================================

-- ============================================
-- INSERT TYPES
-- ============================================

INSERT INTO Types (type_name) VALUES
('RED'),
('BLU'),
('GRN'),
('YEL'),
('PUR'),
('LGT'),
('DRK');

-- ============================================
-- INSERT RARITIES
-- ============================================

INSERT INTO Rarities (rarity_name) VALUES
('ULTRA'),
('SPARKING'),
('EXTREME'),
('HERO');

-- ============================================
-- INSERT TAGS
-- ============================================

INSERT INTO Tags (tag_name) VALUES
('Saiyan'),
('Son Family'),
('Vegeta Clan'),
('Super Warrior'),
('Regeneration'),
('Fusion Warrior'),
('God Ki'),
('Namekian'),
('Hybrid Saiyan'),
('Future');

-- ============================================
-- INSERT STAT TYPES
-- ============================================

INSERT INTO StatTypes (stat_name) VALUES
('HP'),
('Strike ATK'),
('Blast ATK'),
('Strike DEF'),
('Blast DEF');

-- ============================================
-- INSERT CHARACTERS
-- ============================================

INSERT INTO Characters (name, type_id, rarity_id, is_ll, is_zenkai) VALUES
('Fused with Kami Piccolo', 1, 2, FALSE, FALSE),
('Super Vegito', 5, 1, TRUE, TRUE),
('Super Saiyan Goku', 2, 2, FALSE, FALSE),
('Vegeta Blue', 3, 2, FALSE, FALSE),
('Ultimate Gohan', 4, 2, FALSE, FALSE),
('Future Trunks', 2, 2, FALSE, TRUE);

-- ============================================
-- INSERT CHARACTER TAGS
-- ============================================

-- Fused with Kami Piccolo
INSERT INTO CharacterTags (char_id, tag_id) VALUES
(1, 4), -- Super Warrior
(1, 5), -- Regeneration
(1, 8); -- Namekian

-- Super Vegito
INSERT INTO CharacterTags (char_id, tag_id) VALUES
(2, 1), -- Saiyan
(2, 3), -- Vegeta Clan
(2, 6); -- Fusion Warrior

-- Super Saiyan Goku
INSERT INTO CharacterTags (char_id, tag_id) VALUES
(3, 1), -- Saiyan
(3, 2); -- Son Family

-- Vegeta Blue
INSERT INTO CharacterTags (char_id, tag_id) VALUES
(4, 1), -- Saiyan
(4, 3), -- Vegeta Clan
(4, 7); -- God Ki

-- Ultimate Gohan
INSERT INTO CharacterTags (char_id, tag_id) VALUES
(5, 2), -- Son Family
(5, 9); -- Hybrid Saiyan

-- Future Trunks
INSERT INTO CharacterTags (char_id, tag_id) VALUES
(6, 3),  -- Vegeta Clan
(6, 9),  -- Hybrid Saiyan
(6, 10); -- Future

-- ============================================
-- INSERT CHARACTER STATS
-- stat_id mapping:
-- 1 = HP
-- 2 = Strike ATK
-- 3 = Blast ATK
-- 4 = Strike DEF
-- 5 = Blast DEF
-- ============================================

-- Fused with Kami Piccolo
INSERT INTO CharacterStats (char_id, stat_id, stat_value) VALUES
(1, 1, 26572),
(1, 2, 2620),
(1, 3, 2756),
(1, 4, 1788),
(1, 5, 1754);

-- Super Vegito
INSERT INTO CharacterStats (char_id, stat_id, stat_value) VALUES
(2, 1, 27890),
(2, 2, 2890),
(2, 3, 2500),
(2, 4, 1805),
(2, 5, 1760);

-- Super Saiyan Goku
INSERT INTO CharacterStats (char_id, stat_id, stat_value) VALUES
(3, 1, 25100),
(3, 2, 2435),
(3, 3, 2310),
(3, 4, 1700),
(3, 5, 1680);

-- Vegeta Blue
INSERT INTO CharacterStats (char_id, stat_id, stat_value) VALUES
(4, 1, 25980),
(4, 2, 2480),
(4, 3, 2660),
(4, 4, 1715),
(4, 5, 1695);

-- Ultimate Gohan
INSERT INTO CharacterStats (char_id, stat_id, stat_value) VALUES
(5, 1, 27050),
(5, 2, 2550),
(5, 3, 2410),
(5, 4, 1820),
(5, 5, 1800);

-- Future Trunks
INSERT INTO CharacterStats (char_id, stat_id, stat_value) VALUES
(6, 1, 26240),
(6, 2, 2470),
(6, 3, 2385),
(6, 4, 1765),
(6, 5, 1740);