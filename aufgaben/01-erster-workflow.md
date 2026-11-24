# Aufgabe 1: Erster Workflow

⏱ ca. 10 Minuten · [Zurück zur Übersicht](../README.md)

## Ziel

Du lernst die Bausteine kennen: **Event → Workflow → Job auf einem Runner → Steps**. Dein erster Workflow macht noch nichts Nützliches – er sagt nur Hallo. Dafür siehst du, wo Workflows liegen, wie sie starten und wo die Logs stehen.

## Aufgabe

Lege auf `main` die Datei `.github/workflows/hallo.yml` an. Im Browser: **Add file → Create new file** und den ganzen Pfad als Dateinamen eintippen – die Ordner entstehen beim Tippen der `/` automatisch.

Der Workflow soll

1. den Namen `Hallo Radhaus` tragen,
2. bei jedem `push` starten **und** zusätzlich per Knopf startbar sein (`workflow_dispatch`),
3. einen Job `hallo` auf `ubuntu-latest` haben,
4. in einem Step mit `run:` eine Begrüßung ausgeben, die den **Namen der Person** enthält, die den Workflow ausgelöst hat.

Committe die Datei direkt auf `main`. Öffne dann den Tab **Actions**, klicke auf den Run, dann auf den Job `hallo` und klappe deinen Step auf.

Starte den Workflow danach ein zweites Mal **von Hand**: Tab **Actions** → links **Hallo Radhaus** → **Run workflow**.

## Geschafft, wenn …

- im Tab **Actions** zwei grüne Runs von `Hallo Radhaus` stehen – einer durch `push`, einer durch `workflow_dispatch`,
- im Log deine Begrüßung mit deinem GitHub-Namen steht.

## Fragen zum Nachdenken

- Was ist hier das **Event**, was der **Job**, was der **Runner**, was der **Step**?
- Was passiert mit dem Runner, nachdem der Job fertig ist?

<details>
<summary>Tipp 1: Aufbau einer Workflow-Datei</summary>

Eine Workflow-Datei hat drei wichtige Teile auf oberster Ebene: `name:`, `on:` (welche Events) und `jobs:`. Unter `jobs:` steht der Name des Jobs, darunter `runs-on:` und `steps:`. Jeder Step beginnt mit einem Spiegelstrich `-`.

Schau dir das Beispiel in [GitHub: Workflow erstellen](https://docs.github.com/en/actions/how-tos/write-workflows/use-workflow-templates) oder in der [Workflow-Syntax](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax) an.

</details>

<details>
<summary>Tipp 2: Mehrere Events und der Name der Person</summary>

Mehrere Events kannst du als Liste angeben: `on: [push, workflow_dispatch]`.

Wer den Run ausgelöst hat, steht im **Kontext** `github` – in der Eigenschaft `actor`. In einem `run:` schreibst du so einen Ausdruck als `${{ github.actor }}`. [GitHub: Kontexte](https://docs.github.com/en/actions/reference/workflows-and-actions/contexts#github-context)

</details>

<details>
<summary>Tipp 3: Gerüst</summary>

```yaml
name: Hallo Radhaus

on: [push, workflow_dispatch]

jobs:
  hallo:
    runs-on: ubuntu-latest
    steps:
      - run: echo "..."
```

Ergänze nur noch den Text im `echo`.

</details>

## Doku

- [GitHub: Workflows verstehen](https://docs.github.com/en/actions/concepts/workflows-and-actions/workflows)
- [GitHub: Events, die Workflows auslösen](https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows)
- [GitHub: Workflow von Hand starten](https://docs.github.com/en/actions/how-tos/manage-workflow-runs/manually-run-a-workflow)
