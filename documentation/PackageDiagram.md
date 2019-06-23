# Main

Startet nur die Anwendung

# Routes

Definiert die Routen der App und startet anhanddessen die Flutter App

# util

Enthält Hilfsfunktionen

## Colors

`Color getGenderColor(Gender)`: Liefert eine Farbe für ein gegebenes Geschlecht

## Hash

`String createHash(String)`: Erzeugt einen SHA256-Hash (gekürzt auf 6 Zeichen Uppercase) basierend auf dem übergebenem Thema. Wird als ID für die Datenbank und als Sharing Code verwendet.

## Time

`String formatDuration(Duration)`: Erzeugt einen Zeitstempel-Text im Format mm:ss.SSS (mit 0-en gepaddet)

# services

Enthält Business-Logik

## DebateService

Bietet Funktionen um mit der Firestore Datenbank zu interagieren

# models

Die Modellklassen

# screens

Die Views der unterschiedlichen Routen

## AddContribution

Anlegen einer Wortmeldung

## AddProperty

Anlegen einer Eigenschaft für eine Debatte

## Home

Der Homescreen der App, enthält Tabs Create und Join zum Erstellen/Beitreten einer Debatte

## Registration

Die View, bei der man einer Debatte beitritt

## Session

Die Detail-View einer Debatte - wird angezeigt, wenn man der Debatte mittels Registration beigetreten ist oder die Debatte erstellt hat. Enthält folgende Tabs:

- Overview: Übersicht aller Wortmeldungen
- Speakers: Übersicht aller Geräte, die der Debatte beigetreten sind
- Statistics: Statistik der Debatte
