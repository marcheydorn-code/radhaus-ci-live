# Radhaus bekommt CI

Übung zu Abend 1 von „Einführung CI/CD Pipelines“.

Radhaus ist ein kleiner Online-Shop für Fahrradteile. Bisher wird nichts automatisch geprüft – und prompt hat sich ein Fehler eingeschlichen: Wer **genau 50,00 €** bestellt, zahlt trotzdem Versand. In dieser Übung baust du Schritt für Schritt eine CI-Pipeline mit GitHub Actions, die genau solche Fehler findet, bevor sie die Kundschaft erreichen.

**Du programmierst kein Python.** Programm und Tests sind fertig. Du schreibst Workflow-Dateien (YAML), liest Logs, änderst später eine einzige Stelle im Programm und richtest Regeln in GitHub ein.

## Was das Programm tun soll

`shop/versand.py` berechnet Versandkosten für einen Warenwert in Euro:

| Warenwert | Versandkosten |
|---|---:|
| Unter 50,00 € | 4,90 € |
| Ab 50,00 € einschließlich | 0,00 € |
| Negativ | Fehler (`ValueError`) |

Die Tests in `tests/test_versand.py` beschreiben genau diese Regeln.

## Dateien

```text
README.md                 diese Anleitung
aufgaben/                 die Aufgaben, eine Datei pro Schritt
shop/versand.py           fertiges Programm – mit einem absichtlichen Fehler
tests/test_versand.py     fertige Tests
requirements-dev.txt      Werkzeuge: pytest, pytest-cov, ruff
infra/main.tf             kleines Terraform-Projekt für eine Zusatzaufgabe
```

Es gibt **noch keinen** Ordner `.github/workflows/`. Den legst du selbst an.

## Los geht’s: eigenes Repository anlegen

Du brauchst ein [GitHub-Konto](https://github.com/signup). Arbeite in einem **eigenen, öffentlichen** Repository – nur dann sind Rulesets und Actions-Minuten kostenlos.

**Weg 1 – Vorlage (empfohlen, nur Browser):** Oben auf dieser Seite (`MartinCloudHelden/radhaus-ci`) **Use this template → Create a new repository** wählen, Sichtbarkeit **Public**. [GitHub: Repository aus Vorlage erstellen](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)

**Weg 2 – Klonen und eigenes `origin`:** Lege auf GitHub ein **leeres**, öffentliches Repository an (ohne README, ohne `.gitignore`), dann:

```bash
git clone https://github.com/MartinCloudHelden/radhaus-ci.git
cd radhaus-ci
git remote set-url origin https://github.com/DEIN-NAME/radhaus-ci.git
git push -u origin main
```

Alle Aufgaben lassen sich im Browser lösen. Tipp: Drückst du im Repository die Taste `.`, öffnet sich ein Editor im Browser ([github.dev](https://docs.github.com/en/codespaces/the-githubdev-web-based-editor)).

## Ablauf

| Nr. | Aufgabe | Zeit | Thema aus den Folien |
|---|---|---|---|
| 1 | [Erster Workflow](aufgaben/01-erster-workflow.md) | 10 Min | Event, Workflow, Job, Runner, Step |
| 2 | [Die CI-Pipeline](aufgaben/02-ci-pipeline.md) | 15 Min | `checkout`, `setup-python`, Tests, Rot ist gut |
| 3 | [Fehler beheben per Pull Request](aufgaben/03-fehler-beheben.md) | 15 Min | Run lesen, Pull Request, Checks |
| 4 | [Zweiter Job und `needs`](aufgaben/04-jobs-und-needs.md) | 15 Min | Parallele Jobs, Gates |
| 5 | [Rechte begrenzen und Actions pinnen](aufgaben/05-rechte-und-pinning.md) | 10 Min | `permissions`, Lieferkette, SHA |
| 6 | [Ruleset für `main`](aufgaben/06-ruleset.md) | 15 Min | Regeln erzwingen, Pflicht-Check |

**Zusatzaufgaben** für alle, die früher fertig sind – in beliebiger Reihenfolge:

| Nr. | Aufgabe | Thema |
|---|---|---|
| Z1 | [Coverage als Gate](aufgaben/z1-coverage.md) | Testabdeckung |
| Z2 | [Matrix: mehrere Python-Versionen](aufgaben/z2-matrix.md) | Matrix |
| Z3 | [Nächtlicher Lauf](aufgaben/z3-zeitplan.md) | `schedule`, Cron, UTC |
| Z4 | [Dependabot für Actions](aufgaben/z4-dependabot.md) | Updates als Pull Request |
| Z5 | [Terraform prüfen](aufgaben/z5-terraform.md) | Infrastruktur als Code in CI |

Jede Aufgabe hat einen Abschnitt **„Geschafft, wenn …“** und aufklappbare **Tipps**. Versuch es zuerst ohne – die Tipps verraten Schritt für Schritt mehr. Die Links zur GitHub-Dokumentation sind ausdrücklich zum Benutzen da.

## Wenn etwas nicht funktioniert

| Beobachtung | Prüfe zuerst |
|---|---|
| Im Tab **Actions** erscheint kein Run | Liegt die Datei exakt unter `.github/workflows/` (mit Punkt, mit **s**)? Endet sie auf `.yml`? Ist `on:` richtig eingerückt? |
| „Invalid workflow file“ | YAML-Einrückung (nur Leerzeichen, keine Tabs), Doppelpunkte, Schreibweise von `jobs`, `runs-on`, `steps`, `uses`, `run`. Die Fehlermeldung nennt die Zeile. |
| `ModuleNotFoundError: pytest` | Läuft `python -m pip install -r requirements-dev.txt` **vor** dem Test-Step? |
| `ModuleNotFoundError: shop` oder Datei nicht gefunden | Ist `actions/checkout` der erste Step? Ohne ihn ist der Runner leer. |
| Pull-Request-Run startet nicht | Zielt der PR auf `main` deines **eigenen** Repositorys? Steht `pull_request` unter `on:`? |

Hilfreich: [GitHub: Workflow-Syntax](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax) · [GitHub: Logs von Workflow-Runs](https://docs.github.com/en/actions/how-tos/monitor-workflows/use-workflow-run-logs) · [YAML lernen](https://www.yaml.info/learn/index.html)

## Optional: lokal ausprobieren

Mit Python 3.13 kannst du die Tests auch auf deinem Rechner starten (unter Windows heißt der Befehl oft `py -3.13`):

```bash
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\Activate.ps1
python -m pip install -r requirements-dev.txt
python -m pytest -q
```

Für die Übung reicht der Run auf GitHub.

## Sicherheit

Diese Übung braucht **keine Secrets**. Trage nie Passwörter oder Tokens in Workflow-Dateien ein. Ein grüner Run heißt nur: Die definierten Prüfungen sind bestanden – nicht, dass das Programm fehlerfrei ist.
