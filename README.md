# Übungsaufgaben für Auszubildende

Praktische Aufgaben für die IT-Ausbildung: Datenbanken mit SQL und KI mit Large Language Models.

## Lernpfad

| Bereich | Aufgabe | Niveau | Dauer |
|---------|---------|--------|-------|
| [SQL](01-sql/README.md) | 0. Einstieg: SQL-Grundlagen an einer Bücherei-Datenbank | Einstieg | 1 Tag |
| | 1. Datenbank für ein Online-Rollenspiel **selbst entwerfen** und mit eigenen Daten füllen | Einstieg | 3 Tage |
| | 2. 20 SQL-Abfragen auf der eigenen Datenbank und der Referenz | Einstieg bis mittel | 2 Tage |
| [KI](02-ki/README.md) | 1. Eigenes RAG: selbst gewählte Dokumente für ein LLM nutzbar machen | Einstieg | 4–5 Tage |
| | 2. LLM-Wiki: dem LLM ein eigenes Gedächtnis bauen | Fortgeschritten | 4–5 Tage |

Die Bereiche SQL und KI sind unabhängig voneinander. Innerhalb eines Bereichs bauen die Aufgaben aufeinander auf. Die Zeitangaben sind Richtwerte.

## Struktur

```
ausbildung-uebungen/
├── 01-sql/
│   ├── 0-einstieg/              # SQL-Grundlagen mit Kontrollergebnissen
│   ├── 1-datenbank-entwerfen/   # Anforderungen → ER-Modell → Tabellen → eigene Daten
│   ├── 2-abfragen/              # 20 Abfragen von leicht bis knifflig
│   └── referenz/                # Musterlösung des Datenmodells + Testdaten
└── 02-ki/
    ├── projekt-1-rag/           # Eigenes RAG mit selbst gewählten Quellen
    └── projekt-2-llm-wiki/      # Eigenes Gedächtnis als Wiki
```

## Setup

Das Setup ist für **Windows** beschrieben. Alle Befehle werden im **Hauptordner** `ausbildung-uebungen` ausgeführt.

### 1. Software installieren

| Software | Download | Hinweis |
|----------|----------|---------|
| Python 3.13 | https://www.python.org/downloads/ | Bei der Installation **„Add python.exe to PATH“ anhaken**! |
| VS Code | https://code.visualstudio.com/download | |
| Ollama | https://ollama.com/download/windows | nur für den KI-Teil |

### 2. Ordner in VS Code öffnen

**Datei → Ordner öffnen…** und den Ordner `ausbildung-uebungen` wählen. Wichtig ist genau dieser Ordner, nicht ein Unterordner, sonst findet VS Code die Python-Umgebung später nicht.

Diese Erweiterungen installieren (links in der Leiste auf das Symbol mit den vier Quadraten klicken und nach dem Namen suchen):

| Erweiterung | Wofür |
|-------------|-------|
| **Python** | Python-Unterstützung |
| **Jupyter** | Notebooks (`.ipynb`) |
| **SQLite Viewer** | Datenbanken (`.db`) ansehen |
| **Markdown Preview Mermaid Support** | ER-Diagramme in Markdown anzeigen |

### 3. Python-Umgebung anlegen

**Terminal → Neues Terminal** öffnen und prüfen, ob Python gefunden wird:

```powershell
python --version
```

Es muss `Python 3.13...` erscheinen. Öffnet sich stattdessen der Microsoft Store, wurde bei der Installation „Add python.exe to PATH“ nicht angehakt. Dann Python noch einmal installieren und den Haken setzen.

Umgebung anlegen und Pakete installieren:

```powershell
python -m venv .venv
```

```powershell
.venv\Scripts\python -m pip install -r 01-sql/requirements.txt
```

```powershell
.venv\Scripts\python -m pip install -r 02-ki/requirements.txt
```

Die zweite Installation braucht ihr nur für den KI-Teil.

**Fehler mit `ProxyError` oder Zeitüberschreitung?** Euer Netzwerk nutzt einen Proxy. Fragt eure IT nach den Proxy-Einstellungen für `pip`.

### 4. Notebook öffnen und Kernel wählen

Ein Notebook (`.ipynb`) öffnen, oben rechts auf **Kernel auswählen** klicken → **Python-Umgebungen** → `.venv` wählen. Das ist pro Notebook nur einmal nötig.

### 5. Ollama einrichten (nur KI)

Ollama startet nach der Installation automatisch und läuft im Hintergrund (Symbol unten rechts in der Taskleiste).

1. Auf https://ollama.com ein kostenloses Konto anlegen.
2. Im Terminal anmelden. Das ist nötig, weil das LLM nicht auf eurem Rechner läuft, sondern in der Cloud von Ollama:
   ```powershell
   ollama signin
   ```
3. Modelle holen:
   ```powershell
   ollama pull embeddinggemma:300m
   ```
   ```powershell
   ollama pull gpt-oss:20b-cloud
   ```
   Das Embedding-Modell wird heruntergeladen und läuft auf eurem Rechner. Das LLM `gpt-oss:20b-cloud` wird nur eingetragen und läuft auf den Servern von Ollama.
4. Testen:
   ```powershell
   ollama run gpt-oss:20b-cloud "Sag Hallo"
   ```

Die Cloud-Nutzung ist beim kostenlosen Konto pro Stunde und pro Woche begrenzt. Ist die Grenze erreicht, kommt eine Fehlermeldung. Dann etwas später weitermachen.

## Arbeitsweise

- Arbeitet in einer **eigenen Kopie** des Repositorys (z. B. als Fork) und speichert eure Arbeit regelmäßig mit Git.
- Eure Notebooks und Markdown-Dateien werden mit hochgeladen. **Nicht** hochgeladen werden eure Datenbanken (`*.db`), eure PDFs in `02-ki/projekt-1-rag/data/` und das Wiki aus Projekt 2. Die lassen sich jederzeit aus den Notebooks neu erzeugen.
- Jede Aufgabe hat einen Abschnitt **„Fertig, wenn …“**. Ist alles abgehakt, stellt ihr euer Ergebnis vor.

## Lizenz

Public Domain (Unlicense), siehe [LICENSE](LICENSE). Das Beispiel-PDF in `02-ki/projekt-1-rag/beispiel/` ist frei erfunden.

Hinweise für Ausbildende stehen in [AUSBILDUNG.md](AUSBILDUNG.md).
