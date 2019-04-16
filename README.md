# MOP-Quotify

## Install Flutter

https://flutter.dev/docs/get-started/install

## Set up Firebase

Acquire `google-services.json` for Android and `GoogleService-Info.plist` for iOS and move them into these directories:

```
app/android/app/google-services.json
app/ios/Runner/GoogleService-Info.plist
```

Do **not** commit them to Git.

## Development guidelines

- Do not commit directly to `master`
  - `master` is a protected branch, you can only push changes to master by creating a pull request from another branch and having it approved
  - The `master` branch will only have stable versions
- Folder structure
  - Create a separate folder for each screen in `/lib/screens/` and add a corresponding route in `/lib/routes.dart`
  - Put globally used widgets in `/lib/widgets`
  - Put locally used widgets in `/lib/screens/<screen>/widgets`
  - If your screen has multiple tabs, put them in `/lib/screens/<screen>/pages`
- Code style
  - Use trailing commas
  - Omit the new keyword
  - Prefer creating methods for event handlers over using inline functions
  - Prefer using SizedBox to create space between two widgets instead of wrapping a subset of widgets with Padding
  - Prefer using theme colors: `Theme.of(context).primaryColor`
  - Prefer using responsive font sizes: `DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0)` instead of magic numbers
  - For reusable widgets, add at least a named optional parameter for key:
  ```dart
  class MyWidget extends StatelessWidget {
    MyWidget({Key key}) : super(key: key);
  }
  ```
