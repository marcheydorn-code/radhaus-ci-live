# Aufgabe 2: Die CI-Pipeline

⏱ ca. 15 Minuten · [Zurück zur Übersicht](../README.md)

## Ziel

Jetzt wird es ernst: Bei jeder Änderung sollen automatisch die vorhandenen Tests laufen. Du wirst sehen, dass die Pipeline sofort **rot** wird – und das ist richtig so. Sie hat einen echten Fehler im Programm gefunden.

## Aufgabe

Lege auf `main` die Datei `.github/workflows/ci.yml` an. Der Workflow soll

1. den Namen `CI` tragen,
2. bei `push` auf `main` **und** bei jedem `pull_request` mit Ziel `main` starten,
3. einen Job mit dem Namen **`test`** auf `ubuntu-latest` haben (der Name ist wichtig für Aufgabe 6),
4. diese Steps in dieser Reihenfolge ausführen:
   1. den Code holen mit der Action `actions/checkout`,
   2. Python **3.13** einrichten mit der Action `actions/setup-python`,
   3. `python -m pip install -r requirements-dev.txt`,
   4. `python -m pytest -q`.

Nimm für beide Actions die Major-Version `v7`.

Committe auf `main`, öffne den Run im Tab **Actions** und klappe den Test-Step auf.

## Geschafft, wenn …

- der Run `CI` **rot** ist und im Test-Step steht, welcher Test scheitert,
- du in eigenen Worten sagen kannst: **welcher** Warenwert, **welches** erwartete und **welches** tatsächliche Ergebnis.

Notiere dir das – du brauchst es in Aufgabe 3.

## Fragen zum Nachdenken

- Warum braucht es `actions/checkout`, obwohl der Workflow doch im Repository liegt?
- Welches Problem aus den Folien löst die feste Angabe `python-version: '3.13'`?

<details>
<summary>Tipp 1: Zwei Events mit Branch-Filter</summary>

Wenn ein Event zusätzliche Einstellungen braucht, schreibst du es nicht als Liste, sondern als eingerückten Block:

```yaml
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
```

[GitHub: Branch-Filter](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#onpushpull_requestpull_request_targetpathspaths-ignore)

</details>

<details>
<summary>Tipp 2: Actions mit <code>uses</code> und <code>with</code></summary>

Eine fertige Action bindest du mit `uses:` ein, z. B. `uses: actions/checkout@v7`. Einstellungen für eine Action stehen darunter in `with:`. Bei `setup-python` heißt die Einstellung `python-version`. Schau in die README der Action: [actions/setup-python](https://github.com/actions/setup-python#basic-usage).

Shell-Befehle schreibst du mit `run:`.

</details>

<details>
<summary>Tipp 3: Gerüst</summary>

```yaml
name: CI

on:
  # Tipp 1

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v7
      - uses: actions/setup-python@v7
        with:
          python-version: # ...
      - run: # Abhängigkeiten installieren
      - run: # Tests starten
```

</details>

## Doku

- [GitHub: Python bauen und testen](https://docs.github.com/en/actions/tutorials/build-and-test-code/python)
- [GitHub: Workflow-Syntax](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax)
- [actions/checkout](https://github.com/actions/checkout) · [actions/setup-python](https://github.com/actions/setup-python)
- [GitHub: Logs von Workflow-Runs](https://docs.github.com/en/actions/how-tos/monitor-workflows/use-workflow-run-logs)
