# Aufgabe 3: Fehler beheben per Pull Request

⏱ ca. 15 Minuten · [Zurück zur Übersicht](../README.md)

## Ziel

Du behebst den Fehler so, wie es im Team üblich ist: auf einem eigenen Branch, über einen **Pull Request**, den die Pipeline automatisch prüft. Erst wenn der Check grün ist, wird gemergt.

## Aufgabe

1. Erstelle in **deinem** Repository einen Branch `fix/versandkosten` von `main`. Im Browser: Branch-Auswahl oben links → **View all branches → New branch**.
2. Öffne auf diesem Branch `shop/versand.py`. Vergleiche die Bedingung für den kostenlosen Versand mit der Tabelle in der [README](../README.md). Korrigiere **nur diese eine Stelle**. Die Tests änderst du nicht.
3. Committe auf `fix/versandkosten` und öffne einen Pull Request: `base: main` ← `compare: fix/versandkosten` – **in deinem eigenen Repository**.
4. Schreib eine kurze PR-Beschreibung:
   - **Problem:** Welcher Test war rot, welches Verhalten war falsch?
   - **Änderung:** Was hast du geändert und warum behebt das den Fehler?
   - **Prüfung:** Welcher Check ist jetzt grün?
5. Prüfe im Tab **Files changed**, dass nur die eine Zeile geändert ist. Dann **Merge pull request**.

## Geschafft, wenn …

- am Pull Request der Check **CI / test** grün ist,
- der PR gemergt ist und der anschließende Run auf `main` ebenfalls grün ist.

## Fragen zum Nachdenken

- Warum läuft die Pipeline zweimal – einmal im PR und einmal nach dem Merge auf `main`?
- Wäre dieser Fehler bei einem Test von Hand aufgefallen? Mit welchem Betrag hätte man testen müssen?

<details>
<summary>Tipp 1: Wo genau ist der Fehler?</summary>

Der rote Test heißt `test_versandkosten[50.00-0.00]`. Das bedeutet: Für einen Warenwert von `50.00` wurden Versandkosten von `0.00` erwartet. Suche in `shop/versand.py` die Zeile, in der der Warenwert mit `VERSANDFREI_AB` verglichen wird.

</details>

<details>
<summary>Tipp 2: Welcher Vergleich ist richtig?</summary>

Laut Tabelle ist der Versand **ab 50,00 € einschließlich** kostenlos. „Einschließlich“ heißt: Auch genau 50,00 € gehört dazu. Welcher Vergleichsoperator drückt „größer **oder gleich**“ aus?

</details>

<details>
<summary>Tipp 3: Pull Request im Browser</summary>

Nach dem Commit auf den Branch zeigt GitHub oben meist einen gelben Hinweis mit **Compare & pull request**. Alternativ: Tab **Pull requests → New pull request**. [GitHub: Pull Request erstellen](https://docs.github.com/en/pull-requests/how-tos/create-pull-requests/creating-a-pull-request)

</details>

## Doku

- [GitHub: Branches im Browser verwalten](https://docs.github.com/en/pull-requests/how-tos/commit-changes/managing-branches-within-your-repository)
- [GitHub: Pull Request erstellen](https://docs.github.com/en/pull-requests/how-tos/create-pull-requests/creating-a-pull-request)
- [GitHub: Status-Checks](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/collaborating-on-repositories-with-code-quality-features/about-status-checks)
