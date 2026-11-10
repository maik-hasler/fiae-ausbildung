# KI-Projekt 2: Ein eigenes Mini-Gedächtnis (LLM-Wiki)

**Niveau:** Fortgeschritten  
**Dauer:** etwa 4–5 Tage  
**Voraussetzung:** [Projekt 1](../projekt-1-rag/Anforderungen.md) abgeschlossen, sicherer Umgang mit Python-Funktionen, Listen und Klassen

## User Story

**Als** Auszubildende*r **möchte ich** einem LLM ein eigenes, dauerhaftes Gedächtnis bauen, **damit ich** verstehe, wie ein KI-Assistent sich Dinge über Gespräche hinweg merken kann und wie sich das von RAG aus Projekt 1 unterscheidet.

---

## Projektübersicht

Ein LLM vergisst nach jedem Gespräch alles. In Projekt 1 habt ihr das mit **RAG** gelöst: Texte werden in Chunks zerlegt, als Vektoren gespeichert und bei einer Frage per Ähnlichkeitssuche wiedergefunden.

In diesem Projekt geht ihr einen anderen Weg: Das LLM **schreibt und pflegt selbst ein kleines Wiki** aus Markdown-Dateien. Statt Textstücken entstehen lesbare Seiten, eine pro Person, Thema oder Begriff, die das LLM bei neuen Informationen **ergänzt**, untereinander **verlinkt** und bei Fragen **nachschlägt**.

**Was ist ein LLM-Wiki?**

```
quellen/                  wiki/
  brettspiel.txt   ──►      index.md          ← Inhaltsverzeichnis: eine Zeile pro Seite
  anleitung.txt   einlesen  log.md            ← Was wurde wann geändert?
  (Chat-Notizen)   ──►      spielregeln.md
                            spielfiguren.md
                            alex.md    ...    ← Seiten mit [[Links]] untereinander
```

- **Quellen** bleiben unverändert, sie sind die „Wahrheit“.
- Das **Wiki** gehört dem LLM: Es legt Seiten an, fasst zusammen, verlinkt, korrigiert.
- **Ihr** könnt jede Seite lesen und prüfen, denn es sind einfache Textdateien.

Jede Seite hat ein festes Format:

```markdown
# Titel

> Zusammenfassung in einem Satz.

Inhalt mit Verweisen wie [[Andere Seite]].

Quellen: ...
```

Die Idee stammt von Andrej Karpathy, der sie im April 2026 als [„LLM Wiki“](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) (Englisch) beschrieben hat.

---

## Aufgaben

### Phase 1: Das Wiki-Gerüst

**Ziel:** Verstehen, wie das Wiki gespeichert wird.

Die Hilfsfunktionen zum Schreiben, Lesen und Auflisten von Seiten sowie für `index.md` und `log.md` sind im Notebook **vorgegeben**.

**Schritte:**
1. Die Hilfsfunktionen lesen und nachvollziehen
2. Drei Seiten von Hand anlegen, die aufeinander verweisen
3. Eine Funktion `links_finden(text)` schreiben, die alle `[[Links]]` aus einem Text liefert

**Fertig, wenn:** `index.md` alle drei Seiten auflistet und `links_finden` die Links richtig findet.

---

### Phase 2: Merken

**Ziel:** Das LLM entscheidet selbst, was es sich aus einem Text merkt und wo es das ablegt.

**Schritte:**
1. Testen, ob die **strukturierte Ausgabe** funktioniert (`llm.with_structured_output(...)`). Die Datenmodelle mit Pydantic sind vorgegeben.
2. Funktion `seiten_auswaehlen(text)`: Das LLM bekommt `index.md` und nennt die Titel der Seiten, die zum Text passen.
3. Funktion `merken(text, quelle)`: passende Seiten lesen, zusammen mit den Regeln und dem neuen Text an das LLM geben, die zurückgegebenen Seiten speichern, Index und Log aktualisieren.

**Fertig, wenn:**
- `merken("Ich heiße Alex und mache eine Ausbildung in der Anwendungsentwicklung.")` eine Seite zu Alex anlegt,
- ein zweiter Aufruf mit neuen Infos über Alex **dieselbe Seite ergänzt** und keine zweite entsteht.

---

### Phase 3: Quellen einlesen

**Ziel:** Ganze Dokumente ins Wiki übernehmen.

**Datenquellen:** eure eigenen Quellen aus Projekt 1 (PDFs in `../projekt-1-rag/data/` und eure Websites, siehe `../projekt-1-rag/quellen.md`).

**Schritte:**
1. Quellen laden (Code aus Projekt 1 wiederverwenden) und den Text in `quellen/` speichern
2. Lange Texte in Stücke von etwa 3000 Zeichen teilen
3. Jedes Stück mit `merken` ins Wiki übernehmen, mit der Quelle als Angabe

**Fertig, wenn:**
- zu jeder Quelle mind. eine Wiki-Seite existiert, die die Quelle nennt,
- ihr die Antworten auf eure Testfragen aus Projekt 1 **beim Lesen des Wikis** findet.

---

### Phase 4: Fragen beantworten

**Ziel:** Das LLM beantwortet Fragen mit seinem eigenen Wiki, ganz ohne Vektordatenbank.

**Schritte:**
1. Funktion `fragen(frage)`: passende Seiten mit `seiten_auswaehlen` finden
2. Seiten lesen und zusammen mit der Frage an das LLM geben
3. Antwort **mit Angabe der genutzten Seiten** ausgeben
4. Steht die Antwort nicht im Wiki, soll das LLM das **zugeben**, statt zu raten

**Fertig, wenn:**
- eure 5 Testfragen aus Projekt 1 (`../projekt-1-rag/testfragen.md`) mind. so gut beantwortet werden wie mit RAG,
- „Wie heiße ich?“ aus dem Gedächtnis beantwortet wird,
- eine Frage zu etwas, das ihr nie erzählt habt (z. B. „Wie heißt mein Haustier?“), mit „Das weiß ich nicht“ o. Ä. beantwortet wird.

Allgemeinwissen (z. B. Hauptstädte) kennt das LLM aus dem Training. Für diese Übung soll es trotzdem **nur** aus dem Wiki antworten. Das müsst ihr im Prompt klar sagen.

---

### Phase 5 (Bonus)

Sucht euch eine oder mehrere Erweiterungen aus:

**a) Aufräumen**
Funktion `aufraeumen()`: Findet mit Python und `links_finden` **kaputte Links** (Link auf eine Seite, die es nicht gibt) und **verwaiste Seiten** (auf die nichts verlinkt). Lasst danach das LLM das ganze Wiki lesen und **Widersprüche** sowie Seiten melden, die man **zusammenlegen** sollte.

**b) Chat mit Gedächtnis**
Ein Chat (im Notebook oder mit **Streamlit** wie in Projekt 1, Phase 6), der vor jeder Antwort im Wiki nachschlägt und nach jeder Nachricht entscheidet, ob es etwas zu merken gibt. Schließt den Chat und startet ihn neu: Weiß er noch, wer ihr seid?

**c) Antworten zurückschreiben**
Gute Antworten auf Fragen werden selbst als neue Wiki-Seite gespeichert. So wächst das Wiki mit jeder Frage.

**d) Vergleich RAG und Wiki**
Stellt beiden Systemen dieselben 5 Fragen und haltet in einer Tabelle fest: Welche Antwort war besser? Was passiert, wenn sich eine Information ändert (z. B. eine Regel in eurem PDF)? Ab welcher Wiki-Größe passt `index.md` nicht mehr in den Prompt, und was dann?

---

## Fertig, wenn …

- [ ] Phasen 1 bis 4 abgeschlossen sind,
- [ ] ihr erklären könnt, wann ein LLM-Wiki besser passt als RAG und wann nicht,
- [ ] ihr euer Wiki vorgestellt habt.

---

## Setup

Wie in Projekt 1. Zusätzliche Pakete braucht ihr nicht.

---

## Ressourcen & Dokumentation

| Thema | Link |
|-------|------|
| LLM Wiki von Andrej Karpathy (Englisch) | https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f |
| Strukturierte Ausgabe mit LangChain (Englisch) | https://docs.langchain.com/oss/python/langchain/structured-output |
| Pydantic (Englisch) | https://pydantic.dev/docs/validation/latest/get-started/ |
| Python `pathlib` | https://docs.python.org/3/library/pathlib.html |
| Obsidian (Wiki mit klickbaren Links ansehen) | https://obsidian.md |

---

## Projektstruktur

```
projekt-2-llm-wiki/
├── Anforderungen.md       # Diese Datei
├── llm-wiki.ipynb         # Arbeitsnotebook
├── quellen/               # Rohdaten (wird im Notebook angelegt, nicht im Repository)
└── wiki/                  # Vom LLM gepflegte Seiten (wird im Notebook angelegt, nicht im Repository)
    ├── index.md
    └── log.md
```

---

## Tipps

- Schaut euch nach jedem Schritt die Dateien in `wiki/` **selbst an**. Das ist der große Vorteil gegenüber einer Vektordatenbank.
- In VS Code sind `[[Links]]` normaler Text. Wer sie klickbar haben will, öffnet den Ordner `wiki/` in Obsidian.
- Wenn das LLM Unsinn ins Wiki schreibt: Regeln im Prompt verbessern, den Ordner `wiki/` löschen, neu einlesen.
- Gibt `with_structured_output` Fehler, probiert `method="json_schema"`. Hilft auch das nicht, lasst das LLM JSON als Text ausgeben und lest es mit `WikiAenderung.model_validate_json(...)` ein.

**Viel Erfolg!**
