# Aufgabe 5: Rechte begrenzen und Actions pinnen

⏱ ca. 10 Minuten · [Zurück zur Übersicht](../README.md)

## Ziel

Die Pipeline ist Teil eurer Sicherheitsarchitektur. Zwei einfache Regeln aus den Folien setzt du jetzt um:

- **Least Privilege:** Der Workflow bekommt nur die Rechte, die er braucht.
- **Lieferkette absichern:** Fremde Actions werden auf einen festen Commit festgelegt, nicht auf ein verschiebbares Tag.

## Aufgabe

Ändere `.github/workflows/ci.yml` (wieder per Branch und Pull Request):

1. Gib dem eingebauten `GITHUB_TOKEN` für den ganzen Workflow nur das Recht **`contents: read`**.
2. Lege `actions/setup-python` in **allen** Jobs auf den **vollen Commit-SHA** der Version `v7.1.0` fest. Schreib die Version als Kommentar dahinter, damit Menschen sie lesen können.

`actions/checkout` darfst du beim Tag `v7` lassen – oder ebenfalls pinnen, wenn du magst.

## Geschafft, wenn …

- im Workflow ein Block `permissions:` mit `contents: read` steht,
- `setup-python` in allen Jobs mit einem 40-stelligen SHA eingebunden ist,
- alle Checks weiterhin grün sind,
- du im Log eines Runs unter **Set up job → GITHUB_TOKEN Permissions** siehst, dass nur noch `Contents: read` (plus `Metadata: read`) vergeben ist.

## Fragen zum Nachdenken

- Was wäre beim Angriff auf `tj-actions/changed-files` (März 2025) mit einem Workflow passiert, der die Action per SHA eingebunden hatte?
- Warum ist ein Tag wie `v7` bequemer – und warum trotzdem riskanter?

<details>
<summary>Tipp 1: Wo steht <code>permissions</code>?</summary>

`permissions:` steht auf oberster Ebene – auf derselben Höhe wie `on:` und `jobs:`. Darunter folgt eingerückt `contents: read`. [GitHub: `permissions`](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#permissions)

</details>

<details>
<summary>Tipp 2: Den Commit-SHA einer Version finden</summary>

1. Öffne [github.com/actions/setup-python/releases](https://github.com/actions/setup-python/releases).
2. Suche das Release **v7.1.0**.
3. Links neben der Beschreibung steht ein kurzer Commit-Hash (7 Zeichen). Klick darauf – in der Adresszeile und auf der Commit-Seite siehst du den **vollen** 40-stelligen SHA.

Alternativ: [Tags von setup-python](https://github.com/actions/setup-python/tags) → beim Tag `v7.1.0` auf den Commit klicken.

</details>

<details>
<summary>Tipp 3: Schreibweise</summary>

```yaml
- uses: actions/setup-python@<voller-sha> # v7.1.0
```

Hinter dem `#` steht nur ein Kommentar – GitHub ignoriert ihn, Menschen und Dependabot lesen ihn.

</details>

## Doku

- [GitHub: `GITHUB_TOKEN` und seine Rechte](https://docs.github.com/en/actions/tutorials/authenticate-with-github_token)
- [GitHub: Sichere Nutzung von Actions – Pinning](https://docs.github.com/en/actions/reference/security/secure-use#using-third-party-actions)
- [GitHub-Advisory zu tj-actions/changed-files (CVE-2025-30066)](https://github.com/advisories/GHSA-mrrh-fwg8-r2c3)
