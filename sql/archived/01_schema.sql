-- ============================================
-- Dragon Ball Legends Character Database
-- Midterm Phase - Schema Setup
-- Group 37
-- ============================================

-- ============================================
-- DROP TABLES
-- ============================================

DROP TABLE IF EXISTS CharacterStats CASCADE;
DROP TABLE IF EXISTS CharacterTags CASCADE;
DROP TABLE IF EXISTS Characters CASCADE;
DROP TABLE IF EXISTS StatTypes CASCADE;
DROP TABLE IF EXISTS Tags CASCADE;
DROP TABLE IF EXISTS Rarities CASCADE;
DROP TABLE IF EXISTS Types CASCADE;

-- ============================================
-- LOOKUP TABLES
-- ============================================

CREATE TABLE Types (
    type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE Rarities (
    rarity_id SERIAL PRIMARY KEY,
    rarity_name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Tags (
    tag_id SERIAL PRIMARY KEY,
    tag_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE StatTypes (
    stat_id SERIAL PRIMARY KEY,
    stat_name VARCHAR(50) NOT NULL UNIQUE
);

-- ============================================
-- MAIN ENTITY TABLE
-- ============================================

CREATE TABLE Characters (
    char_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    type_id INT NOT NULL,
    rarity_id INT NOT NULL,
    is_ll BOOLEAN NOT NULL DEFAULT FALSE,
    is_zenkai BOOLEAN NOT NULL DEFAULT FALSE,

    CONSTRAINT fk_characters_type
        FOREIGN KEY (type_id)
        REFERENCES Types(type_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_characters_rarity
        FOREIGN KEY (rarity_id)
        REFERENCES Rarities(rarity_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- ============================================
-- MANY-TO-MANY: CHARACTERS <-> TAGS
-- ============================================

CREATE TABLE CharacterTags (
    char_id INT NOT NULL,
    tag_id INT NOT NULL,

    PRIMARY KEY (char_id, tag_id),

    CONSTRAINT fk_charactertags_character
        FOREIGN KEY (char_id)
        REFERENCES Characters(char_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_charactertags_tag
        FOREIGN KEY (tag_id)
        REFERENCES Tags(tag_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ============================================
-- MANY-TO-MANY WITH ATTRIBUTE:
-- CHARACTERS <-> STATTYPES, with value
-- ============================================

CREATE TABLE CharacterStats (
    char_id INT NOT NULL,
    stat_id INT NOT NULL,
    stat_value NUMERIC(10,2) NOT NULL CHECK (stat_value >= 0),

    PRIMARY KEY (char_id, stat_id),

    CONSTRAINT fk_characterstats_character
        FOREIGN KEY (char_id)
        REFERENCES Characters(char_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_characterstats_stattype
        FOREIGN KEY (stat_id)
        REFERENCES StatTypes(stat_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ============================================
-- OPTIONAL INDEXES FOR FILTERING
-- ============================================

CREATE INDEX idx_characters_type_id ON Characters(type_id);
CREATE INDEX idx_characters_rarity_id ON Characters(rarity_id);
CREATE INDEX idx_characters_is_ll ON Characters(is_ll);
CREATE INDEX idx_characters_is_zenkai ON Characters(is_zenkai);
CREATE INDEX idx_charactertags_tag_id ON CharacterTags(tag_id);
CREATE INDEX idx_characterstats_stat_id ON CharacterStats(stat_id);