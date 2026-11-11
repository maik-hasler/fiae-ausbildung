# SQL Teil 2: Datenbank selbst entwerfen

**Voraussetzung:** [Teil 0: Einstieg](../0-einstieg/einstieg.ipynb) und [Teil 1: Anomalien und Normalformen](../1-normalisierung/Anforderungen.md)  

## User Story

**Als** Auszubildende*r **möchte ich** eine Datenbank für ein Online-Rollenspiel (MMO) selbst entwerfen und einen Ausschnitt davon anlegen und testen, **damit ich** verstehe, wie aus fachlichen Anforderungen ein Datenmodell entsteht.

---

## Projektübersicht

Ein kleines Spielestudio plant ein Online-Rollenspiel. Ihr bekommt **keine fertigen Tabellen**, sondern nur die fachliche Beschreibung, was die Datenbank können muss. Daraus entwerft ihr:

1. ein **ER-Modell** (Entitäten, Attribute, Beziehungen, Kardinalitäten)
2. ein **relationales Modell** (Tabellen, Primär- und Fremdschlüssel, Datentypen)
3. einen **Ausschnitt der Tabellen in SQLite** (`CREATE TABLE ...`)
4. **ein paar Testdaten** (`INSERT INTO ...`)

Entworfen wird das **ganze** Spiel. In SQL umgesetzt wird nur ein Ausschnitt, in dem jede Art von Beziehung und Regel einmal vorkommt. Die übrigen Tabellen würden nur dieselben Muster wiederholen.

In [Teil 3](../3-abfragen/abfragen.ipynb) arbeitet ihr dann mit der Referenzdatenbank, in der das ganze Modell mit vielen Daten steckt.

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
- Jede Gilde hat **genau einen** Guildwarden.

### Diese Fragen muss die Datenbank beantworten können

Euer Modell ist gut, wenn sich damit u. a. diese Fragen beantworten lassen (das sind Aufgaben aus Teil 3):

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
4. Zeichnet den Ausschnitt **Account – Charakter – Gilde** zusätzlich auf Papier in **Chen-Notation** mit **(min,max)-Angaben**. In der Abschlussprüfung kommen beide Schreibweisen vor. Achtung: Die Zahlen stehen dort an einer anderen Seite der Linie als bei der Krähenfuß-Notation (siehe [grundlagen.md](../0-einstieg/grundlagen.md#notationen-für-er-diagramme)).

**Fertig, wenn:** ihr jede Anforderung oben einer Stelle im Diagramm zuordnen könnt.

---

### Schritt 3: Relationales Modell und Normalisierung

**Ziel:** Aus dem ER-Diagramm Tabellen machen.

1. Jede **n:m-Beziehung** wird zu einer eigenen **Zwischentabelle**. Welche sind das bei euch?
2. Legt für jede Tabelle **Primärschlüssel** und **Fremdschlüssel** fest. Wann ist ein **zusammengesetzter Primärschlüssel** sinnvoll? Wo nehmt ihr eine künstliche `id`, wo einen natürlichen Schlüssel? Denkt an die Umbenennung aus [Teil 1, Übung B.5](../1-normalisierung/normalisierung.ipynb).
3. Prüft eure Tabellen gegen die **1., 2. und 3. Normalform**. Steht irgendeine Information an zwei Stellen? Spielt die Tickets aus [Teil 1](../1-normalisierung/Anforderungen.md) im Kopf an eurem Entwurf durch: Kann eine Anomalie auftreten?
4. Wählt passende **Datentypen** (`INTEGER`, `TEXT`, `DATE`, `DATETIME`).

---

### Schritt 4: Tabellen anlegen

**Ziel:** Einen Ausschnitt des Modells in SQLite umsetzen.

Legt **nur** diese Tabellen an. Namen und Spalten wählt ihr selbst, passend zu eurem Modell:

| Tabelle | Was ihr daran übt |
|---------|-------------------|
| Accounts | `UNIQUE` (E-Mail), `NOT NULL`, und eine Spalte, die **leer sein darf**: Wann hat sich ein ganz neuer Account zuletzt eingeloggt? |
| Klassen | Nachschlagetabelle mit eindeutigem Namen. Die Beschreibung darf leer sein. |
| Gilden | wie Klassen |
| Charaktere | **1:n** zu Accounts und zu Klassen, `UNIQUE` (Benutzername), `DEFAULT` und `CHECK` (Gold), `ON DELETE CASCADE` |
| Level-Stand | **1:1** zum Charakter: aktuelles Level und Erfahrung. Legt ihn als eigene Tabelle an, auch wenn es als Spalten in den Charakteren ginge. Das aktuelle Level ist hier eine einfache Zahl, ohne eigene Level-Tabelle. |
| Mitgliedschaften | **n:m** zwischen Charakteren und Gilden, mit Beitrittsdatum und zusammengesetztem Primärschlüssel. Die Rolle lasst ihr weg. |

**Nicht** angelegt werden Fraktionen, Werte, die Level-Tabelle und die Gildenrollen. Sie stehen in eurem Diagramm, wiederholen aber nur Muster, die schon im Ausschnitt vorkommen.

1. Schreibt die `CREATE TABLE`-Anweisungen im Notebook, **eine Zelle pro Tabelle**.
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

**Ziel:** Wenige Daten, aber jeder Fall kommt einmal vor.

- [ ] **3 Accounts**: einer ohne Charakter, einer mit mehreren Charakteren, einer, der sich noch nie eingeloggt hat (leere Spalte)
- [ ] **5 Charaktere** mit **2 Klassen**
- [ ] jeder Charakter hat einen **Level-Stand**, nicht alle auf demselben Level
- [ ] **2 Gilden**: ein Charakter ist in **keiner**, einer in **beiden**
- [ ] bei einem Charakter lasst ihr das Gold beim `INSERT` **weg**. Prüft danach, dass trotzdem 0 drinsteht (`DEFAULT`)

---

### Schritt 6: Regeln testen

**Ziel:** Prüfen, ob die Datenbank falsche Daten ablehnt.

Schreibt `INSERT`s, die **fehlschlagen müssen**:

- zweiter Account mit derselben E-Mail
- Charakter mit einer Klasse, die es nicht gibt
- Charakter mit negativem Gold
- doppelter Benutzername
- Charakter ohne Benutzername

Legt danach einen **zusätzlichen Test-Account** mit einem Charakter (inkl. Level-Stand und Gildenmitgliedschaft) an und löscht den Account wieder. Ist danach alles weg, was zu diesem Charakter gehörte?

**Fertig, wenn:** jeder der fünf Versuche mit einer **roten Fehlermeldung** abgelehnt wird und nach dem Löschen nichts vom Test-Charakter übrig ist. Die Fehlermeldungen sind hier gewollt.

> **Wichtig:** SQLite prüft Fremdschlüssel nur, wenn `PRAGMA foreign_keys = ON;` gesetzt ist. Im Notebook ist das schon eingestellt.

---

### Schritt 7: Vorstellen und vergleichen

1. Stellt euren Entwurf vor.
2. Vergleicht danach mit der Musterlösung in [`../referenz/`](../referenz/). Unterschiede sind **nicht automatisch falsch**. Könnt ihr eure Entscheidung begründen?
3. Weiter geht's mit [Teil 3: Abfragen](../3-abfragen/abfragen.ipynb).

---

## Fertig, wenn …

- [ ] das ER-Diagramm alle Anforderungen abdeckt,
- [ ] die Tabellen des Ausschnitts mit passenden Constraints angelegt sind,
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
