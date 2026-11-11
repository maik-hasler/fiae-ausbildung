# Hinweise für Ausbildende

## Aufbau

- Jede Aufgabe hat eine `Anforderungen.md` (User Story, Ziel, Schritte, „Fertig, wenn …“) und ein Arbeitsnotebook. Im Notebook sind Gerüste vorgegeben, die Lücken sind mit `TODO` markiert.
- Die SQL-Notebooks lassen sich im Ausgangszustand mit **Run All** fehlerfrei ausführen. Übungszellen enthalten einen Platzhalter `SELECT 'TODO: ...'`.
- Die SQL-Teile folgen dem Prinzip **erst stolpern, dann verstehen**: Die Azubis stellen ein Problem selbst nach (falsche Zeilenzahl, Widersprüche in den Daten, Gold aus dem Nichts, …). Erst danach kommen Werkzeug und Fachbegriff.

## Lösungen und Selbstkontrolle

- **SQL Teil 0:** Unter jeder Übung steht das erwartete Ergebnis.
- **SQL Teil 1:** Erwartete Ergebnisse und eine Kontrollzelle. Die Auflösungen (Abhängigkeiten, Zielbild) stehen in aufklappbaren Blöcken direkt im Notebook. Achtet darauf, dass die Azubis erst einen eigenen Vorschlag machen.
- **SQL Teil 2:** Die Musterlösung liegt offen in `01-sql/referenz/`. Wer das vermeiden will, nimmt den Ordner vor der Weitergabe heraus. Dann funktionieren allerdings Teil 3, 4 und 5 nicht mehr.
- **SQL Teil 3:** Zu jeder Aufgabe gibt es einen Kontrollwert für die Referenzdatenbank. `referenz/setup.sql` erzeugt bei jedem Lauf **dieselben** Daten, die Kontrollwerte bleiben also gültig. Ausformulierte SQL-Lösungen sind nicht im Repository.
- **SQL Teil 4:** Erwartete Ergebnisse stehen bei den Übungen. Sie gelten, wenn die Tickets der Reihe nach bearbeitet werden. Die Setup-Zelle setzt die Datenbank bei jedem Lauf zurück.
- **SQL Teil 5:** Keine Musterlösung, die Azubis wählen ihr Feature selbst. Bewertet wird mit der Checkliste in `5-erweiterung/Anforderungen.md`, die auch für das gegenseitige Review dient. Lasst euch das Feature vor dem Modellieren kurz vorstellen: Es sollte mindestens zwei neue Tabellen und eine Beziehung zu bestehenden Tabellen haben.
- **Gewollte Fehler:** In allen SQL-Teilen außer Teil 3 sollen einige Übungen mit einer Fehlermeldung enden, zum Beispiel beim Testen von Regeln. Das steht jeweils dabei.
- **KI:** Es gibt keine Musterlösungen. Die Azubis legen ihre Testfragen selbst fest, bevor sie programmieren, und messen sich daran.

## Hinweis für laufende Gruppen

Die SQL-Teile wurden neu nummeriert: „Datenbank entwerfen“ liegt jetzt in `01-sql/2-datenbank-entwerfen/`, „Abfragen“ in `01-sql/3-abfragen/`. Wer den Entwurf schon bearbeitet hat, verschiebt seine `meine_mmo.db` aus dem alten Ordner `01-sql/1-datenbank-entwerfen/` in den neuen. Sonst findet die optionale eigene Datenbank in Teil 3 keine Tabellen. Die Datei ist von `.gitignore` ausgeschlossen und wird deshalb beim Aktualisieren nicht mitverschoben.

## Prüfungsrelevanz

Der SQL-Teil deckt die Datenbankthemen ab, die in den Abschlussprüfungen für Fachinformatiker*innen typischerweise vorkommen:

| Thema | Teil |
|-------|------|
| ER-Modell, Kardinalitäten, Notationen (Chen, (min,max), Krähenfuß) | 2, Glossar |
| Normalformen 1–3, Anomalien, funktionale Abhängigkeit | 1 |
| DDL, DML, DQL, Joins, Aggregatfunktionen, Unterabfragen | 0, 2, 3 |
| Kartesisches Produkt, `CASE`, `UNION`, `EXISTS` | 0, 3 |
| Index, View, Trigger, Transaktion/ACID | 4 |
| DCL (`GRANT`/`REVOKE`), Stored Procedures | 4, nur als Theorie (SQLite kann beides nicht) |
| SQL-Injection, Datenschutz, Datensicherung | 4 |
| Datenbank um ein Feature erweitern, Migration | 5 |

Prüft im Zweifel den aktuellen Prüfungskatalog eurer IHK.

## Daten der Azubis

`.gitignore` schließt eigene Datenbanken, eigene PDFs und das LLM-Wiki aus. So landen keine persönlichen oder urheberrechtlich geschützten Inhalte versehentlich in einem öffentlichen Repository.

## KI-Teil

- Das LLM `gpt-oss:20b-cloud` läuft in der Cloud von Ollama. Jede Frage und jedes gefundene Textstück wird dorthin geschickt. Die Anleitungen weisen darauf hin, dass keine internen oder personenbezogenen Daten verwendet werden dürfen.
- Für das Cloud-Modell braucht jede Person ein Ollama-Konto. Klärt vorab, ob private Konten genutzt werden sollen oder ein gemeinsames.
- Das LLM-Wiki ist als **Fortgeschritten** markiert und eignet sich eher ab dem 2. Ausbildungsjahr.

## Neue Aufgaben ergänzen

Im selben Stil: `Anforderungen.md` mit User Story, Niveau, Phasen mit „Fertig, wenn …“ und ein Notebook mit vorgegebenen Imports, Gerüsten und `TODO`-Markierungen. Fachbegriffe ins Glossar in `02-ki/README.md` bzw. nach `01-sql/0-einstieg/grundlagen.md`.
