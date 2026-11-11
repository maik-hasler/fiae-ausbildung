# KI

Projekte rund um Large Language Models (LLMs) mit **Ollama** und **LangChain** in Python.

Vorher das [Setup im Hauptordner](../README.md#setup) erledigen, inklusive des Abschnitts zu Ollama.

## Projekte

| # | Projekt | Inhalt | Niveau |
|---|---------|--------|--------|
| 1 | [Eigenes RAG](projekt-1-rag/Anforderungen.md) | Eigene Dokumente sammeln (selbst erstellte PDFs, Internet-Quellen), für das LLM nutzbar machen und Fragen dazu beantworten lassen | Einstieg |
| 2 | [LLM-Wiki](projekt-2-llm-wiki/Anforderungen.md) | Dem LLM ein eigenes Gedächtnis aus Markdown-Seiten bauen, das es selbst pflegt und durchsucht | Fortgeschritten |

Projekt 2 baut auf Projekt 1 auf.

## Glossar

| Begriff | Erklärung |
|---------|-----------|
| **LLM** (Large Language Model) | Ein KI-Modell, das Text versteht und erzeugt, z. B. `gpt-oss`. Es kennt nur das, womit es trainiert wurde. |
| **Prompt** | Der Text, den man an das LLM schickt: Anweisung, Frage und ggf. zusätzliche Informationen. |
| **Kontext** | Zusätzliche Informationen im Prompt, auf die sich das LLM bei der Antwort stützen soll. |
| **Temperatur** | Wie „kreativ“ das LLM antwortet. `0` heißt: möglichst gleiche Antworten auf gleiche Fragen, gut zum Testen. |
| **Token** | Ein Wortstück. LLMs rechnen in Tokens, Prompt und Antwort sind dadurch begrenzt. |
| **Halluzination** | Das LLM erfindet eine Antwort, die überzeugend klingt, aber falsch ist. |
| **Embedding** | Ein Text, umgerechnet in eine lange Liste von Zahlen (einen **Vektor**). Texte mit ähnlicher Bedeutung bekommen ähnliche Zahlen. `embeddinggemma` liefert 768 Zahlen pro Text. |
| **Ähnlichkeitssuche** | Zu einer Frage die Texte finden, deren Embedding dem der Frage am ähnlichsten ist. |
| **Vektordatenbank** | Datenbank, die Embeddings speichert und schnell ähnliche findet, hier **Qdrant**. |
| **Collection** | Eine „Tabelle“ in der Vektordatenbank, z. B. eine pro Thema. |
| **Chunk** | Ein Textstück. Lange Dokumente werden in Chunks geteilt, damit nur die passenden Stücke im Prompt landen. |
| **Überlappung** (Overlap) | Wie viele Zeichen sich benachbarte Chunks teilen, damit kein Satz genau an der Grenze verloren geht. |
| **k** | Wie viele Chunks bei einer Suche zurückkommen. |
| **RAG** (Retrieval Augmented Generation) | Erst passende Chunks suchen (Retrieval), dann das LLM mit diesen Chunks antworten lassen (Generation). |
| **Strukturierte Ausgabe** | Das LLM antwortet nicht mit freiem Text, sondern in einem festen Format, das Python direkt weiterverarbeiten kann. |
| **LangChain** | Python-Bibliothek, die LLMs, Embeddings, Loader und Vektordatenbanken mit einheitlichen Befehlen ansteuert. |

## Ideen für weitere Projekte

Diese Vorschläge für weitere Aufgaben sind noch nicht ausgearbeitet:

| Idee | Worum geht's |
|------|--------------|
| Prompt-Engineering | Dieselbe Aufgabe mit verschiedenen Prompts lösen (Rolle, Beispiele, Format) und Ergebnisse vergleichen |
| Tool Calling | Das LLM ruft selbst Python-Funktionen auf (Taschenrechner, Uhrzeit, Wetter-API) |
| Text-to-SQL | Das LLM beantwortet Fragen in natürlicher Sprache zur MMO-Datenbank aus dem [SQL-Teil](../01-sql/README.md) und schreibt die SQL-Abfrage dafür selbst |
| Klassifikation | Support-Tickets oder E-Mails automatisch einer Kategorie zuordnen und die Trefferquote messen |
| LLM als Prüfer | Ein LLM bewertet die Antworten eines anderen. Wie zuverlässig ist das? |
