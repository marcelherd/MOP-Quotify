import 'package:app/util/hash.dart';

class Debate {

  final String topic;
  String debateCode;
  final List<Contribution> contributions;
  final Map<String, dynamic> customProperties;

  Debate(this.topic, { this.debateCode, this.contributions = const [], this.customProperties = const {} }) {
    debateCode ??= createHash(topic);
  }

}

class Contribution {

  final Author author;
  final String content;
  num duration;

  Contribution(this.content, this.author, [this.duration]);

}

class Author {
  final String name;
  final Gender gender;
  final Map<String, dynamic> customProperties;

  Author(this.name, this.gender, [this.customProperties = const {}]);
}

enum Gender { male, female, diverse }

Gender getGender(String gender) => Gender.values.firstWhere((e) => e.toString() == 'Gender.' + gender);
String getGenderString(Gender gender) {
  switch (gender) {
    case Gender.male:
      return 'Männlich';
    case Gender.female:
      return 'Weiblich';
    case Gender.diverse:
      return 'Divers';
    default: 
      return 'This should never happen but it makes the linter happy';
  }
}