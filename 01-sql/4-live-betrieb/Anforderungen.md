# SQL Teil 4: Live-Betrieb

**Voraussetzung:** [Teil 3: Abfragen](../3-abfragen/abfragen.ipynb)  
**Notebook:** [live-betrieb.ipynb](live-betrieb.ipynb)

## User Story

**Als** Auszubildende*r **möchte ich** typische Probleme einer Datenbank im laufenden Betrieb selbst nachstellen und lösen, **damit ich** Index, Transaktion, View, Trigger und Co. nicht nur als Begriffe kenne, sondern weiß, **wann** und **warum** man sie einsetzt.

---

## Projektübersicht

Das MMO ist online. Ihr arbeitet auf einer Kopie der Referenzdatenbank mit 5.000 Accounts, 15.000 Charakteren und 500.000 Logins. Jedes Ticket folgt demselben Muster:

1. **Problem nachstellen:** Ihr erlebt den Fehler selbst, mit echten Zahlen.
2. **Werkzeug kennenlernen:** Erst jetzt kommt die Lösung.
3. **Lösung anwenden und prüfen:** Ist das Problem wirklich weg?

| Ticket | Problem | Werkzeug | Niveau |
|--------|---------|----------|--------|
| 1 | Login-Historie lädt ewig | Index, `EXPLAIN QUERY PLAN` | ⭐⭐ |
| 2 | `Iron Vanguard` und `iron vanguard`, zwei Gildenleitungen | `UNIQUE`, `COLLATE NOCASE`, partieller Index | ⭐⭐ |
| 3 | Beim Handeln entsteht Gold aus dem Nichts | Transaktion, ACID | ⭐⭐ |
| 4 | Support soll keine Passwort-Hashes sehen | View, `GRANT`/`REVOKE` (DCL) | ⭐⭐ |
| 5 | Wer hat sich eine Million Gold gegeben? | Trigger | ⭐⭐⭐ |
| 6 | Login ohne Passwort | SQL-Injection, parametrisierte Abfragen | ⭐⭐ |
| 7 | Spieler*in verlangt Löschung der eigenen Daten | DSGVO, Löschkonzept | ⭐⭐⭐ |
| 8 | Alle Gilden versehentlich gelöscht | Backup, Wiederherstellung | ⭐⭐ |

Am Ende des Notebooks steht, was **Server-Datenbanken** zusätzlich können (Benutzer und Rechte, Stored Procedures) und wie sich **NoSQL** einordnen lässt.

---

## Aufgaben

### Tickets 1 bis 8

1. Arbeitet die Tickets der Reihe nach ab. Spätere Tickets bauen teils auf früheren auf: Ticket 7 nutzt die Tabelle `gold_log` aus Ticket 5.
2. Beantwortet die Fragen in den Antwortzellen in eigenen Worten.
3. Vergleicht eure Ergebnisse mit den **erwarteten Ergebnissen** im Notebook.

**Fertig, wenn:** jedes Ticket gelöst ist und die erwarteten Ergebnisse passen.

### Zum Abschluss: Spickzettel

Schreibt **ohne** ins Notebook zu schauen für jedes Werkzeug zwei bis drei Sätze:

- Welches Problem löst es?
- Woran erkenne ich, dass ich es brauche?
- Was kostet es, oder worauf muss ich achten?

Vergleicht eure Spickzettel danach untereinander.

**Fertig, wenn:** der Spickzettel alle Werkzeuge aus der Tabelle oben enthält.

---

## Fertig, wenn …

- [ ] alle acht Tickets gelöst sind,
- [ ] ihr erklären könnt, warum ein Index Lesen schneller und Schreiben langsamer macht,
- [ ] ihr die vier Buchstaben von ACID an einem eigenen Beispiel erklären könnt,
- [ ] ihr DDL, DML, DQL und DCL je einem Befehl zuordnen könnt,
- [ ] euer Spickzettel fertig ist.

---

## Ressourcen

| Thema | Link |
|-------|------|
| Begriffe zum Nachschlagen | [grundlagen.md](../0-einstieg/grundlagen.md) |
| SQLite: Indexe (Englisch) | https://www.sqlite.org/lang_createindex.html |
| SQLite: Trigger (Englisch) | https://www.sqlite.org/lang_createtrigger.html |
| SQLite: Transaktionen (Englisch) | https://www.sqlite.org/lang_transaction.html |

---

## Tipps

- **Neu anfangen:** Restart und Run All. Die Setup-Zelle setzt `live.db` jedes Mal auf den Anfangszustand zurück.
- **Gewollte Fehler:** Run All stoppt beim ersten Fehler. Führt Zellen mit gewollten Fehlern einzeln aus.
- **Offene Transaktion?** Wenn nach einem Fehler in einer Transaktion seltsame Dinge passieren, führt `ROLLBACK;` aus.
- Die Dateien `vorlage.db`, `live.db` und `backup.db` sind zusammen etwa 130 MB groß. Wer Platz braucht, löscht sie nach dem Teil. Beim nächsten Start werden sie neu gebaut.

Weiter geht's mit [Teil 5: Eigene Erweiterung](../5-erweiterung/Anforderungen.md).
