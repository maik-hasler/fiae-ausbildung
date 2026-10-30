-- =========================================================
-- MMO-Referenzdatenbank
--
-- Legt alle Tabellen an und füllt sie mit Testdaten:
-- 5.000 Accounts, 15.000 Charaktere (Tabelle player), 6 Gilden.
--
-- Die Daten sehen zufällig aus, sind aber bei jedem Ausführen gleich.
-- Dafür sorgt ein einfacher Zahlengenerator (Tabelle rng) mit festem Startwert.
-- So passen die Kontrollwerte in den Aufgaben immer.
--
-- Für eine frische, leere Datenbank gedacht (z. B. sqlite:// im Arbeitsspeicher).
-- =========================================================

-- =========================
-- TABLES
-- =========================
CREATE TABLE IF NOT EXISTS account (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    created_at DATETIME NOT NULL,
    last_login DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS class (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE IF NOT EXISTS faction (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE IF NOT EXISTS player (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    account_id INTEGER NOT NULL,
    class_id INTEGER NOT NULL,
    faction_id INTEGER NOT NULL,
    username TEXT NOT NULL UNIQUE,
    gold INTEGER NOT NULL DEFAULT 0 CHECK (gold >= 0),
    FOREIGN KEY (account_id) REFERENCES account(id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES class(id),
    FOREIGN KEY (faction_id) REFERENCES faction(id)
);

CREATE TABLE IF NOT EXISTS guild (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE IF NOT EXISTS player_guild (
    player_id INTEGER NOT NULL,
    guild_id INTEGER NOT NULL,
    joined_date DATE NOT NULL,
    PRIMARY KEY (player_id, guild_id),
    FOREIGN KEY (player_id) REFERENCES player(id) ON DELETE CASCADE,
    FOREIGN KEY (guild_id) REFERENCES guild(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS guild_role (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE IF NOT EXISTS player_guild_role (
    player_id INTEGER NOT NULL,
    guild_id INTEGER NOT NULL,
    role_id INTEGER NOT NULL,
    PRIMARY KEY (player_id, guild_id),
    FOREIGN KEY (player_id, guild_id)
        REFERENCES player_guild(player_id, guild_id)
        ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES guild_role(id)
);

CREATE TABLE IF NOT EXISTS stat (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    acronym TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS player_stat (
    player_id INTEGER NOT NULL,
    stat_id INTEGER NOT NULL,
    value INTEGER NOT NULL,
    PRIMARY KEY (player_id, stat_id),
    FOREIGN KEY (player_id) REFERENCES player(id) ON DELETE CASCADE,
    FOREIGN KEY (stat_id) REFERENCES stat(id)
);

CREATE TABLE IF NOT EXISTS level (
    id INTEGER PRIMARY KEY,
    experience_required INTEGER NOT NULL UNIQUE
);

-- current_experience = Erfahrungspunkte seit Erreichen des aktuellen Levels
CREATE TABLE IF NOT EXISTS player_level (
    player_id INTEGER PRIMARY KEY,
    current_level INTEGER NOT NULL DEFAULT 1,
    current_experience INTEGER NOT NULL DEFAULT 0 CHECK (current_experience >= 0),
    FOREIGN KEY (player_id) REFERENCES player(id) ON DELETE CASCADE,
    FOREIGN KEY (current_level) REFERENCES level(id)
);

-- =========================
-- Zahlengenerator mit festem Startwert
-- =========================
CREATE TEMP TABLE rng (i INTEGER PRIMARY KEY, v INTEGER NOT NULL);

WITH RECURSIVE seq(i, s) AS (
    SELECT 1, 20260101
    UNION ALL
    SELECT i + 1, (s * 1103515245 + 12345) % 2147483648 FROM seq WHERE i < 460000
)
INSERT INTO rng (i, v)
SELECT i, s >> 16 FROM seq;  -- 0 bis 32.767 (die oberen Bits sind gleichmäßiger verteilt)

-- Bezugszeitpunkt für alle Datumswerte
CREATE TEMP TABLE base (s INTEGER NOT NULL);
INSERT INTO base (s) VALUES (CAST(strftime('%s', '2026-01-01 00:00:00') AS INTEGER));

-- =========================
-- STAMMDATEN
-- =========================
INSERT INTO guild_role (id, name, description) VALUES
(1, 'Guildwarden', 'Leader of the guild'),
(2, 'Councilor', 'Second in command, sits on the ruling council'),
(3, 'Captain', 'Senior officer overseeing members'),
(4, 'Member', 'Standard guild member'),
(5, 'Initiate', 'New member / recruit');

INSERT INTO stat (id, name, acronym) VALUES
(1, 'Health', 'HP'),
(2, 'Mana', 'MP'),
(3, 'Attack', 'ATK'),
(4, 'Defense', 'DEF'),
(5, 'Speed', 'SPD'),
(6, 'Critical Chance', 'CRIT'),
(7, 'Evasion', 'EVA'),
(8, 'Luck', 'LUCK');

INSERT INTO class (id, name, description) VALUES
(1, 'Paladin', 'Holy warrior using shield, light magic, and defensive auras.'),
(2, 'Warrior', 'Heavily armored melee fighter with strong physical damage.'),
(3, 'Knight', 'Defensive fighter focused on shields and protection skills.'),
(4, 'Dark Knight', 'Wields shadow magic and heavy weapons.'),
(5, 'Rogue', 'Stealthy melee fighter using daggers and traps.'),
(6, 'Assassin', 'High burst damage dealer with stealth abilities.'),
(7, 'Monk', 'Martial artist using fast combos and chi techniques.'),
(8, 'Berserker', 'Two-handed fighter driven by rage mechanics.'),
(9, 'Ranger', 'Ranged bow user with animal companions.'),
(10, 'Gunner', 'Uses firearms, traps, and mechanical gadgets.'),
(11, 'Mage', 'Casts elemental spells such as fire, frost, and arcane magic.'),
(12, 'Warlock', 'Uses shadow magic and summons spirits.'),
(13, 'Cleric', 'Healer focused on restoration and protection.'),
(14, 'Druid', 'Shapeshifter using nature magic and healing abilities.'),
(15, 'Bard', 'Support class using music-based buffs and magical melodies.'),
(16, 'Shaman', 'Controls the elements and uses totems for support.'),
(17, 'Templar', 'Hybrid tank-healer combining defense and light magic.'),
(18, 'Battlemage', 'Melee fighter combining combat with spellcasting.'),
(19, 'Enchanter', 'Crowd control specialist using charms and illusions.'),
(20, 'Engineer', 'Uses gadgets, bombs, and mechanical constructs.');

INSERT INTO faction (id, name, description) VALUES
(1, 'Silver Order', 'Knights and healers who protect the capital.'),
(2, 'Forest League', 'Rangers and druids who guard the great forests.'),
(3, 'Iron Guild', 'Smiths and engineers from the mountain mines.'),
(4, 'Sea Wardens', 'Sailors and traders of the southern coast.'),
(5, 'Ember Circle', 'Scholars of fire and arcane magic.'),
(6, 'Frost Watch', 'Scouts who patrol the northern border.'),
(7, 'Sky Riders', 'Messengers who travel on giant birds.'),
(8, 'Free Wanderers', 'Adventurers without a fixed home.');

INSERT INTO guild (id, name, description) VALUES
(1, 'Order of the Dawn', 'A knight order sworn to protect the realm.'),
(2, 'Silent Daggers', 'A secretive guild of rogues and scouts.'),
(3, 'Arcane Concord', 'A circle of mages dedicated to studying magic.'),
(4, 'Iron Vanguard', 'A battle-hardened guild known for its fearless warriors.'),
(5, 'Emerald Circle', 'A guild protecting nature and ancient forests.'),
(6, 'Storm Riders', 'A loose alliance of shamans and travellers from the north.');

INSERT INTO level (id, experience_required) VALUES
(1, 0),
(2, 100),
(3, 300),
(4, 600),
(5, 1000);

-- =========================
-- ACCOUNT
-- =========================
-- Zeitpunkte liegen bis zu 5 Jahre (Anlage) bzw. 180 Tage (letzter Login)
-- vor dem 01.01.2026. Der letzte Login liegt nie vor der Anlage.
WITH a AS (
    SELECT n.i AS id,
           (SELECT v FROM rng WHERE i = n.i) * 32768 + (SELECT v FROM rng WHERE i = 5000 + n.i) AS r_created,
           (SELECT v FROM rng WHERE i = 10000 + n.i) AS r_login,
           (SELECT v FROM rng WHERE i = 15000 + n.i) AS r_hash
    FROM rng n
    WHERE n.i <= 5000
), b AS (
    SELECT id, r_login, r_hash,
           (SELECT s FROM base) - r_created % (5 * 365 * 86400) AS created_s
    FROM a
)
INSERT INTO account (id, email, password_hash, created_at, last_login)
SELECT
    id,
    'player' || id || '@example.com',
    -- Platzhalter, kein echter Hash
    'demo_' || printf('%04x', r_hash),
    datetime(created_s, 'unixepoch'),
    datetime((SELECT s FROM base) - (r_login * 475) % MIN(180 * 86400, (SELECT s FROM base) - created_s + 1), 'unixepoch')
FROM b;

-- =========================
-- PLAYER
-- =========================
CREATE TEMP TABLE first_names (name TEXT);
INSERT INTO first_names (name) VALUES
('Aldric'),('Beorn'),('Cuthbert'),('Godric'),('Hereward'),('Leofric'),('Osric'),('Wynstan'),
('Ivar'),('Torvald'),('Sigurd'),('Ragnar'),('Bjorn'),('Hakon'),('Eirik'),('Ulfr'),
('Aedan'),('Cian'),('Fionn'),('Niall'),('Taran'),('Ronan'),('Oisin'),('Bran'),
('Roderick'),('Baldric'),('Cedric'),('Theobald'),('Gerhardt'),('Berengar'),
('Cassian'),('Lucian'),('Octavian'),('Hadrian'),('Marcellus'),('Dorian'),
('Tiberius'),('Alaric'),('Wulfram'),('Siegfried');

CREATE TEMP TABLE last_names (name TEXT);
INSERT INTO last_names (name) VALUES
('Ashwood'),('Ironshield'),('Stormcloak'),('Ravenspear'),('Oakenshield'),
('Wolfborn'),('Stonehelm'),('Hawkridge'),('Frostward'),('Firebrand'),
('Silverkeep'),('Deepwater'),('Drakebane'),('Stormwatch'),('Redwyne'),
('Longspear'),('Wintermere'),('Mistwater'),('Falconcrest'),('Grimward'),
('Mossmoor'),('Ravencrest'),('Thornfield'),('Brightmore'),('Highridge');

CREATE TEMP TABLE epithets (epithet TEXT);
INSERT INTO epithets (epithet) VALUES
('the Bold'),('the Cunning'),('the Elder'),('the Younger'),('the Fearless'),
('the Wise'),('the Wanderer'),('the Vigilant'),('the Ironhand'),('the Stormborn'),
('of Stormhold'),('of Wolfswood'),('of Dragonspire'),('of Highcrest'),
('of Winterhall'),('of the North'),('of Westvale'),('of the Lowlands'),
('the Just'),('the Swift'),('the Brave'),('the Patient'),('the Lucky'),('the Quiet'),
('the Dragonslayer');

-- Accounts mit durch 20 teilbarer ID bekommen keinen Charakter (250 Accounts).
-- Die ersten 4.750 Charaktere gehen der Reihe nach an die übrigen Accounts,
-- die restlichen 10.250 werden verteilt.
WITH p AS (
    SELECT n.i AS id, 20000 + (n.i - 1) * 8 AS o
    FROM rng n
    WHERE n.i <= 15000
), r AS (
    SELECT id,
           CASE WHEN id <= 4750 THEN id ELSE (SELECT v FROM rng WHERE i = o) % 4750 + 1 END AS nth,
           (SELECT v FROM rng WHERE i = o + 1) AS r_first,
           (SELECT v FROM rng WHERE i = o + 2) AS r_last,
           (SELECT v FROM rng WHERE i = o + 3) AS r_epithet,
           (SELECT v FROM rng WHERE i = o + 4) AS r_broke,
           (SELECT v FROM rng WHERE i = o + 5) AS r_gold,
           (SELECT v FROM rng WHERE i = o + 6) AS r_class,
           (SELECT v FROM rng WHERE i = o + 7) AS r_faction
    FROM p
)
INSERT INTO player (id, account_id, username, gold, class_id, faction_id)
SELECT
    id,
    nth + (nth - 1) / 19 AS account_id,
    LOWER(REPLACE(
        (SELECT name FROM first_names WHERE rowid = r_first % (SELECT COUNT(*) FROM first_names) + 1) || '_' ||
        (SELECT name FROM last_names WHERE rowid = r_last % (SELECT COUNT(*) FROM last_names) + 1) || '_' ||
        (SELECT epithet FROM epithets WHERE rowid = r_epithet % (SELECT COUNT(*) FROM epithets) + 1) || '_' ||
        id,
        ' ', '_'
    )) AS username,
    CASE WHEN r_broke % 50 = 0 THEN 0 ELSE r_gold % 9001 + 100 END AS gold,  -- 2 % ohne Gold, sonst 100 bis 9.100
    r_class % 20 + 1 AS class_id,
    r_faction % 8 + 1 AS faction_id
FROM r;

-- =========================
-- PLAYER_GUILD
-- =========================
-- Etwa 70 % der Charaktere sind in einer Gilde, etwa 5 % zusätzlich in einer zweiten.
WITH g AS (
    SELECT id AS player_id, 171000 + (id - 1) * 4 AS o FROM player
), r AS (
    SELECT player_id,
           (SELECT v FROM rng WHERE i = o) AS r_member,
           (SELECT v FROM rng WHERE i = o + 1) AS r_guild,
           (SELECT v FROM rng WHERE i = o + 2) AS r_date,
           (SELECT v FROM rng WHERE i = o + 3) AS r_second
    FROM g
)
INSERT INTO player_guild (player_id, guild_id, joined_date)
SELECT player_id,
       r_guild % 6 + 1,
       date((SELECT s FROM base) - (r_date * 963) % (365 * 86400), 'unixepoch')
FROM r
WHERE r_member % 100 < 70
UNION ALL
SELECT player_id,
       (r_guild % 6 + 1 + r_second % 5) % 6 + 1,  -- immer eine andere Gilde als die erste
       date((SELECT s FROM base) - (r_second * 963) % (365 * 86400), 'unixepoch')
FROM r
WHERE r_member % 100 < 5;

-- =========================
-- PLAYER_GUILD_ROLE
-- =========================
-- Das dienstälteste Mitglied jeder Gilde wird Guildwarden.
INSERT INTO player_guild_role (player_id, guild_id, role_id)
SELECT player_id, guild_id, 1
FROM (
    SELECT player_id,
           guild_id,
           ROW_NUMBER() OVER (PARTITION BY guild_id ORDER BY joined_date, player_id) AS rn
    FROM player_guild
)
WHERE rn = 1;

-- Alle anderen Mitglieder bekommen eine der Rollen 2 bis 5.
INSERT INTO player_guild_role (player_id, guild_id, role_id)
SELECT pg.player_id,
       pg.guild_id,
       (SELECT v FROM rng WHERE i = 360000 + pg.player_id * 6 + pg.guild_id) % 4 + 2
FROM player_guild pg
LEFT JOIN player_guild_role pgr
       ON pgr.player_id = pg.player_id
      AND pgr.guild_id = pg.guild_id
WHERE pgr.player_id IS NULL;

-- =========================
-- PLAYER_STAT
-- =========================
INSERT INTO player_stat (player_id, stat_id, value)
SELECT
    p.id,
    s.id,
    CASE s.id
        WHEN 1 THEN r.v % 51 + 100  -- Health: 100-150
        WHEN 2 THEN r.v % 71 + 50   -- Mana: 50-120
        WHEN 3 THEN r.v % 13 + 25   -- Attack: 25-37
        WHEN 4 THEN r.v % 12 + 15   -- Defense: 15-26
        WHEN 5 THEN r.v % 11 + 10   -- Speed: 10-20
        WHEN 6 THEN r.v % 7 + 4     -- Critical Chance: 4-10
        WHEN 7 THEN r.v % 6 + 8     -- Evasion: 8-13
        WHEN 8 THEN r.v % 5 + 5     -- Luck: 5-9
    END
FROM player p
CROSS JOIN stat s
JOIN rng r ON r.i = 231000 + (p.id - 1) * 8 + s.id;

-- =========================
-- PLAYER_LEVEL
-- =========================
-- current_experience liegt immer unter dem, was bis zum nächsten Level fehlt.
WITH r AS (
    SELECT id AS player_id,
           (SELECT v FROM rng WHERE i = 140000 + (id - 1) * 2) % 5 + 1 AS lvl,
           (SELECT v FROM rng WHERE i = 140001 + (id - 1) * 2) AS r_exp
    FROM player
)
INSERT INTO player_level (player_id, current_level, current_experience)
SELECT player_id,
       lvl,
       r_exp % CASE lvl WHEN 1 THEN 100 WHEN 2 THEN 200 WHEN 3 THEN 300 WHEN 4 THEN 400 ELSE 500 END
FROM r;

DROP TABLE temp.rng;
DROP TABLE temp.base;
DROP TABLE temp.first_names;
DROP TABLE temp.last_names;
DROP TABLE temp.epithets;
