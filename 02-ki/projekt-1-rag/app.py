"""Weboberfläche für euer RAG (Phase 6).

Starten im Hauptordner:
    .venv\\Scripts\\streamlit run 02-ki/projekt-1-rag/app.py
"""
import os

import streamlit as st

os.environ["NO_PROXY"] = "localhost,127.0.0.1"
os.environ["USER_AGENT"] = "ausbildung-uebungen"


@st.cache_resource
def vektorspeicher_aufbauen():
    """Läuft nur beim ersten Start, danach merkt sich Streamlit das Ergebnis."""
    # TODO: Code aus dem Notebook übernehmen: Dokumente laden, in Chunks teilen,
    #       Qdrant einrichten, Chunks speichern. Den Vektorspeicher zurückgeben.
    #       Achtung: Pfade wie "data" beziehen sich hier auf den Hauptordner,
    #       also "02-ki/projekt-1-rag/data".
    return None


def fragen(frage):
    # TODO: Eure Funktion fragen() aus dem Notebook übernehmen.
    return "TODO: Hier kommt die Antwort eures RAG."


st.title("Mein RAG")
vektorspeicher = vektorspeicher_aufbauen()

if "verlauf" not in st.session_state:
    st.session_state.verlauf = []

for rolle, text in st.session_state.verlauf:
    st.chat_message(rolle).write(text)

frage = st.chat_input("Stellt eine Frage zu euren Dokumenten")
if frage:
    st.chat_message("user").write(frage)
    antwort = fragen(frage)
    st.chat_message("assistant").write(antwort)
    st.session_state.verlauf += [("user", frage), ("assistant", antwort)]
