import 'package:flutter/material.dart';

import 'package:app/models/debate.dart';

Color getGenderColor(Gender gender) {
  switch (gender) {
    case Gender.male:
      return Colors.blue;
    case Gender.female:
      return Colors.red;
    case Gender.diverse:
      return Colors.purpleAccent;
    default:
      return Colors.grey;
  }
}
