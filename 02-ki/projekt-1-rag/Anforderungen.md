# KI-Projekt 1: Euer eigenes RAG

**Niveau:** Einstieg  
**Dauer:** etwa 4–5 Tage  
**Voraussetzung:** [Setup im Hauptordner](../../README.md#setup) inklusive Ollama

## User Story

**Als** Auszubildende*r **möchte ich** ein RAG-System (Retrieval Augmented Generation) mit **selbst gewählten Dokumenten** bauen, **damit ich** verstehe, wie man eigene Inhalte so aufbereitet, dass ein LLM sie nutzen und Fragen dazu beantworten kann.

---

## Projektübersicht

Ein LLM kennt nur das, womit es trainiert wurde. Eure eigenen Dokumente kennt es nicht. In diesem Projekt sucht oder erstellt ihr **eure eigene Wissensbasis** und macht sie für das LLM **nutzbar**: Text herausholen, aufbereiten, in Stücke teilen, als Vektoren speichern und bei einer Frage die passenden Stücke wiederfinden.

Die Fachbegriffe (Embedding, Chunk, Collection …) sind im [Glossar](../README.md#glossar) erklärt.

```
Eure Dokumente ──► Text extrahieren ──► Chunks ──► Embeddings ──► Vektordatenbank
                                                                        │
Frage ──► Embedding ──► ähnlichste Chunks suchen ◄──────────────────────┘
                              │
                              ▼
                 LLM: Frage + gefundene Chunks ──► Antwort mit Quelle
```

Gearbeitet wird im Notebook [`rag.ipynb`](rag.ipynb). Die Imports und einige Bausteine sind vorgegeben, die Stellen mit `TODO` ergänzt ihr selbst.

---

## Aufgaben

### Phase 0: Erste Schritte mit Ollama

**Ziel:** Das LLM und das Embedding-Modell einmal direkt ausprobieren, bevor alles zusammengesteckt wird.

**Schritte:**
1. Dem LLM eine Frage stellen und die Antwort ausgeben
2. Eine Frage zu etwas stellen, das das LLM **nicht wissen kann** (z. B. zu einem selbst erfundenen Spiel). Was passiert?
3. Mit dem Embedding-Modell zwei Sätze vergleichen: Sind ähnliche Sätze wirklich ähnlicher als unähnliche?

**Fertig, wenn:** ihr in eigenen Worten erklären könnt, was ein Embedding ist und warum das LLM allein eure Dokumente nicht kennt.

---

### Phase 1: Thema wählen und Wissensbasis zusammenstellen

**Ziel:** Eine eigene Sammlung von Dokumenten, zu der ihr später Fragen stellt.

**Schritte:**
1. Ein **Thema** wählen, das euch interessiert, z. B. euer Hobby, ein Spiel, eine Sportart, euer Ausbildungsberuf, eine Stadt, eine Serie.
2. Mindestens **3 Quellen** sammeln:
   - mind. **1 PDF, das ihr selbst erstellt** (z. B. in Word schreiben → „Speichern unter“ → PDF). Schreibt Fakten hinein, die das LLM **nicht kennen kann**, z. B. die Regeln eines selbst ausgedachten Brettspiels oder einen erfundenen Steckbrief. Nur so seht ihr sicher, dass die Antwort aus euren Daten kommt.
   - mind. **1 PDF aus dem Internet** (z. B. Spielanleitung, Ausbildungsrahmenplan, Flyer, Bedienungsanleitung)
   - mind. **1 Website**, z. B. ein Wikipedia-Artikel
3. PDFs in den Ordner `data/` legen. URLs von Websites notiert ihr im Notebook.
4. Jede Quelle in [`quellen.md`](quellen.md) eintragen. Dort steht auch, woran ihr erkennt, ob ihr eine Quelle verwenden dürft.
5. **5 Testfragen** mit erwarteter Antwort in [`testfragen.md`](testfragen.md) aufschreiben, **bevor** ihr programmiert. Darunter:
   - mind. 1 Frage, die **nur** euer selbst erstelltes PDF beantworten kann
   - mind. 1 Frage, deren Antwort in **keiner** eurer Quellen steht

> **Wichtig: Was nicht in die Wissensbasis gehört**
> Das LLM `gpt-oss:20b-cloud` läuft **nicht auf eurem Rechner**, sondern auf Servern von Ollama. Alles, was ihr fragt, und alle gefundenen Textstücke werden dorthin geschickt. Deshalb: **keine internen Firmendokumente, keine personenbezogenen Daten** (Adressen, Zeugnisse, Gesundheitsdaten …), nichts Vertrauliches.

**Kein Thema gefunden?** In `beispiel/` liegen die Regeln des frei erfundenen Brettspiels „Inselhandel“. Kopiert die Datei nach `data/` (die passende Zeile steht im Notebook) und ergänzt eure eigenen Quellen später.

**Fertig, wenn:** `data/` mind. 2 PDFs enthält und `quellen.md` sowie `testfragen.md` ausgefüllt sind.

---

### Phase 2: Dokumente für das LLM aufbereiten

**Ziel:** Aus euren Dateien sauberen Text machen, den das LLM verarbeiten kann.

**Schritte:**
1. **Alle** PDFs aus `data/` automatisch laden (nicht jede Datei einzeln von Hand)
2. Website(s) laden
3. **Kontrolle: Was sieht das LLM eigentlich?** Gebt den extrahierten Text aus und prüft:
   - Ist überhaupt Text da? (Eingescannte PDFs bestehen nur aus Bildern, da kommt kein Text heraus.)
   - Sind Tabellen, Aufzählungen und Umlaute noch lesbar?
   - Ist bei der Website nur der Inhalt drin oder auch Menü, Cookie-Hinweis, Fußzeile?
4. Text bei Bedarf bereinigen (leere Zeilen, Kopf- und Fußzeilen, Menüs)

Die Loader speichern zu jedem Text automatisch **Metadaten**: die Quelle (Dateiname bzw. URL) und bei PDFs die Seite. Die braucht ihr später für die Quellenangabe.

**Fertig, wenn:** ihr für jede Quelle zeigen könnt, welcher Text herauskommt, und das Ergebnis in `quellen.md` eingetragen habt.

---

### Phase 3: Indexieren

**Ziel:** Den Text durchsuchbar in der Vektordatenbank ablegen.

**Schritte:**
1. Text in Chunks aufteilen
2. Vektordatenbank einrichten (Qdrant läuft im Arbeitsspeicher, die Einstellungen sind im Notebook vorgegeben)
3. Chunks in die Vektordatenbank speichern
4. Eine **Ähnlichkeitssuche ohne LLM** machen: Welche Chunks werden für eure Testfragen gefunden?

Nach einem Kernel-Neustart ist die Vektordatenbank leer. Führt dann die Zellen ab Phase 2 erneut aus.

**Fertig, wenn:** für mind. 4 eurer Testfragen unter den gefundenen Chunks einer ist, der die Antwort enthält.

---

### Phase 4: RAG-Abfrage

**Ziel:** Fragen zu euren Dokumenten beantworten.

**Schritte:**
1. Zu einer Frage die passendsten Chunks abrufen
2. Frage und Chunks in einem Prompt an das LLM geben (die Vorlage für den Prompt ist im Notebook)
3. Das LLM soll **nur** aus den Chunks antworten und die **Quelle** nennen (Datei oder URL, Seite)
4. Steht die Antwort nicht in den Dokumenten, soll das LLM das **sagen**, statt zu raten
5. Alle 5 Testfragen durchlaufen lassen und die Ergebnisse in `testfragen.md` eintragen

**Fertig, wenn:** mind. **4 von 5 Testfragen** richtig beantwortet werden. Richtig heißt: Antworten aus euren Dokumenten nennen ihre Quelle, und bei der Frage ohne Antwort sagt das LLM, dass es die Antwort nicht weiß.

---

### Phase 5: Verbessern

**Ziel:** Verstehen, welche Einstellungen die Antwortqualität beeinflussen.

Verändert jeweils **eine** Sache, lasst die Testfragen erneut laufen und notiert das Ergebnis in `testfragen.md`:

| Einstellung | Ausprobieren |
|-------------|--------------|
| Chunk-Größe | z. B. 300 / 1000 / 3000 Zeichen |
| Überlappung | 0 / 10 % / 25 % |
| Anzahl gefundener Chunks (`k`) | 1 / 4 / 10 |
| Prompt | mit / ohne Anweisung „nur aus dem Kontext antworten“ |

**Fertig, wenn:** ihr begründen könnt, welche Kombination für eure Dokumente am besten war.

---

### Phase 6: Weboberfläche mit Streamlit (Bonus)

**Ziel:** Eine Chat-Oberfläche für euer RAG im Browser.

Streamlit läuft **nicht im Notebook**, sondern als eigenes Python-Programm. Eine Vorlage liegt in [`app.py`](app.py).

**Schritte:**
1. Den Code aus dem Notebook, der Dokumente lädt und indexiert, in `app.py` übernehmen (Hinweise stehen in der Datei)
2. Eure Funktion `fragen()` übernehmen und im Chat aufrufen
3. Starten, im Hauptordner:
   ```powershell
   .venv\Scripts\streamlit run 02-ki/projekt-1-rag/app.py
   ```
   Der Browser öffnet sich automatisch. Beenden mit `Strg + C` im Terminal.
4. Bonus: PDFs direkt in der Oberfläche **hochladen** (`st.file_uploader`) und sofort indexieren

**Fertig, wenn:** ihr im Browser eine Testfrage stellen könnt und die Antwort mit Quelle erscheint.

---

## Fertig, wenn …

- [ ] Phasen 0 bis 5 abgeschlossen sind,
- [ ] mind. 4 von 5 Testfragen richtig beantwortet werden,
- [ ] ihr euer RAG mit euren eigenen Quellen vorgestellt habt.

---

## Ressourcen & Dokumentation

| Thema | Link |
|-------|------|
| LangChain: PDF laden, aufteilen, einbetten und durchsuchen, mit kleinem RAG-Beispiel (Englisch) | https://docs.langchain.com/oss/python/langchain/knowledge-base |
| Embedding-Modell | https://ollama.com/library/embeddinggemma:300m |
| LLM | https://ollama.com/library/gpt-oss:20b-cloud |
| LangChain Ollama Integration (Englisch) | https://reference.langchain.com/python/langchain-ollama |
| Streamlit Chat (Englisch) | https://docs.streamlit.io/develop/api-reference/chat |

---

## Projektstruktur

```
02-ki/projekt-1-rag/
├── Anforderungen.md       # Diese Datei
├── rag.ipynb              # Arbeitsnotebook
├── app.py                 # Vorlage für die Weboberfläche (Phase 6)
├── quellen.md             # Eure Quellen
├── testfragen.md          # Eure Testfragen und Ergebnisse
├── data/                  # Eure PDFs (werden nicht ins Repository hochgeladen)
└── beispiel/
    └── inselhandel-spielregeln.pdf  # Beispiel, falls ihr noch kein Thema habt
```

Weiter geht es mit [Projekt 2: LLM-Wiki](../projekt-2-llm-wiki/Anforderungen.md).

---

## Tipps

- Führt die Zellen im Notebook **der Reihe nach** aus.
- **Keine Verbindung zu Ollama?** Prüft, ob das Ollama-Symbol unten rechts in der Taskleiste zu sehen ist. Wenn nicht, Ollama über das Startmenü starten.
- **Fehler `unauthorized`?** Ihr seid nicht bei Ollama angemeldet: `ollama signin` im Terminal ausführen.
- Schlechte Antworten liegen oft **nicht am LLM**, sondern an schlecht extrahiertem Text oder unpassenden Chunks. Schaut euch deshalb zuerst an, was gefunden wurde.

**Viel Erfolg!**
