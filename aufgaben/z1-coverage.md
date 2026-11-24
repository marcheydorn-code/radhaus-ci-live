# Zusatz 1: Coverage als Gate

[Zurück zur Übersicht](../README.md)

## Ziel

Coverage misst, welche Zeilen des Programms beim Testen überhaupt ausgeführt wurden. Du lässt die Pipeline rot werden, wenn die Abdeckung unter eine Schwelle fällt – und lernst, den Bericht zu lesen.

## Aufgabe

1. Ändere im Job `test` den Testbefehl so, dass `pytest` zusätzlich die Abdeckung des Pakets `shop` misst, die **nicht abgedeckten Zeilennummern** anzeigt und **unter 90 %** scheitert. Das Werkzeug `pytest-cov` ist schon in `requirements-dev.txt`.
2. Der Lauf wird **rot**. Lies im Log die Coverage-Tabelle: Welche Zeilen in `shop/versand.py` sind nicht abgedeckt? Schau sie dir im Code an.
3. Entscheide: Sind das Zeilen, die getestet werden **müssten** – oder Zeilen, die man bewusst von der Messung ausnimmt? Setze deine Entscheidung um, **ohne die Schwelle zu senken**.

## Geschafft, wenn …

- im Log eine Coverage-Tabelle mit Spalte `Missing` steht,
- der Check grün ist und die Gesamtabdeckung über 90 % liegt,
- du begründen kannst, warum deine Lösung in Ordnung ist.

## Fragen zum Nachdenken

- Der 50-€-Fehler aus Aufgabe 3 hatte **volle** Coverage. Wie kann das sein?
- Was sagt Coverage aus – und was nicht?

<details>
<summary>Tipp 1: Optionen von pytest-cov</summary>

Gesucht sind drei Optionen: welches Paket gemessen wird, wie der Bericht aussieht und welche Mindestabdeckung gilt. [pytest-cov: Konfiguration](https://pytest-cov.readthedocs.io/en/latest/config.html) · [pytest-cov: Berichte](https://pytest-cov.readthedocs.io/en/latest/reporting.html)

</details>

<details>
<summary>Tipp 2: Befehl</summary>

```bash
python -m pytest -q --cov=shop --cov-report=term-missing --cov-fail-under=90
```

</details>

<details>
<summary>Tipp 3: Welche Zeilen fehlen?</summary>

Die fehlenden Zeilen sind der Block ganz unten in `shop/versand.py`, der mit `if __name__ == "__main__":` beginnt. Er läuft nur, wenn man die Datei direkt startet (wie im Job `startcheck`), aber nie in den Tests. Solche Startblöcke nimmt man üblicherweise von der Messung aus.

Das geht ohne Python-Code, nur mit einer Konfigurationsdatei `pyproject.toml` im Hauptverzeichnis und der Einstellung `exclude_also` im Abschnitt `[tool.coverage.report]`. [coverage.py: Code ausschließen](https://coverage.readthedocs.io/en/latest/excluding.html)

</details>
