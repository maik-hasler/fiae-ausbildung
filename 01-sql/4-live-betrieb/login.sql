-- =========================================================
-- Login-Historie für Teil 4
--
-- Ergänzt die Referenzdatenbank um eine Tabelle mit 500.000 Logins.
-- Erst bei so vielen Zeilen merkt man, was ein Index bringt.
--
-- Die Daten sind bei jedem Ausführen gleich.
-- =========================================================

CREATE TABLE IF NOT EXISTS login (
    id         INTEGER PRIMARY KEY,
    account_id INTEGER NOT NULL,
    zeitpunkt  DATETIME NOT NULL,
    ip         TEXT NOT NULL,
    FOREIGN KEY (account_id) REFERENCES account(id)
);

-- Zahlen 1 bis 500.000 erzeugen und daraus Logins bauen
WITH RECURSIVE zahl(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM zahl WHERE n < 500000
)
INSERT INTO login (account_id, zeitpunkt, ip)
SELECT
    (n * 7919) % 5000 + 1,
    datetime('2025-01-01', '+' || (n % 300) || ' days', '+' || (n * 37 % 86400) || ' seconds'),
    '10.' || (n % 7) || '.' || (n % 256) || '.' || (n % 251)
FROM zahl;
