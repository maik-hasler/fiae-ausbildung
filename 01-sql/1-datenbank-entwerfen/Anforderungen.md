# SQL Teil 1: Datenbank selbst entwerfen

**Voraussetzung:** [Teil 0: Einstieg](../0-einstieg/einstieg.ipynb)  
**Dauer:** etwa 3 Tage

## User Story

**Als** Auszubildende*r **möchte ich** eine Datenbank für ein Online-Rollenspiel (MMO) selbst entwerfen, anlegen und mit eigenen Daten füllen, **damit ich** verstehe, wie aus fachlichen Anforderungen ein Datenmodell entsteht, und meine eigene Datenbank danach in Teil 2 abfragen kann.

---

## Projektübersicht

Ein kleines Spielestudio plant ein Online-Rollenspiel. Ihr bekommt **keine fertigen Tabellen**, sondern nur die fachliche Beschreibung, was die Datenbank können muss. Daraus entwerft ihr:

1. ein **ER-Modell** (Entitäten, Attribute, Beziehungen, Kardinalitäten)
2. ein **relationales Modell** (Tabellen, Primär- und Fremdschlüssel, Datentypen)
3. die **Tabellen in SQLite** (`CREATE TABLE ...`)
4. **eigene Testdaten** (`INSERT INTO ...`)

In [Teil 2](../2-abfragen/abfragen.ipynb) beantwortet ihr dann Fragen mit SQL-Abfragen, und zwar auf **eurer eigenen** Datenbank.

Die Begriffe (Primärschlüssel, Kardinalität, Normalform …) sind in [grundlagen.md](../0-einstieg/grundlagen.md) erklärt.

> Die Musterlösung liegt in [`../referenz/`](../referenz/). **Erst öffnen, wenn euer Entwurf fertig ist und ihr ihn vorgestellt habt!**

---

## Fachliche Anforderungen (Vorgabe)

Das Spiel ist auf Englisch. Die Namen von Klassen, Werten und Gildenrollen bleiben deshalb englisch.

### Accounts
- Wer spielen will, legt einen **Account** an. Dazu gehören eine **E-Mail-Adresse** (darf es nur einmal geben) und ein **Passwort**.
- Das Passwort darf **nicht im Klartext** gespeichert werden, sondern nur als **Hash** (eine Art Fingerabdruck des Passworts). In euren Testdaten reicht ein Platzhalter wie `'hash_123'`, denn SQLite kann selbst keine Hashes berechnen.
- Wir wollen wissen, **wann** ein Account angelegt wurde und wann sich jemand **zuletzt eingeloggt** hat.

### Charaktere
- Mit einem Account kann man **beliebig viele Spielcharaktere** erstellen oder auch gar keinen.
- Jeder Charakter hat einen **Benutzernamen**, der im ganzen Spiel **eindeutig** ist.
- Jeder Charakter besitzt **Gold**. Neue Charaktere starten mit 0 Gold, negatives Gold gibt es nicht.
- Wird ein Account gelöscht, sollen auch **alle seine Charaktere** verschwinden, samt allem, was zu ihnen gehört (Werte, Level, Gildenmitgliedschaften).

### Klassen und Fraktionen
- Jeder Charakter hat **genau eine Klasse** (z. B. Paladin, Assassin, Mage) und gehört **genau einer Fraktion** an (z. B. Silver Order, Forest League, Iron Guild).
- Klassen und Fraktionen haben einen **eindeutigen Namen** und eine **Beschreibung**.
- Das Studio will später **neue Klassen und Fraktionen ergänzen**, ohne die Datenbankstruktur zu ändern.

### Werte (Stats)
- Jeder Charakter hat Werte wie **Health (HP), Mana (MP), Attack (ATK), Defense (DEF), Speed (SPD), Critical Chance (CRIT), Evasion (EVA)** und **Luck (LUCK)**.
- Jeder Wert hat einen **Namen** und ein **Kürzel**.
- Auch hier sollen später **neue Werte** dazukommen können, ohne neue Spalten anzulegen.

### Level und Erfahrung
- Es gibt **Level** (1, 2, 3, …). Für jedes Level ist festgelegt, wie viel Erfahrung man **insgesamt** braucht, um es zu erreichen (z. B. Level 2: 100, Level 3: 300).
- Jeder Charakter hat ein **aktuelles Level** und **Erfahrungspunkte seit Erreichen dieses Levels**. Neue Charaktere starten auf Level 1 mit 0 Erfahrung.

### Gilden
- Charaktere können sich in **Gilden** zusammenschließen. Eine Gilde hat einen **eindeutigen Namen** und eine **Beschreibung**.
- Ein Charakter kann **in mehreren Gilden** Mitglied sein oder auch in keiner.
- Wir wollen wissen, **seit wann** ein Charakter in einer Gilde ist.
- In jeder Gilde hat ein Mitglied **genau eine Rolle**: *Guildwarden* (Leitung), *Councilor*, *Captain*, *Member* oder *Initiate*. Rollen haben einen Namen und eine Beschreibung.

### Diese Fragen muss die Datenbank beantworten können

Euer Modell ist gut, wenn sich damit u. a. diese Fragen beantworten lassen (das sind Aufgaben aus Teil 2):

- Welche Klassen gibt es? Wie viele Charaktere gehören zu jeder Fraktion?
- Welcher Charakter hat die meisten HP? Wie hoch ist die durchschnittliche Defense?
- Welche Charaktere sind in keiner Gilde, welche in mehreren? Wer leitet welche Gilde?
- Wer ist der reichste Charakter?
- Welche Charaktere haben mindestens Level 3?
- Welcher Account hat die meisten Charaktere? Welche Accounts haben gar keinen?

---

## Aufgaben

### Schritt 1: Anforderungen analysieren

**Ziel:** Verstehen, welche „Dinge“ (Entitäten) in der Beschreibung stecken.

1. Markiert alle **Substantive** in den Anforderungen. Das sind Kandidaten für **Entitäten** oder **Attribute**.
2. Markiert alle **Beziehungen** („hat“, „ist Mitglied in“, …).
3. Bestimmt für jede Beziehung die **Kardinalität** (1:1, 1:n, n:m) und ob sie **optional** ist („oder auch gar keinen“).
4. Tragt das Ergebnis in die Tabelle im Notebook [`entwurf.ipynb`](entwurf.ipynb) ein.

---

### Schritt 2: ER-Diagramm zeichnen

**Ziel:** Das Modell als Diagramm darstellen.

1. Zeichnet ein ER-Diagramm in [`mein-er-modell.md`](mein-er-modell.md) (Mermaid-Syntax, eine Vorlage ist enthalten). Alternativ geht auch Papier oder draw.io.
2. Jede Entität bekommt ihre Attribute und einen **Primärschlüssel**.
3. Alle Beziehungen mit **Kardinalitäten** einzeichnen.

**Fertig, wenn:** ihr jede Anforderung oben einer Stelle im Diagramm zuordnen könnt.

---

### Schritt 3: Relationales Modell und Normalisierung

**Ziel:** Aus dem ER-Diagramm Tabellen machen.

1. Jede **n:m-Beziehung** wird zu einer eigenen **Zwischentabelle**. Welche sind das bei euch?
2. Legt für jede Tabelle **Primärschlüssel** und **Fremdschlüssel** fest. Wann ist ein **zusammengesetzter Primärschlüssel** sinnvoll?
3. Prüft eure Tabellen gegen die **1., 2. und 3. Normalform**. Steht irgendeine Information an zwei Stellen?
4. Wählt passende **Datentypen** (`INTEGER`, `TEXT`, `DATE`, `DATETIME`).

---

### Schritt 4: Tabellen anlegen

**Ziel:** Das Modell in SQLite umsetzen.

1. Schreibt die `CREATE TABLE`-Anweisungen im Notebook, am besten **eine Zelle pro Tabelle**. Weitere Zellen fügt ihr mit **+ Code** hinzu.
2. Sichert die Regeln aus den Anforderungen mit **Constraints** ab:
   - `PRIMARY KEY`, `FOREIGN KEY ... REFERENCES ...`
   - `NOT NULL`, `UNIQUE`, `DEFAULT`, `CHECK (...)`
   - `ON DELETE CASCADE`: Wo ist das gewollt, wo ist es gefährlich?
3. Achtet auf die **Reihenfolge**: Eine Tabelle kann erst auf eine andere verweisen, wenn diese existiert.

**Tipps:**
- `DEFAULT CURRENT_TIMESTAMP` trägt automatisch das aktuelle Datum mit Uhrzeit ein.
- Führt ihr ein `CREATE TABLE` ein zweites Mal aus, kommt `table ... already exists`. Schreibt `DROP TABLE IF EXISTS name;` davor, oder legt die Datenbank neu an (siehe [Tipps](#tipps) unten).

---

### Schritt 5: Eigene Testdaten einfügen

**Ziel:** Die Datenbank mit sinnvollen, selbst ausgedachten Daten füllen.

Eure Daten müssen **mindestens** Folgendes enthalten, damit alle Aufgaben in Teil 2 ein sinnvolles Ergebnis liefern:

- [ ] mind. **6 Accounts**, davon **mind. 1 ohne Charakter**
- [ ] mind. **12 Charaktere**, mind. **2 Accounts mit mehreren** Charakteren
- [ ] **zwei Accounts mit gleich vielen** Charakteren an der Spitze (Gleichstand!)
- [ ] mind. **4 Klassen** (darunter **Assassin**) und **3 Fraktionen**
- [ ] alle **8 Werte** (HP, MP, ATK, DEF, SPD, CRIT, EVA, LUCK) für **jeden** Charakter
- [ ] **Level 1–5** mit aufsteigender benötigter Erfahrung, Charaktere auf **verschiedenen** Leveln, mind. 3 Charaktere ab Level 3
- [ ] mind. **3 Gilden** und alle **5 Rollen**, in jeder Gilde ein Guildwarden
- [ ] mind. **1 Charakter ohne Gilde** und mind. **1 Charakter in 2 Gilden**
- [ ] unterschiedliche Gold-Beträge, mind. 1 Charakter mit 0 Gold

**Tipp:** 12 Charaktere × 8 Werte sind 96 Zeilen. Statt alle einzeln zu tippen, könnt ihr mit `INSERT ... SELECT` und `CROSS JOIN` für **jeden** Charakter **jeden** Wert anlegen und die Zahlen danach mit `UPDATE` anpassen. Mit euren eigenen Tabellennamen sieht das etwa so aus:

```sql
INSERT INTO charakter_wert (charakter_id, wert_id, zahl)
SELECT c.id, w.id, 10
FROM charakter c
CROSS JOIN wert w;
```

---

### Schritt 6: Regeln testen

**Ziel:** Prüfen, ob die Datenbank falsche Daten ablehnt.

Schreibt `INSERT`s, die **fehlschlagen müssen**:

- zweiter Account mit derselben E-Mail
- Charakter mit einer Klasse, die es nicht gibt
- Charakter mit negativem Gold
- doppelter Benutzername

Legt danach einen **zusätzlichen Test-Account** mit einem Charakter (inkl. Werten, Level und Gilde) an und löscht den Account wieder. Ist danach alles weg, was zu diesem Charakter gehörte?

**Fertig, wenn:** jeder der vier Versuche mit einer **roten Fehlermeldung** abgelehnt wird und nach dem Löschen nichts vom Test-Charakter übrig ist. Die Fehlermeldungen sind hier gewollt.

> **Wichtig:** SQLite prüft Fremdschlüssel nur, wenn `PRAGMA foreign_keys = ON;` gesetzt ist. Im Notebook ist das schon eingestellt.

---

### Schritt 7: Vorstellen und vergleichen

1. Stellt euren Entwurf vor.
2. Vergleicht danach mit der Musterlösung in [`../referenz/`](../referenz/). Unterschiede sind **nicht automatisch falsch**. Könnt ihr eure Entscheidung begründen?
3. Weiter geht's mit [Teil 2: Abfragen](../2-abfragen/abfragen.ipynb).

---

## Fertig, wenn …

- [ ] das ER-Diagramm alle Anforderungen abdeckt,
- [ ] alle Tabellen mit passenden Constraints angelegt sind,
- [ ] die Checkliste aus Schritt 5 erfüllt ist,
- [ ] alle Tests aus Schritt 6 wie erwartet fehlschlagen,
- [ ] ihr euren Entwurf vorgestellt habt.

---

## Variante: Eigenes Thema (Bonus)

Wenn ihr mit dem MMO fertig seid oder ein anderes Thema spannender findet, wiederholt die Schritte 1–6 mit einem **eigenen Szenario**. Die Anforderungen schreibt ihr dann selbst, und zwar als User Stories. Außerdem überlegt ihr euch **10 eigene Fragen**, die eure Datenbank beantworten können soll, jeweils mit SQL-Lösung.

Ideen:

| Thema | Typische Entitäten |
|-------|--------------------|
| Bibliothek | Buch, Exemplar, Autor, Mitglied, Ausleihe |
| Sportverein | Mitglied, Abteilung, Training, Beitrag, Trainer |
| Kantine | Gericht, Zutat, Allergen, Speiseplan, Bestellung |
| IT-Support | Ticket, Mitarbeiter, Gerät, Kategorie, Kommentar |
| Fuhrpark | Fahrzeug, Fahrer, Buchung, Wartung, Standort |

---

## Ressourcen

| Thema | Link |
|-------|------|
| Begriffe und Beispiele | [grundlagen.md](../0-einstieg/grundlagen.md) |
| SQLite `CREATE TABLE` (Englisch) | https://www.sqlite.org/lang_createtable.html |
| SQLite Fremdschlüssel (Englisch) | https://www.sqlite.org/foreignkeys.html |
| Mermaid ER-Diagramme (Englisch) | https://mermaid.js.org/syntax/entityRelationshipDiagram.html |
| Mermaid Live-Editor | https://mermaid.live |

---

## Tipps

- Erst **denken und zeichnen**, dann tippen. Ein falsches Modell ist auf Papier schneller korrigiert als in SQL.
- **Neu anfangen:** Kernel neu starten (**Restart**), dann die Datei `meine_mmo.db` löschen und die Notebook-Zellen erneut ausführen. Solange der Kernel läuft, ist die Datei unter Windows gesperrt.
- **Datenbank ansehen:** Mit der VS-Code-Erweiterung *SQLite Viewer* könnt ihr `meine_mmo.db` anklicken und alle Tabellen ansehen.
- Eure fertigen `CREATE TABLE`- und `INSERT`-Anweisungen könnt ihr zusätzlich in `schema.sql` / `daten.sql` speichern. Dann lässt sich die Datenbank jederzeit neu aufbauen.

**Viel Erfolg!**
