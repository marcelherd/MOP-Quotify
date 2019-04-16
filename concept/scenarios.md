# Scenario 1: Debatte wird erstellt (Besitzer POV)

1. App starten
2. Zum Tab 'Erstellen' wechseln
3. Thema in das Textfeld eingeben
4. Unter dem Textfeld sind die Eigenschaften zu sehen, die in dieser Debatte (zusätzlich zu den Standardeigenschaften Geschlecht, Wortmeldungen und Dauer) getrackt werden sollen:
![Create mockup](https://raw.githubusercontent.com/marcelherd/MOP-Quotify/dev/concept/create.png)
5. Über den '+'-Button kann eine neue Eigenschaft angelegt werden. Bereits angelegte Eigenschaften sind in Form von 'Pills' zu sehen und ein Klick darauf ermöglicht es diese Eigenschaft zu bearbeiten. In jedem Fall wird der AddPropertyScreen aufgerufen, der nachfolgend zu sehen ist:
![Add property mockup](https://raw.githubusercontent.com/marcelherd/MOP-Quotify/dev/concept/add_property.png)
6. Im Textfeld 'Eigenschaft' wird der Eigenschaft ein Name gegeben, in der Auswahlbox daneben kann einer der folgenden Typen vergeben werden: Ja/Nein, Text, Einzelauswahl, Mehrfachauswahl
   - Beispiel: Eigenschaft = Raucher, EigenschaftsTyp = Ja/Nein (boolean)
7. Bei den beiden Auswahltypen wird darunter noch ein weiteres Textfeld eingeblendet, in dem eine Auswahlmöglichkeit eingegeben werden kann. Wenn das Textfeld befüllt wird, wird gleich ein weiteres Textfeld eingeblendet (oder mit + Button?)
   - Die Eigenschaften bekommen an dieser Stelle noch keine Werte, sie werden durch den Nutzer befüllt, wenn der dem Raum beitritt
8. Durch bestätigen wird wieder der CreateScreen aufgerufen, in dem die gerade erstellte Eigenschaft als Pill angezeigt wird (z.B. 'My property' im ersten Mockup)
9. Durch einen Klick auf 'Erstellen' wird die Debatte mit den gegebenen Eigenschaften angelegt und es erfolgt eine Weiterleitung auf den DebateScreen
10. Auf diesem Screen sieht der Besitzer alle Wortmeldungen. Diese werden durch die Nicht-Besitzer angelegt, die der Debatte beigetreten sind. Der Besitzer selbst kann keine Wortmeldungen anlegen. Eine Wortmeldung besteht aus einer Kurzbeschreibung und einer geschätzten Dauer (wie können weitere Informationen angezeigt werden? Long tap?)
11. Durch einen Klick auf eine Wortmeldung (?) wird "das Wort gereicht", woraufhin der Timer für diese Wortmeldung startet. Ein erneutes Klicken beendet den Timer.
12. Im Statistik-Tab sind Statistiken einzusehen
13. Irgendwie kann man auch exportieren
14. Back Button als Besitzer schließt die Debatte

# Scenario 2: Debatte wird beigetreten (Nicht-Besitzer POV)

Beim Beitreten werden die custom properties angezeigt, die man dann mit seinen Werten befüllen muss. Man kann dann eigene Wortmeldungen einreichen, die diese Werte beinhalten