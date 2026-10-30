# Hinweise für Ausbildende

## Aufbau

- Jede Aufgabe hat eine `Anforderungen.md` (User Story, Ziel, Schritte, „Fertig, wenn …“) und ein Arbeitsnotebook. Im Notebook sind Gerüste vorgegeben, die Lücken sind mit `TODO` markiert.
- Die SQL-Notebooks lassen sich im Ausgangszustand mit **Run All** fehlerfrei ausführen. Übungszellen enthalten einen Platzhalter `SELECT 'TODO: ...'`.

## Lösungen und Selbstkontrolle

- **SQL Teil 0:** Unter jeder Übung steht das erwartete Ergebnis.
- **SQL Teil 1:** Die Musterlösung liegt offen in `01-sql/referenz/`. Wer das vermeiden will, nimmt den Ordner vor der Weitergabe heraus. Dann funktioniert allerdings Variante B in Teil 2 nicht mehr.
- **SQL Teil 2:** Zu jeder Aufgabe gibt es einen Kontrollwert für die Referenzdatenbank. `referenz/setup.sql` erzeugt bei jedem Lauf **dieselben** Daten, die Kontrollwerte bleiben also gültig. Ausformulierte SQL-Lösungen sind nicht im Repository.
- **KI:** Es gibt keine Musterlösungen. Die Azubis legen ihre Testfragen selbst fest, bevor sie programmieren, und messen sich daran.

## Daten der Azubis

`.gitignore` schließt eigene Datenbanken, eigene PDFs und das LLM-Wiki aus. So landen keine persönlichen oder urheberrechtlich geschützten Inhalte versehentlich in einem öffentlichen Repository.

## KI-Teil

- Das LLM `gpt-oss:20b-cloud` läuft in der Cloud von Ollama. Jede Frage und jedes gefundene Textstück wird dorthin geschickt. Die Anleitungen weisen darauf hin, dass keine internen oder personenbezogenen Daten verwendet werden dürfen.
- Für das Cloud-Modell braucht jede Person ein Ollama-Konto. Klärt vorab, ob private Konten genutzt werden sollen oder ein gemeinsames.
- Das LLM-Wiki ist als **Fortgeschritten** markiert und eignet sich eher ab dem 2. Ausbildungsjahr.

## Neue Aufgaben ergänzen

Im selben Stil: `Anforderungen.md` mit User Story, Niveau, Dauer, Phasen mit „Fertig, wenn …“ und ein Notebook mit vorgegebenen Imports, Gerüsten und `TODO`-Markierungen. Fachbegriffe ins Glossar in `02-ki/README.md` bzw. nach `01-sql/0-einstieg/grundlagen.md`.
