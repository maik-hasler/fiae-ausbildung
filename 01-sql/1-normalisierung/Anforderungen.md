# SQL Teil 1: Anomalien und Normalformen

**Voraussetzung:** [Teil 0: Einstieg](../0-einstieg/einstieg.ipynb)  
**Notebook:** [normalisierung.ipynb](normalisierung.ipynb)

## User Story

**Als** Auszubildende*r **möchte ich** selbst erleben, was schiefgeht, wenn alle Daten in einer einzigen Tabelle stehen, **damit ich** verstehe, warum man Datenbanken in mehrere Tabellen aufteilt, und das beim eigenen Entwurf in Teil 2 gleich richtig mache.

---

## Projektübersicht

Das Spielestudio hat seine Gilden bisher in **einer** Tabelle gepflegt, wie in Excel: eine Zeile pro Mitgliedschaft, mit allem, was dazugehört. Ihr übernehmt diese Tabelle ([prototyp.sql](prototyp.sql)) und arbeitet Tickets ab.

Das Prinzip dieses Teils: **erst stolpern, dann verstehen.** Die Fachbegriffe (Anomalie, Normalform, funktionale Abhängigkeit) kommen erst, **nachdem** ihr die Probleme selbst erlebt habt.

| Teil | Was ihr macht |
|------|---------------|
| **A: Tickets** | Fehler in den Daten finden, eine Beschreibung ändern, eine Klasse umbenennen, eine Gilde gründen, ein Mitglied austreten lassen, Gegenstände zählen. Dabei geht einiges schief. |
| **B: Zerlegen** | Herausfinden, welche Spalte wovon abhängt, die Daten aufräumen, auf mehrere Tabellen verteilen und dieselben Tickets noch einmal lösen. |
| **C: Fachbegriffe** | Euren Schritten die Namen 1., 2. und 3. Normalform zuordnen. |

---

## Aufgaben

### Teil A: Tickets

1. Löst die Tickets im Notebook der Reihe nach.
2. Schreibt bei jedem Ticket in die Antwortzelle, **was schiefgeht** und **warum**. Eigene Worte reichen, Fachbegriffe braucht ihr hier noch nicht.

**Fertig, wenn:** jedes Ticket bearbeitet ist und ihr zu jedem ein Problem in eigenen Worten beschrieben habt.

### Teil B: Zerlegen

1. Bestimmt für jede Spalte, wovon sie abhängt (Schritt B.1).
2. Schlagt **selbst** eine Aufteilung in Tabellen vor, **bevor** ihr das Zielbild aufklappt.
3. Räumt die Widersprüche auf (B.2), legt die neuen Tabellen an und füllt sie aus der alten (B.3).
4. Löst die Tickets auf der neuen Struktur noch einmal (B.4, B.5).

**Fertig, wenn:** die Kontrollzelle 5, 4, 12, 19 und 20 Zeilen zeigt und alle Tickets aus B.4 wie erwartet funktionieren.

### Teil C: Fachbegriffe

1. Lest die Tabelle mit den Normalformen.
2. Erklärt euch gegenseitig an **eurem** Beispiel: Was war der Verstoß gegen die 1., 2. und 3. Normalform?
3. Beantwortet die Fragen unter „Zum Nachdenken“.

**Fertig, wenn:** ihr die drei Normalformen und die drei Anomalien jeweils an einem Beispiel aus der Gildenliste erklären könnt, ohne nachzulesen.

---

## Fertig, wenn …

- [ ] alle Tickets aus Teil A bearbeitet und die Probleme beschrieben sind,
- [ ] die neue Struktur angelegt ist und die Kontrollzelle passt,
- [ ] die Tickets auf der neuen Struktur funktionieren,
- [ ] ihr Änderungs-, Einfüge- und Löschanomalie sowie 1NF, 2NF und 3NF an der Gildenliste erklären könnt.

---

## Ressourcen

| Thema | Link |
|-------|------|
| Begriffe zum Nachschlagen | [grundlagen.md](../0-einstieg/grundlagen.md#normalisierung) |
| Normalisierung (Wikipedia) | https://de.wikipedia.org/wiki/Normalisierung_%28Datenbank%29 |

---

## Tipps

- Eine **rote Fehlermeldung** ist in Übung A.6 und B.5 gewollt. Lest jeweils die letzte Zeile, dort steht der Grund.
- **Run All** stoppt beim ersten Fehler. Führt die Zellen mit gewollten Fehlern einzeln aus.
- Wenn ihr euch verrannt habt: **Restart** und **Run All**. Die Gildenliste wird dann frisch geladen.

Weiter geht's mit [Teil 2: Datenbank selbst entwerfen](../2-datenbank-entwerfen/Anforderungen.md).
