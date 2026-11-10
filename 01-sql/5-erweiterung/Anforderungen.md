# SQL Teil 5: Eigene Erweiterung

**Voraussetzung:** [Teil 4: Live-Betrieb](../4-live-betrieb/Anforderungen.md)  
**Arbeitsform:** allein oder zu zweit  
**Dateien:** [meine-erweiterung.md](meine-erweiterung.md), [migration.sql](migration.sql), [testdaten.sql](testdaten.sql), [erweiterung.ipynb](erweiterung.ipynb)

## User Story

**Als** Auszubildende*r **möchte ich** das MMO um ein Feature erweitern, das ich mir selbst ausgedacht habe, **damit ich** den ganzen Weg einmal allein gehe: von einer fachlichen Idee über das Datenmodell bis zur Änderung an einer Datenbank, in der schon echte Daten stehen.

---

## Projektübersicht

Das Studio will das Spiel weiterentwickeln, und ihr entscheidet, womit. Es gibt **keine Vorgabe und keine Musterlösung**. Ihr wählt ein Feature, wie es in echten Spielen vorkommt, und baut es in die bestehende Datenbank ein.

Der Unterschied zu Teil 2: Die Datenbank ist **schon in Betrieb**. 15.000 Charaktere warten auf euer Feature, und keiner davon darf dabei verloren gehen. Eine Änderung an einer laufenden Datenbank heißt **Migration**.

| Phase | Ergebnis | Datei |
|-------|----------|-------|
| 1. Idee | Feature, User Stories, Fachfragen | `meine-erweiterung.md` |
| 2. Modell | ER-Diagramm der Erweiterung, Entscheidungen, Normalform-Check | `meine-erweiterung.md` |
| 3. Migration | Skript, das die bestehende Datenbank erweitert | `migration.sql` |
| 4. Testdaten | realistische Daten, auch Sonderfälle | `testdaten.sql` |
| 5. Prüfen | Regeltests und Fachfragen in SQL | `erweiterung.ipynb` |
| 6. Betrieb | Werkzeuge aus Teil 4 begründet einsetzen, Datenschutz | `migration.sql`, `meine-erweiterung.md` |
| 7. Review | Gegenseitige Prüfung und Vorstellung | |

---

## Ideen

Die Liste soll euch nur auf Ideen bringen. Eigene Ideen sind ausdrücklich erwünscht. Die Fragen in der rechten Spalte haben **keine** vorgegebene Antwort. Gerade an ihnen merkt ihr, ob euer Modell trägt.

| Feature | Fragen, über die ihr stolpern werdet |
|---------|--------------------------------------|
| **Inventar und Gegenstände** | Gibt es Gegenstände, die sich stapeln (100 Pfeile), und solche, die einzigartig sind (ein verzaubertes Schwert mit eigenen Werten)? Was passiert mit dem Inventar, wenn ein Charakter gelöscht wird? |
| **Marktplatz / Auktionshaus** | Was passiert, wenn zwei gleichzeitig dasselbe kaufen? Welcher Preis gilt: der beim Einstellen oder der beim Kauf? Wie verhindert ihr, dass Gold oder Gegenstände doppelt existieren? |
| **Quests** | Quest B erst nach Quest A? Mehrere Ziele pro Quest? Fortschritt („7 von 10 Wölfen“)? Wiederholbare Quests? |
| **Freundesliste** | Ist eine Freundschaft gegenseitig? Wie verhindert ihr, dass (A, B) und (B, A) doppelt drinstehen? Wie bildet ihr offene Anfragen ab? |
| **Erfolge (Achievements)** | Wann wurde ein Erfolg erreicht? Gibt es Fortschritt? Gehört er zum Charakter oder zum Account? |
| **Moderation und Sperren** | Befristet oder dauerhaft? Wer hat gesperrt und warum? Wie bleibt nachvollziehbar, dass jemand früher schon einmal gesperrt war? |
| **Ingame-Shop mit Echtgeld** | Was steht auf einer Rechnung, und was passiert, wenn sich ein Preis ändert? Rückerstattung? Wie lange müssen die Daten aufbewahrt werden? |
| **Chat und Nachrichten** | Gelesen oder ungelesen? Was passiert mit Nachrichten, wenn ein Account gelöscht wird (Ticket 7)? |
| **Saisonale Rangliste** | Wie bleibt die Rangliste von Saison 1 erhalten, wenn Saison 2 läuft? Lohnt sich hier Denormalisierung (Teil 1)? |

**Sprecht eure Wahl kurz mit eurer Ausbilderin oder eurem Ausbilder ab**, bevor ihr modelliert. Ein Feature ist gut gewählt, wenn es **mindestens zwei neue Tabellen** braucht und **mindestens eine Beziehung zu bestehenden Tabellen** hat.

---

## Aufgaben

### Phase 1: Idee

1. Wählt ein Feature.
2. Schreibt **mindestens 3 User Stories** aus Sicht verschiedener Rollen (Spieler*in, Support, Game-Design, Admin).
3. Formuliert **5 Fachfragen**, die eure Datenbank beantworten können muss, z. B. „Welche Gegenstände wurden diese Woche am häufigsten verkauft?“.
4. Beantwortet in einem Satz: **Warum ist das ein realistischer Anwendungsfall?** Wo gibt es so etwas in echter Software, auch außerhalb von Spielen?

**Fertig, wenn:** die Abschnitte „Idee“ in `meine-erweiterung.md` ausgefüllt sind und die Wahl abgesprochen ist.

### Phase 2: Modell

1. Zeichnet **nur die neuen Tabellen** und ihre Anbindung an bestehende Tabellen als ER-Diagramm.
2. Haltet in der Entscheidungstabelle fest, wo ihr zwischen Varianten gewählt habt und warum.
3. Prüft euer Modell gegen 1NF, 2NF und 3NF.
4. Spielt die Tickets aus [Teil 1](../1-normalisierung/Anforderungen.md) an eurem Modell durch: Kann eine Änderungs-, Einfüge- oder Löschanomalie auftreten?

**Fertig, wenn:** jede Fachfrage aus Phase 1 einer Stelle im Diagramm zugeordnet werden kann.

### Phase 3: Migration

Schreibt [migration.sql](migration.sql). Das Skript wird auf eine frische Kopie der Referenzdatenbank angewendet.

Regeln:

- [ ] Das Skript läuft **fehlerfrei** auf einer frischen Kopie durch.
- [ ] Es läuft in **einer Transaktion** (`BEGIN; ... COMMIT;`). Geht etwas schief, bleibt die Datenbank unverändert.
- [ ] **Keine bestehenden Daten gehen verloren.** Die Anzahl der Accounts, Charaktere und Mitgliedschaften ist danach gleich.
- [ ] Alle Regeln aus euren User Stories stehen als Constraints in der Datenbank (`NOT NULL`, `UNIQUE`, `CHECK`, Fremdschlüssel).
- [ ] Bei jedem Fremdschlüssel habt ihr bewusst entschieden, was beim Löschen passiert (`ON DELETE CASCADE` oder nicht).

**Tabellen ändern in SQLite:** `ALTER TABLE` kann in SQLite nur wenig:

| Geht | Geht nicht direkt |
|------|-------------------|
| `ALTER TABLE t RENAME TO neu;` | Datentyp einer Spalte ändern |
| `ALTER TABLE t RENAME COLUMN a TO b;` | Constraint zu bestehender Spalte hinzufügen |
| `ALTER TABLE t ADD COLUMN c ...;` | Spalte mit `UNIQUE` oder `PRIMARY KEY` hinzufügen |
| `ALTER TABLE t DROP COLUMN c;` (nur für einfache Spalten, siehe unten) | Spalte löschen, die Teil eines Schlüssels, eines Index oder einer `UNIQUE`-Regel ist |

Bei `ADD COLUMN` gilt außerdem: Eine neue Spalte mit `NOT NULL` braucht einen `DEFAULT`, sonst wüsste die Datenbank nicht, was in den bestehenden Zeilen stehen soll. Mit einem Fremdschlüssel (`REFERENCES`) muss der Standardwert `NULL` sein.

Eindeutigkeit lässt sich nachträglich trotzdem ergänzen: mit `CREATE UNIQUE INDEX`, wie in Teil 4, Ticket 2.

**Tabelle neu aufbauen:** Für alles andere legt man eine **neue Tabelle** mit der gewünschten Struktur an, kopiert die Daten hinein, löscht die alte und benennt die neue um.

> **Achtung, Falle:** Ist die Fremdschlüsselprüfung eingeschaltet, löscht `DROP TABLE player` über `ON DELETE CASCADE` auch **alle Zeilen in anderen Tabellen**, die auf `player` verweisen: Werte, Level, Mitgliedschaften. Ohne Fehlermeldung.

Deshalb geht man in dieser Reihenfolge vor:

```sql
PRAGMA foreign_keys = OFF;   -- VOR dem BEGIN, innerhalb einer Transaktion wirkt es nicht
BEGIN;

CREATE TABLE player_neu (...);               -- neue Struktur
INSERT INTO player_neu SELECT ... FROM player;
DROP TABLE player;
ALTER TABLE player_neu RENAME TO player;
-- Indexe, Trigger und Views der alten Tabelle neu anlegen

PRAGMA foreign_key_check;    -- muss leer bleiben: kein Verweis zeigt ins Leere
COMMIT;
PRAGMA foreign_keys = ON;
```

Die Zelle „Neu aufbauen“ im Notebook führt `migration.sql` ohnehin mit ausgeschalteter Prüfung aus und prüft danach mit `PRAGMA foreign_key_check` alle Verweise. Gewöhnt euch die Reihenfolge trotzdem an, denn andere Werkzeuge machen das nicht für euch.

Server-Datenbanken wie PostgreSQL können mit `ALTER TABLE` deutlich mehr. Dort ist der Neuaufbau selten nötig.

**Fertig, wenn:** alle Punkte der Regel-Checkliste erfüllt sind. Prüft das mit der Zelle „Neu aufbauen“ im Notebook.

### Phase 4: Testdaten

Schreibt [testdaten.sql](testdaten.sql). Nutzt die **bestehenden** Charaktere und Accounts, statt neue zu erfinden. `INSERT INTO ... SELECT` mit `WHERE` oder `LIMIT` hilft dabei.

Denkt an **Sonderfälle**: Charaktere ohne Einträge in eurer neuen Tabelle, die größtmöglichen und kleinstmöglichen Werte, Gleichstände.

**Fertig, wenn:** jede Fachfrage ein sinnvolles, nicht leeres Ergebnis liefert und mindestens ein Sonderfall darin vorkommt.

### Phase 5: Prüfen

Im Notebook:

1. Schreibt **mindestens 3 Regeltests**: `INSERT`s oder `UPDATE`s, die **fehlschlagen müssen**.
2. Beantwortet alle **5 Fachfragen** mit SQL.

**Fertig, wenn:** jeder Regeltest mit der erwarteten Fehlermeldung scheitert und jede Fachfrage beantwortet ist.

### Phase 6: Betrieb

1. Setzt **mindestens zwei** Werkzeuge aus [Teil 4](../4-live-betrieb/Anforderungen.md) ein, wo sie für euer Feature **wirklich** sinnvoll sind: Index, View, Trigger, partieller Index, Transaktion. Begründet in `meine-erweiterung.md`, **warum**, und bei einem Index auch, nach welcher Spalte gesucht wird.
2. **Datenschutz:** Welche neuen personenbezogenen Daten speichert euer Feature? Was passiert mit ihnen, wenn ein Account gelöscht wird (Ticket 7)? Testet das: Löscht im Notebook einen Account, der Daten in euren Tabellen hat.

**Fertig, wenn:** beide Abschnitte in `meine-erweiterung.md` ausgefüllt und die Werkzeuge in `migration.sql` umgesetzt sind.

### Phase 7: Review und Vorstellung

1. Tauscht eure Dateien mit einem anderen Team. Prüft die Arbeit des anderen Teams anhand der Checkliste unten und schreibt **drei Dinge, die gut sind, und drei Fragen oder Verbesserungsvorschläge** auf.
2. Baut die Vorschläge ein, die ihr sinnvoll findet.
3. Stellt euer Feature in 10 Minuten vor: Idee, Modell, eine interessante Entscheidung, eine Fachfrage live in SQL.

---

## Checkliste (auch für das Review)

| Bereich | Kriterium | ✓ |
|---------|-----------|---|
| Idee | mindestens 3 User Stories und 5 Fachfragen, realistischer Anwendungsfall begründet | |
| Modell | ER-Diagramm vollständig, Kardinalitäten stimmen | |
| Modell | mindestens zwei neue Tabellen, mindestens eine Beziehung zu bestehenden Tabellen | |
| Modell | 3NF eingehalten oder Abweichung bewusst begründet (Denormalisierung) | |
| Migration | läuft auf frischer Kopie fehlerfrei, in einer Transaktion, ohne Datenverlust | |
| Migration | Regeln der User Stories als Constraints umgesetzt | |
| Migration | `ON DELETE`-Verhalten bewusst gewählt | |
| Testdaten | Fachfragen liefern sinnvolle Ergebnisse, Sonderfälle enthalten | |
| Prüfen | mindestens 3 Regeltests scheitern wie erwartet | |
| Betrieb | mindestens 2 Werkzeuge aus Teil 4 sinnvoll eingesetzt und begründet | |
| Datenschutz | personenbezogene Daten benannt, Löschen eines Accounts getestet | |

---

## Ressourcen

| Thema | Link |
|-------|------|
| Begriffe zum Nachschlagen | [grundlagen.md](../0-einstieg/grundlagen.md) |
| Referenzmodell (Tabellen und Diagramm) | [../referenz/README.md](../referenz/README.md) |
| SQLite `ALTER TABLE` (Englisch) | https://www.sqlite.org/lang_altertable.html |
| Mermaid ER-Diagramme (Englisch) | https://mermaid.js.org/syntax/entityRelationshipDiagram.html |

---

## Tipps

- **Klein anfangen.** Lieber zwei Tabellen richtig als sechs halb. Erweitern könnt ihr später immer noch, genau darum geht es in diesem Teil.
- **Migration oft testen.** Die Zelle „Neu aufbauen“ im Notebook baut die Datenbank in wenigen Sekunden frisch auf und führt eure Skripte aus. Nutzt sie nach jeder Änderung.
- **Fehlermeldung beim Neuaufbau?** Sie nennt die Anweisung, an der es hängt. Weil alles in einer Transaktion läuft, ist dann nichts halb geändert.
- **Tabellennamen der Referenz** sind englisch (`player` = Charakter). Eure neuen Tabellen dürft ihr englisch oder deutsch benennen, aber bitte einheitlich.
