# Aufgabe 6: Ruleset für `main`

⏱ ca. 15 Minuten · [Zurück zur Übersicht](../README.md)

## Ziel

Bisher **informiert** die Pipeline nur – ein rotes Kreuz am Pull Request hält niemanden vom Mergen ab. Mit einem **Ruleset** wird die Regel technisch erzwungen: Auf `main` kommt nur noch, was per Pull Request kommt und den Test bestanden hat.

## Aufgabe

1. **Settings → Rules → Rulesets → New ruleset → New branch ruleset**.
2. Name: `main schützen`, **Enforcement status: Active**.
3. **Target branches → Add target → Include default branch**.
4. Aktiviere diese Regeln:
   - **Restrict deletions** (ist meist schon an)
   - **Block force pushes** (ist meist schon an)
   - **Require a pull request before merging** – setze **Required approvals auf 0**. Du arbeitest allein und kannst deinen eigenen PR nicht genehmigen.
   - **Require status checks to pass** → **Add checks** → `test` auswählen
5. **Create**.

Jetzt testest du die Regel:

6. Versuch, im Browser direkt auf `main` eine Kleinigkeit in der `README.md` zu ändern und zu committen. Was passiert?
7. Mach einen Branch, in dem du in `shop/versand.py` die Versandpauschale von `"4.90"` auf `"5.90"` änderst – zum Beispiel, weil „die Chefin das so wollte“. Öffne einen Pull Request. Was passiert mit dem Check und mit dem Merge-Knopf?
8. Schließe diesen PR, ohne zu mergen.

## Geschafft, wenn …

- ein direkter Commit auf `main` nicht mehr möglich ist (GitHub bietet dir stattdessen an, einen Branch und PR anzulegen),
- der PR aus Schritt 7 einen roten Check hat und **Merge** gesperrt ist.

## Fragen zum Nachdenken

- Die Preisänderung in Schritt 7 war vielleicht sogar gewollt. Was müsste dann zusätzlich geändert werden, damit der PR grün wird?
- Warum ist eine technisch erzwungene Regel besser als eine Regel im Wiki?

<details>
<summary>Tipp 1: Der Check <code>test</code> taucht nicht in der Liste auf</summary>

GitHub schlägt nur Checks vor, die in den letzten Tagen im Repository gelaufen sind. Der Job muss also mindestens einmal gelaufen sein (das ist er seit Aufgabe 2). Tippe `test` ins Suchfeld. Achte darauf, dass dein Job in `ci.yml` wirklich `test` heißt.

</details>

<details>
<summary>Tipp 2: Ich kann trotzdem mergen</summary>

- Ist **Enforcement status** auf **Active** (nicht *Evaluate* oder *Disabled*)?
- Ist das Repository **öffentlich**? Bei kostenlosen Konten wirken Rulesets nur in öffentlichen Repositories.
- Steht unter **Bypass list** jemand? Für diese Übung sollte die Liste leer sein.

</details>

## Doku

- [GitHub: Rulesets anlegen](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/creating-rulesets-for-a-repository)
- [GitHub: Verfügbare Regeln](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/available-rules-for-rulesets)
