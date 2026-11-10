-- =========================================================
-- Migration: Name eures Features
-- Team: ...
--
-- Was diese Migration macht:
--   - ...
--
-- Wird im Notebook auf eine frische Kopie der Referenzdatenbank angewendet.
-- Alles steht in EINER Transaktion: Geht etwas schief, bleibt die
-- Datenbank unverändert.
-- =========================================================

BEGIN;

-- Neue Tabellen
-- (Beispiel, bitte durch eure eigenen ersetzen)
--
-- CREATE TABLE beispiel (
--     id        INTEGER PRIMARY KEY AUTOINCREMENT,
--     player_id INTEGER NOT NULL,
--     ...
--     FOREIGN KEY (player_id) REFERENCES player(id) ON DELETE CASCADE
-- );


-- Änderungen an bestehenden Tabellen (ALTER TABLE ...)


-- Werkzeuge aus Teil 4 (Index, View, Trigger, ...)


COMMIT;
