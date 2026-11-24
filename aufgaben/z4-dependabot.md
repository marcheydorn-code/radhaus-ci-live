# Zusatz 4: Dependabot für Actions

[Zurück zur Übersicht](../README.md)

## Ziel

Gepinnte Versionen sind sicher – aber sie veralten. **Dependabot** prüft regelmäßig, ob es neue Versionen gibt, und öffnet dafür einen Pull Request. Deine Pipeline testet das Update dann automatisch.

## Aufgabe

Lege die Datei `.github/dependabot.yml` an. Dependabot soll **wöchentlich** prüfen:

1. die **GitHub Actions** in deinen Workflows,
2. die **Python-Pakete** aus `requirements-dev.txt`.

## Geschafft, wenn …

- unter **Insights → Dependency graph → Dependabot** beide Einträge auftauchen und ohne Fehler geprüft wurden,
- falls es neuere Versionen gibt: ein Pull Request von `dependabot[bot]` erscheint, an dem deine Checks laufen.

## Fragen zum Nachdenken

- In Aufgabe 5 hast du `setup-python` per SHA gepinnt. Was ändert Dependabot in so einer Zeile?
- `ruff` ist in `requirements-dev.txt` auf eine exakte Version festgelegt. Warum ist das bei einem Linter sinnvoll?

<details>
<summary>Tipp 1: Aufbau der Datei</summary>

Die Datei beginnt mit `version: 2`. Darunter steht unter `updates:` eine Liste – ein Eintrag pro Paket-Ökosystem mit `package-ecosystem`, `directory` und `schedule.interval`. [GitHub: Dependabot-Konfiguration](https://docs.github.com/en/code-security/reference/supply-chain-security/dependabot-options-reference)

</details>

<details>
<summary>Tipp 2: Namen der Ökosysteme</summary>

Für Actions heißt das Ökosystem `github-actions`, für Python-Pakete `pip`. In beiden Fällen ist `directory: "/"` richtig – Dependabot findet `.github/workflows/` selbst. [GitHub: Actions aktuell halten](https://docs.github.com/en/code-security/how-tos/secure-your-supply-chain/secure-your-dependencies/keeping-your-actions-up-to-date-with-dependabot)

</details>
