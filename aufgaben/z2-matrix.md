# Zusatz 2: Matrix – mehrere Python-Versionen

[Zurück zur Übersicht](../README.md)

## Ziel

„Bei mir läuft’s“ – aber auf dem Server läuft eine andere Python-Version? Mit einer **Matrix** testest du mehrere Versionen gleichzeitig, ohne den Job dreimal abzuschreiben.

## Aufgabe

Lass den Job `test` für die Python-Versionen **3.12, 3.13 und 3.14** laufen.

## Geschafft, wenn …

- im Run drei Test-Jobs nebeneinander stehen, z. B. `test (3.12)`, `test (3.13)`, `test (3.14)`,
- alle drei grün sind.

## Achtung, Ruleset

Mit einer Matrix heißen die Checks nicht mehr `test`, sondern `test (3.12)` usw. Der Pflicht-Check `test` aus Aufgabe 6 läuft dann nie mehr – und Pull Requests bleiben blockiert. Passe das Ruleset an und wähle die neuen Check-Namen aus.

<details>
<summary>Tipp 1: <code>strategy.matrix</code></summary>

Unter dem Job legst du `strategy:` → `matrix:` an und definierst eine Variable mit einer Liste von Werten. Im Job greifst du mit `${{ matrix.<name> }}` darauf zu. [GitHub: Matrix verwenden](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/run-job-variations)

</details>

<details>
<summary>Tipp 2: Gerüst</summary>

```yaml
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python: ['3.12', '3.13', '3.14']
    steps:
      - uses: actions/checkout@v7
      - uses: actions/setup-python@... # v7.1.0
        with:
          python-version: ${{ matrix.python }}
      # ...
```

Versionsnummern immer in Anführungszeichen – sonst macht YAML aus `3.10` die Zahl `3.1`.

</details>
