# Zusatz 3: Nächtlicher Lauf

[Zurück zur Übersicht](../README.md)

## Ziel

Neue Sicherheitslücken in Abhängigkeiten werden täglich bekannt – auch wenn niemand am Code etwas ändert. Deshalb lässt man Prüfungen zusätzlich nach Zeitplan laufen.

## Aufgabe

Ergänze `ci.yml` so, dass die Pipeline zusätzlich

1. **jede Nacht um 2:00 Uhr deutscher Zeit (Winterzeit)** startet,
2. jederzeit **von Hand** über **Run workflow** gestartet werden kann.

## Geschafft, wenn …

- im Tab **Actions** bei `CI` der Knopf **Run workflow** erscheint und ein Run von Hand grün durchläuft,
- am nächsten Morgen ein Run mit dem Auslöser `schedule` in der Liste steht.

## Fragen zum Nachdenken

- Warum steht in der Cron-Angabe nicht `2`?
- Was passiert im Sommer mit der Uhrzeit?

<details>
<summary>Tipp 1: Cron und UTC</summary>

Zeitpläne schreibst du im Cron-Format: `Minute Stunde Tag Monat Wochentag`. GitHub rechnet **immer in UTC**. Deutsche Winterzeit ist UTC+1. [GitHub: `schedule`](https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#schedule) · [crontab.guru zum Ausprobieren](https://crontab.guru/)

</details>

<details>
<summary>Tipp 2: Gerüst</summary>

```yaml
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  schedule:
    - cron: '0 1 * * *'
  workflow_dispatch:
```

Zeitplan-Läufe starten nicht auf die Minute genau – bei hoher Last kann es etwas später werden.

</details>
