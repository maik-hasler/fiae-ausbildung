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

## Notationen für ER-Diagramme

Dasselbe Modell lässt sich unterschiedlich zeichnen. In der Abschlussprüfung kommen mehrere Schreibweisen vor. Beispiel: Ein Autor schreibt beliebig viele Bücher (auch keins), jedes Buch hat genau einen Autor.

| Notation | So sieht es aus | Wo steht die Angabe für „viele Bücher“? |
|----------|-----------------|------------------------------------------|
| **Chen** | Rechteck = Entität, Raute = Beziehung, Ellipse = Attribut. An die Linien schreibt man `1`, `n` oder `m`: `Autor —1— ◇schreibt◇ —n— Buch` | beim **Buch** |
| **(min,max)** | wie Chen, aber mit Zahlenpaaren: `Autor —(0,n)— ◇schreibt◇ —(1,1)— Buch` | beim **Autor**: „Ein Autor nimmt 0- bis n-mal an *schreibt* teil.“ |
| **Krähenfuß** (wie Mermaid) | `AUTOR \|\|--o{ BUCH`: der „Krähenfuß“ `{` bedeutet viele | beim **Buch** |

Achtung, Falle: Bei der (min,max)-Notation steht die Angabe auf der **anderen** Seite als bei Chen und Krähenfuß. Sie sagt, wie oft **diese** Entität an der Beziehung teilnimmt.

## Normalisierung

Normalisierung vermeidet, dass Daten doppelt gespeichert werden. Doppelte Daten (**Redundanz**) führen zu Widersprüchen (**Inkonsistenz**), wenn man sie nur an einer Stelle ändert. Wie sich das anfühlt, erlebt ihr in [Teil 1](../1-normalisierung/Anforderungen.md).

**Anomalien** sind die typischen Probleme einer nicht normalisierten Tabelle:

| Anomalie | Problem | Beispiel aus Teil 1 |
|----------|---------|---------------------|
| **Änderungsanomalie** | Eine Information steht mehrfach. Wird nicht jede Stelle geändert, widersprechen sich die Daten. | Gildenbeschreibung nur in einer von sechs Zeilen geändert |
| **Einfügeanomalie** | Etwas lässt sich nicht speichern, weil eine andere Information fehlt. | Gilde ohne Mitglied kann nicht angelegt werden |
| **Löschanomalie** | Beim Löschen geht ungewollt weitere Information verloren. | letzte Mitgliedschaft gelöscht, damit ist auch die Gilde weg |

**Funktionale Abhängigkeit:** B hängt funktional von A ab (A → B), wenn zu jedem Wert von A genau ein Wert von B gehört. Beispiel: `autor_id → autor_name`.

**1. Normalform:** Jede Zelle enthält genau einen Wert.

| ❌ falsch | ✅ richtig |
|-----------|-----------|
| `schlagwoerter = 'Krimi, Küste, Nebel'` | eigene Tabelle `buch_schlagwort` mit einer Zeile pro Schlagwort |

**2. Normalform:** 1. Normalform, und jede Nicht-Schlüssel-Spalte hängt vom **ganzen** Schlüssel ab, nicht nur von einem Teil davon. Das betrifft jeden Schlüssel aus mehreren Spalten, auch wenn die Tabelle zusätzlich eine `id` hat.

> In `buch_schlagwort (buch_id, schlagwort_id, buchtitel)` hängt `buchtitel` nur von `buch_id` ab. Der Titel gehört in die Tabelle `buch`.

**3. Normalform:** 2. Normalform, und keine Nicht-Schlüssel-Spalte hängt von einer anderen Nicht-Schlüssel-Spalte ab.

> In `buch (id, titel, autor_id, autor_name)` hängt `autor_name` von `autor_id` ab, nicht vom Buch. Der Name gehört in die Tabelle `autor`.

Faustregel: **Jede Information steht an genau einer Stelle.** Oder als Merksatz: Jede Nicht-Schlüssel-Spalte hängt ab vom Schlüssel (1NF), vom ganzen Schlüssel (2NF) und von nichts anderem als dem Schlüssel (3NF).

**Schlüsselarten:** Ein **natürlicher Schlüssel** besteht aus fachlichen Daten, z. B. ein Benutzername. Ein **Surrogatschlüssel** (künstlicher Schlüssel) wie `id` hat keine fachliche Bedeutung und muss sich deshalb nie ändern.

**Denormalisierung:** bewusst redundant speichern, z. B. für schnellere Abfragen. Das macht man nur mit gutem Grund und mit einem Plan, wie die Kopie aktuell bleibt.

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

Die SQL-Befehle teilt man in Gruppen ein:

| Gruppe | Wofür | Befehle |
|--------|-------|---------|
| **DDL** (Data Definition Language) | Struktur anlegen und ändern | `CREATE`, `ALTER`, `DROP` |
| **DML** (Data Manipulation Language) | Daten ändern | `INSERT`, `UPDATE`, `DELETE` |
| **DQL** (Data Query Language) | Daten abfragen | `SELECT` (manche Bücher zählen es zur DML) |
| **DCL** (Data Control Language) | Rechte vergeben | `GRANT`, `REVOKE` (nicht in SQLite) |
| **TCL** (Transaction Control Language) | Transaktionen steuern | `BEGIN`, `COMMIT`, `ROLLBACK` |

## Tabellen verbinden

| Begriff | Bedeutung |
|---------|-----------|
| **Kartesisches Produkt** | Jede Zeile der einen Tabelle kombiniert mit jeder Zeile der anderen. 8 Bücher × 4 Autoren = 32 Zeilen. Entsteht bei `FROM a, b` ohne Bedingung oder absichtlich mit `CROSS JOIN`. |
| **`JOIN ... ON`** (INNER JOIN) | Nur die Kombinationen, die die Bedingung erfüllen. Man kann es sich als gefiltertes kartesisches Produkt vorstellen. |
| **`LEFT JOIN`** | Alle Zeilen der linken Tabelle, auch ohne Partner. Fehlende Werte rechts sind `NULL`. |
| **Fan-out** | Ein Join liefert mehrere Zeilen pro Objekt, z. B. eine Zeile pro Wert eines Charakters. `SUM` und `COUNT` zählen dann mehrfach. |
| **`EXISTS`** | Prüft nur, **ob** es einen Partner gibt, und vervielfacht keine Zeilen. |
| **`UNION` / `UNION ALL`** | Hängt Ergebnisse **untereinander**. `UNION` entfernt doppelte Zeilen, `UNION ALL` nicht. |

## Werkzeuge für den Betrieb

Ausprobiert in [Teil 4](../4-live-betrieb/Anforderungen.md).

| Werkzeug | Was es ist | Wann man es braucht |
|----------|-----------|---------------------|
| **Index** | sortiertes Verzeichnis zu einer oder mehreren Spalten, wie das Register eines Buchs | Spalten, nach denen oft gesucht, gefiltert, verbunden oder sortiert wird. Macht Lesen schneller, Schreiben langsamer und braucht Platz. |
| **Partieller Index** | Index nur über die Zeilen, die eine Bedingung erfüllen | z. B. „höchstens ein Guildwarden pro Gilde“ mit `CREATE UNIQUE INDEX ... WHERE role_id = 1` |
| **View** | gespeicherte Abfrage, die man wie eine Tabelle benutzt. Speichert keine eigenen Daten. | Spalten verbergen, komplizierte Joins verstecken |
| **Trigger** | SQL, das die Datenbank bei `INSERT`, `UPDATE` oder `DELETE` automatisch ausführt | Protokolle, Regeln über mehrere Zeilen oder Tabellen. Sparsam einsetzen, weil unsichtbar. |
| **Transaktion** | mehrere Anweisungen, die nur gemeinsam gelten: `BEGIN` … `COMMIT` oder `ROLLBACK` | Wenn ein halber Vorgang Schaden anrichtet, z. B. eine Überweisung |
| **Stored Procedure** | Programmlogik, die in der Datenbank gespeichert ist und dort läuft | Nicht in SQLite, aber z. B. in PostgreSQL und SQL Server |

**ACID** sind die vier Garantien einer Transaktion:

| | Bedeutung |
|---|---|
| **A**tomicity | alles oder nichts |
| **C**onsistency | vorher und nachher sind die Daten stimmig, alle Regeln gelten |
| **I**solation | gleichzeitige Transaktionen stören sich nicht |
| **D**urability | nach `COMMIT` dauerhaft gespeichert, auch bei Absturz |

**SQL-Injection:** Eingaben werden als SQL-Code ausgeführt, weil sie direkt in den SQL-Text geklebt wurden. Schutz: immer **parametrisierte Abfragen** (Platzhalter `?`), nie Text zusammenbauen.

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
