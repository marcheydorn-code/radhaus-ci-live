# Aufgabe 4: Zweiter Job und `needs`

⏱ ca. 15 Minuten · [Zurück zur Übersicht](../README.md)

## Ziel

Eine Pipeline besteht meist aus mehreren Jobs. Manche laufen **parallel**, andere warten auf ihre Vorgänger – das sind die **Gates** aus den Folien. Du erweiterst `ci.yml` um eine Stilprüfung und einen Startcheck, der nur läuft, wenn alles andere grün ist.

## Aufgabe

Ergänze in `.github/workflows/ci.yml` zwei weitere Jobs neben `test`:

1. **`lint`** – prüft den Code-Stil mit dem Werkzeug [ruff](https://docs.astral.sh/ruff/):
   - gleiche ersten drei Steps wie bei `test` (Code holen, Python 3.13, `pip install -r requirements-dev.txt`),
   - danach `ruff check .`
2. **`startcheck`** – startet das Programm einmal, um zu sehen, ob es überhaupt läuft:
   - Code holen, Python 3.13 einrichten,
   - `python -m shop.versand`
   - Dieser Job darf **erst starten, wenn `test` und `lint` beide grün sind.**

Arbeite wieder über einen Branch und einen Pull Request – so siehst du alle drei Checks direkt am PR.

## Geschafft, wenn …

- in der Run-Übersicht `test` und `lint` **gleichzeitig** laufen und `startcheck` danach,
- im Log von `startcheck` der Gesamtpreis für 50,00 € steht – und zwar **50.00 EUR**,
- alle drei Checks am Pull Request grün sind.

## Ausprobieren

Mach einen zweiten Branch, in dem du in `tests/test_versand.py` absichtlich einen erwarteten Wert falsch einträgst (z. B. `"4.90"` → `"5.90"`). Öffne einen PR, aber merge ihn **nicht**. Was passiert mit `startcheck`? Schließe den PR danach wieder.

<details>
<summary>Tipp 1: Jobs laufen standardmäßig parallel</summary>

Alle Jobs unter `jobs:` starten gleichzeitig, jeder auf seinem eigenen, frischen Runner. Du musst für `lint` also nichts Besonderes tun – nur einen weiteren Job auf derselben Einrückungsebene wie `test` anlegen.

</details>

<details>
<summary>Tipp 2: Warten mit <code>needs</code></summary>

Mit `needs:` sagst du, auf welche Jobs ein Job warten soll. Mehrere Jobs gibst du als Liste an: `needs: [test, lint]`. Ist einer davon rot, wird der wartende Job übersprungen. [GitHub: `jobs.<job_id>.needs`](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idneeds)

</details>

<details>
<summary>Tipp 3: Gerüst</summary>

```yaml
jobs:
  test:
    # ... wie bisher

  lint:
    runs-on: ubuntu-latest
    steps:
      # Code holen, Python, pip install
      - run: ruff check .

  startcheck:
    needs: # ...
    runs-on: ubuntu-latest
    steps:
      # Code holen, Python
      - run: python -m shop.versand
```

</details>

## Doku

- [GitHub: Jobs in einem Workflow](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-jobs)
- [GitHub: `needs`](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idneeds)
- [ruff: Linter](https://docs.astral.sh/ruff/linter/)
