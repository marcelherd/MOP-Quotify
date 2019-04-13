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

## Develop guidelines

- Do not commit directly to `master`
  - `master` is a protected branch, you can only push changes to master by creating a pull request from another branch and having it approved
