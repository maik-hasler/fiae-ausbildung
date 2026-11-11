-- =========================================================
-- Prototyp: die Gildenliste des Spielestudios
--
-- Bevor es eine richtige Datenbank gab, hat das Studio alles in EINER
-- Tabelle gepflegt, so wie man es aus Excel kennt:
-- eine Zeile pro Gildenmitgliedschaft.
--
-- Die Daten enthalten absichtlich ein paar Fehler. Die findet ihr im Notebook.
-- Das Skript löscht die Tabelle vorher, ihr könnt es also beliebig oft ausführen.
-- =========================================================

DROP TABLE IF EXISTS gildenliste;

CREATE TABLE gildenliste (
    email               TEXT NOT NULL,
    username            TEXT NOT NULL,
    klasse              TEXT NOT NULL,
    klasse_beschreibung TEXT NOT NULL,
    ausruestung         TEXT NOT NULL,
    gilde               TEXT NOT NULL,
    gilde_beschreibung  TEXT NOT NULL,
    rolle               TEXT NOT NULL,
    beigetreten         DATE NOT NULL,
    PRIMARY KEY (username, gilde)
);

INSERT INTO gildenliste VALUES
('mira@example.org',   'mira',   'Paladin',  'Heiliger Krieger mit Schild und Heilmagie.', 'Schwert, Schild',             'Ember Fangs',    'Feuer und Flamme für jeden Raid.', 'Guildwarden', '2025-01-10'),
('thorin@example.org', 'thorin', 'Warrior',  'Robuster Nahkämpfer.',                       'Axt, Schild',                 'Ember Fangs',    'Feuer und Flamme für jeden Raid.', 'Councilor',   '2025-02-01'),
('juna@example.org',   'juna',   'Assassin', 'Schnell, leise, kritische Treffer.',         'Wurfmesser, Dolch, Heiltrank'  , 'Ember Fangs',  'Feuer und Flamme für jeden Raid.', 'Member',      '2025-03-15'),
('lia@example.org',    'lia',    'Ranger',   'Fernkampf mit Pfeil und Bogen.',             'Bogen, Heiltrank, Heiltrank', 'Ember Fangs',    'Feuer und Flamme für jeden Raid.', 'Member',      '2025-04-02'),
('thorin@example.org', 'ivo',    'Warrior',  'Robuster Nahkämpfer.',                       'Axt, Schwertscheide',         'Ember Fangs',    'Feuer und Flamme für jeden Raid.', 'Initiate',    '2025-06-20'),
('tarek@example.org',  'tarek',  'Paladin',  'Heiliger Krieger mit Schild und Heilmagie.', 'Streitkolben, Schild',        'Ember Fangs',    'Feuer und Flamme für jeden Raid.', 'Member',      '2025-05-05'),

('finn@example.org',   'finn',   'Paladin',  'Heiliger Krieger mit Schild und Heilmagie.', 'Schwert',                     'Silver Shields', 'Wir beschützen die Schwachen.',    'Guildwarden', '2025-01-05'),
('mira@exmaple.org',   'mira',   'Paladin',  'Heiliger Krieger mit Schild und Heilmagie.', 'Schwert, Schild',             'Silver Shields', 'Wir beschützen die Schwachen.',    'Captain',     '2025-02-11'),
('ole@example.org',    'ole',    'Mage',     'Zaubert aus sicherer Entfernung.',           'Stab',                        'Silver Shields', 'Wir beschützen die Schwachen.',    'Member',      '2025-03-03'),
('sora@example.org',   'sora',   'Ranger',   'Fernkampf mit Pfeil und Bogen.',             'Bogen',                       'Silver Shields', 'Wir beschützen die Schwachen!',    'Member',      '2025-03-20'),
('nele@example.org',   'nele',   'Assassin', 'Schnell, leise, kritische Treffer.',         'Dolch, Dolch',                'Silver Shields', 'Wir beschützen die Schwachen.',    'Initiate',    '2025-07-01'),
('mira@example.org',   'bo',     'Warrior',  'Robuster Nahkämpfer.',                       'Axt',                         'Silver Shields', 'Wir beschützen die Schwachen.',    'Member',      '2025-04-14'),

('thorin@example.org', 'thorin', 'Warrior',  'Robuster Nahkämpfer.',                       'Axt, Schild',                 'Iron Wolves',    'Gemeinsam stark, allein gefährlich.', 'Guildwarden', '2025-01-20'),
('thorin@example.org', 'ivo',    'Warrior',  'Robuster Nahkämpfer.',                       'Axt, Schwertscheide',         'Iron Wolves',    'Gemeinsam stark, allein gefährlich.', 'Member',      '2025-02-22'),
('lia@example.org',    'lia',    'Ranger',   'Fernkampf mit Pfeil und Bogen.',             'Bogen,Heiltrank,Heiltrank',   'Iron Wolves',    'Gemeinsam stark, allein gefährlich.', 'Captain',     '2025-05-17'),
('tarek@example.org',  'tarek',  'Paladin',  'Heiliger Krieger mit Schild.',               'Streitkolben, Schild',        'Iron Wolves',    'Gemeinsam stark, allein gefährlich.', 'Councilor',   '2025-03-30'),
('ole@example.org',    'ole',    'mage',     'Zaubert aus sicherer Entfernung.',           'Stab',                        'Iron Wolves',    'Gemeinsam stark, allein gefährlich.', 'Initiate',    '2025-08-08'),
('juna@example.org',   'juna',   'Assassin', 'Schnell, leise, kritische Treffer.',         'Wurfmesser, Dolch',           'Iron Wolves',    'Gemeinsam stark, allein gefährlich.', 'Member',      '2025-06-06'),

('kim@example.org',    'kim',    'Mage',     'Zaubert aus sicherer Entfernung.',           'Stab, Heiltrank',             'Quiet Ravens',   'Leise, aber gründlich.',           'Guildwarden', '2025-02-14');
