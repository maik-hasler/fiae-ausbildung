# Grundlagen: Datenbanken und SQL

Diese Seite erklärt die Begriffe, die ihr für alle SQL-Aufgaben braucht. Zum Ausprobieren gibt es das Notebook [einstieg.ipynb](einstieg.ipynb).

## Tabellen

Eine relationale Datenbank speichert Daten in **Tabellen**.

| id | titel | erscheinungsjahr | autor_id |
|----|-------|------------------|----------|
| 1 | Der leise Hafen | 2015 | 1 |
| 2 | Nebel über Kerrin | 2018 | 1 |
| 3 | Das Uhrwerk | 2020 | 2 |

| Begriff | Bedeutung | Im Beispiel |
|---------|-----------|-------------|
| **Tabelle** | Sammlung gleichartiger Daten | `buch` |
| **Zeile** (Datensatz) | ein einzelnes Objekt | das Buch „Das Uhrwerk“ |
| **Spalte** (Attribut) | eine Eigenschaft, die jede Zeile hat | `titel` |
| **Datentyp** | welche Art von Wert in einer Spalte steht | `INTEGER` (Ganzzahl), `TEXT`, `DATE` |
| **NULL** | „kein Wert vorhanden“, nicht dasselbe wie 0 oder leerer Text | Rückgabedatum einer laufenden Ausleihe |

## Schlüssel

- Der **Primärschlüssel** (`PRIMARY KEY`) macht jede Zeile eindeutig. Meist ist das eine Spalte `id`. Zwei Zeilen dürfen nie denselben Primärschlüssel haben.
- Ein **Fremdschlüssel** (`FOREIGN KEY`) verweist auf den Primärschlüssel einer anderen Tabelle. Im Beispiel zeigt `buch.autor_id` auf `autor.id`. Die Datenbank kann dann verhindern, dass ein Buch auf einen Autor verweist, den es nicht gibt.
- Ein **zusammengesetzter Primärschlüssel** besteht aus mehreren Spalten, z. B. `(buch_id, schlagwort_id)`. Erst die Kombination muss eindeutig sein.

## Constraints (Regeln)

Mit Constraints sichert die Datenbank selbst ab, dass nur gültige Daten hineinkommen:

| Constraint | Bedeutung |
|------------|-----------|
| `NOT NULL` | Die Spalte darf nicht leer bleiben. |
| `UNIQUE` | Jeder Wert darf in der Spalte nur einmal vorkommen. |
| `DEFAULT 0` | Wird beim Einfügen nichts angegeben, steht 0 drin. |
| `CHECK (seiten > 0)` | Der Wert muss die Bedingung erfüllen. |
| `ON DELETE CASCADE` | Wird die Zeile gelöscht, auf die verwiesen wird, werden die verweisenden Zeilen mitgelöscht. |

## ER-Modell

Bevor man Tabellen anlegt, plant man mit einem **Entity-Relationship-Modell** (ER-Modell):

- **Entität:** ein „Ding“, über das man Daten speichert, z. B. Autor, Buch.
- **Attribut:** eine Eigenschaft einer Entität, z. B. Titel, Erscheinungsjahr.
- **Beziehung:** wie Entitäten zusammenhängen, z. B. „Autor schreibt Buch“.

Die **Kardinalität** sagt, wie viele Objekte an einer Beziehung beteiligt sind:

| Kardinalität | Beispiel | Umsetzung in Tabellen |
|--------------|----------|-----------------------|
| **1:1** | Ein Mitglied hat genau einen Ausweis. | Fremdschlüssel mit `UNIQUE` oder alles in eine Tabelle |
| **1:n** | Ein Autor schreibt viele Bücher, ein Buch hat einen Autor. | Fremdschlüssel auf der „n“-Seite (`buch.autor_id`) |
| **n:m** | Ein Buch hat viele Schlagwörter, ein Schlagwort gehört zu vielen Büchern. | eigene **Zwischentabelle** `buch_schlagwort (buch_id, schlagwort_id)` |

Dazu kommt, ob eine Beziehung **optional** ist: Muss ein Autor mindestens ein Buch haben, oder darf er auch keins haben?

## Normalisierung

Normalisierung vermeidet, dass Daten doppelt gespeichert werden. Doppelte Daten führen zu Widersprüchen, wenn man sie nur an einer Stelle ändert.

**1. Normalform:** Jede Zelle enthält genau einen Wert.

| ❌ falsch | ✅ richtig |
|-----------|-----------|
| `schlagwoerter = 'Krimi, Küste, Nebel'` | eigene Tabelle `buch_schlagwort` mit einer Zeile pro Schlagwort |

**2. Normalform:** 1. Normalform, und bei einem zusammengesetzten Schlüssel hängt jede Spalte vom **ganzen** Schlüssel ab.

> In `buch_schlagwort (buch_id, schlagwort_id, buchtitel)` hängt `buchtitel` nur von `buch_id` ab. Der Titel gehört in die Tabelle `buch`.

**3. Normalform:** 2. Normalform, und keine Spalte hängt von einer anderen Spalte ab, die kein Schlüssel ist.

> In `buch (id, titel, autor_id, autor_name)` hängt `autor_name` von `autor_id` ab, nicht vom Buch. Der Name gehört in die Tabelle `autor`.

Faustregel: **Jede Information steht an genau einer Stelle.**

## SQL auf einen Blick

| Befehl | Wofür | Beispiel |
|--------|-------|----------|
| `CREATE TABLE` | Tabelle anlegen | `CREATE TABLE autor (id INTEGER PRIMARY KEY, name TEXT NOT NULL);` |
| `INSERT INTO` | Zeilen einfügen | `INSERT INTO autor (name) VALUES ('Mara Lind');` |
| `SELECT` | Daten abfragen | `SELECT titel FROM buch WHERE erscheinungsjahr > 2015;` |
| `UPDATE` | Zeilen ändern | `UPDATE buch SET seiten = 320 WHERE id = 3;` |
| `DELETE` | Zeilen löschen | `DELETE FROM ausleihe WHERE id = 7;` |
| `DROP TABLE` | Tabelle löschen | `DROP TABLE IF EXISTS autor;` |

Reihenfolge der Teile einer Abfrage:

```sql
SELECT    spalten
FROM      tabelle
JOIN      andere_tabelle ON bedingung
WHERE     bedingung für Zeilen
GROUP BY  spalten
HAVING    bedingung für Gruppen
ORDER BY  spalten
LIMIT     anzahl;
```

## Jupyter-Notebooks mit SQL

- Eine Zelle, die mit `%%sql` beginnt, wird komplett als SQL ausgeführt. `%%sql` muss in der **ersten Zeile** stehen.
- Eine Zeile mit `%sql ...` führt nur diese eine Zeile als SQL aus.
- Neue Zelle: mit der Maus zwischen zwei Zellen fahren und **+ Code** (für SQL) oder **+ Markdown** (für Text) klicken.
- **Ausführen:** `Strg + Enter` (Zelle) oder `Umschalt + Enter` (Zelle und weiter zur nächsten).
- **Kernel neu starten:** Schaltfläche **Restart** oben im Notebook. Danach ist alles vergessen, was nur im Arbeitsspeicher war.
- Eine rote Fehlermeldung heißt nur, dass **diese Zelle** nicht geklappt hat. Lest die letzte Zeile der Meldung, dort steht meist der Grund.

## Zum Weiterlesen

| Thema | Link |
|-------|------|
| SQL interaktiv üben (Englisch) | https://sqlbolt.com |
| Normalisierung (Wikipedia) | https://de.wikipedia.org/wiki/Normalisierung_%28Datenbank%29 |
| Entity-Relationship-Modell (Wikipedia) | https://de.wikipedia.org/wiki/Entity-Relationship-Modell |
| SQLite-Dokumentation (Englisch) | https://www.sqlite.org/lang.html |
