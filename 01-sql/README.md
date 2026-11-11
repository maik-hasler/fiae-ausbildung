# SQL

Übungen zu Datenbankentwurf und SQL am Beispiel eines Online-Rollenspiels (MMO). Datenbank: **SQLite**, gearbeitet wird in **Jupyter-Notebooks** mit der Erweiterung **JupySQL**.

Vorher das [Setup im Hauptordner](../README.md#setup) erledigen.

## Lernpfad

| # | Was | Inhalt |
|---|-----|--------|
| 0 | [Einstieg](0-einstieg/einstieg.ipynb) | SQL-Grundlagen an einer kleinen Bücherei-Datenbank, mit Kontrollergebnissen. Dabei: das kartesische Produkt selbst entdecken. Begriffe in [grundlagen.md](0-einstieg/grundlagen.md). |
| 1 | [Anomalien und Normalformen](1-normalisierung/Anforderungen.md) | Eine Excel-artige Gildenliste bearbeiten, an Anomalien scheitern, dann selbst normalisieren |
| 2 | [Datenbank entwerfen](2-datenbank-entwerfen/Anforderungen.md) | Aus fachlichen Anforderungen das ganze ER-Modell entwerfen, einen Ausschnitt mit allen Beziehungsarten und Constraints anlegen und testen |
| 3 | [Abfragen](3-abfragen/abfragen.ipynb) | 26 Aufgaben von leicht bis knifflig auf der Referenzdatenbank. Am Ende typische Fallen (vergessene Join-Bedingung, Fan-out) sowie `CASE`, `UNION` und `EXISTS`. |
| 4 | [Live-Betrieb](4-live-betrieb/Anforderungen.md) | Acht Tickets aus dem laufenden Spiel: Index, Eindeutigkeit, Transaktion, View und Rechte, Trigger, SQL-Injection, DSGVO-Löschung, Backup |
| 5 | [Eigene Erweiterung](5-erweiterung/Anforderungen.md) | Selbst gewähltes Feature von der Idee bis zur Migration der laufenden Datenbank, mit Review |
| | [Referenz](referenz/README.md) | Musterlösung des Datenmodells und Skript mit vielen Testdaten. **Erst nach Teil 2 öffnen.** |

Das Prinzip in allen Teilen: **erst das Problem erleben, dann das Werkzeug kennenlernen.** Die Fachbegriffe kommen, nachdem man gesehen hat, wofür man sie braucht.

## Werkzeuge

- **Datenbank ansehen:** VS-Code-Erweiterung *SQLite Viewer*. Danach `.db`-Dateien im Explorer anklicken.
- **ER-Diagramme ansehen:** VS-Code-Erweiterung *Markdown Preview Mermaid Support*, dann in einer `.md`-Datei `Strg + Umschalt + V`.
