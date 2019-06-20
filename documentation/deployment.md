# Deployment

## Firebase

Das Backend verwendet Google's Backend as a Service Lösung Firebase. Die folgende Anleitung erklärt, wie der Dienst konfiguriert werden muss.

1. Console aufrufen: https://console.firebase.google.com/
2. Neues Firebase Projekt anlegen
   1. Die Einstellungen können alle nach belieben gewählt werden. 
   2. Als Speicherort empfehlen wir Deutschland mit der Region `europe-west`
   3. Weiter bzw. Projekt erstellen
3. Das neue Projekt aufrufen
4. Auf die iOS Schaltfläche drücken (mittig, unter der Überschrift "Fügen Sie Firebase zu Ihrer App hinzu, um zu beginnen")
   1. iOS Bundle-ID: `com.marcelherd.mop.quotify`
   2. App registrieren drücken
   3. Die Datei `GoogleService-Info.plist` herunterladen und in den Ordner `/app/ios/Runner/` kopieren
   4. Weiter
   5. Weiter
   6. Diesen Schritt überspringen
5. Auf die Schaltfläche App hinzufügen drücken und als Plattform Android wählen
   1. Android-Paketname: `com.marcelherd.mop.quotify`
   2. App registrieren drücken
   3. Die Datei `google-services.json` herunterladen und in den Ordner `/app/android/app/` kopieren
   4. Weiter
   5. Weiter
   6. Diesen Schritt überspringen
6. Auf die Schaltfläche App hinzufügen drücken und als Plattform Web wählen
   1. Beliebigen Namen vergeben
   2. Haken bei "Richten Sie außerdem Firebase Hosting für die App ein"
   3. In der nun auftauchenden Auswahlbox wird automatisch die Projekt-ID ausgewählt, diese beibehalten
   4. App registrieren
   5. Weiter
   6. Weiter
   7. Weiter zur Konsole
7. Links auf Develop > Database drücken
   1. Datenbank erstellen
   2. Im Testmodus starten
   3. Aktivieren

## Export Website

Die Export Website nutzt den Firebase Hosting Dienst. Vorraussetzung hierfür ist, dass das vorherige Kapitel fertiggstellt wurde.

1. Projekt clonen `git clone https://github.com/marcelherd/MOP-Quotify`
2. In das Verzeichnis `MOP-Quotify/export` wechseln
3. `npm install -g firebase-tools` (funktioniert unter Windows nit mit Git Bash, Powershell benutzen)
4. Die bestehende Firebase Konfiguration löschen: `rm .firebaserc firebase.json firestore.indexes.json firestore.rules`
5. `firebase login`
6. `firebase init`
7. Enter drücken
8. Haken bei Firestore und Hosting mit Space setzen, Enter
9. Das zuvor erstellte Projekt auswählen, Enter
10. Enter
11. Enter
12. Enter
13. y
14. n
15. `firebase deploy`

## Frontend

Das Frontend verwendet [Flutter](https://flutter.dev) – eine Installationsanleitung ist der offiziellen Dokumentation zu entnehmen: [Link](https://flutter.dev/docs/get-started/install)

Die App kann anschließend über die Konsole mit `flutter run` ausgeführt werden.