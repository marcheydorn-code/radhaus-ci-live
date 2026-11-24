# Zusatz 5: Terraform prüfen

[Zurück zur Übersicht](../README.md)

## Ziel

CI ist nicht nur für Programmcode. Auch Infrastruktur als Code wird bei jeder Änderung automatisch geprüft. Im Ordner `infra/` liegt ein kleines Terraform-Projekt – es legt nur eine lokale Konfigurationsdatei an, **keine Cloud-Ressourcen**. Es enthält einen Formatierungsfehler.

## Aufgabe

1. Lege einen neuen Workflow `.github/workflows/terraform.yml` an, der nur startet, wenn sich etwas im Ordner `infra/` ändert (bei Push auf `main` und bei Pull Requests).
2. Ein Job `terraform` soll im Ordner `infra/` nacheinander:
   - Terraform einrichten mit der Action `hashicorp/setup-terraform` (Version `v4`),
   - `terraform fmt -check` – prüft die Formatierung,
   - `terraform init -backend=false` – lädt den Provider,
   - `terraform validate` – prüft, ob die Konfiguration gültig ist.
3. Der erste Lauf wird **rot**. Finde im Log heraus, welche Datei schlecht formatiert ist, und korrigiere sie per Pull Request.

## Geschafft, wenn …

- der erste Lauf an `terraform fmt -check` scheitert,
- nach deiner Korrektur alle vier Steps grün sind.

## Fragen zum Nachdenken

- Warum macht `terraform plan` oder gar `apply` in dieser Übung keinen Sinn – und was bräuchte man dafür in echt?
- Die Datei `infra/.terraform.lock.hcl` ist schon im Repository. Wofür ist sie da?

<details>
<summary>Tipp 1: Nur bei Änderungen in <code>infra/</code> starten</summary>

Unter `push` und `pull_request` kannst du mit `paths:` filtern, z. B. `paths: ['infra/**']`. [GitHub: Pfad-Filter](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#onpushpull_requestpull_request_targetpathspaths-ignore)

Damit der erste Lauf überhaupt startet, nimm `.github/workflows/terraform.yml` mit in die Pfadliste auf.

</details>

<details>
<summary>Tipp 2: Alle Befehle im Ordner <code>infra/</code></summary>

Statt vor jeden Befehl `cd infra` zu schreiben, kannst du für den Job ein Standard-Arbeitsverzeichnis festlegen:

```yaml
    defaults:
      run:
        working-directory: infra
```

[GitHub: `defaults.run`](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_iddefaultsrun)

</details>

<details>
<summary>Tipp 3: Den Fehler finden und beheben</summary>

`terraform fmt -check` nennt die Datei, aber nicht die Stelle. Hinter dem Befehl kannst du `-diff` ergänzen – dann zeigt das Log die nötige Änderung. Schau dir die Ausrichtung der `=`-Zeichen im Block `resource "local_file"` an. Lokal würde `terraform fmt` die Datei automatisch korrigieren.

</details>

## Doku

- [hashicorp/setup-terraform](https://github.com/hashicorp/setup-terraform)
- [Terraform: `fmt`](https://developer.hashicorp.com/terraform/cli/commands/fmt) · [`validate`](https://developer.hashicorp.com/terraform/cli/commands/validate) · [Lock-Datei](https://developer.hashicorp.com/terraform/language/files/dependency-lock)
