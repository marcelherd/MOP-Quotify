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

  factory Contribution.fromJson(Map<String, dynamic> json) {
    String content = json['content'];
    num duration = json['duration'];
    var author = Author.fromJson(Map<String, dynamic>.from(json['author']));
    return Contribution(content, author, duration);
  }

}

class Author {
  final String name;
  final Gender gender;
  final Map<String, dynamic> customProperties;

  Author(this.name, this.gender, [this.customProperties = const {}]);

  factory Author.fromJson(Map<String, dynamic> json) {
    String name = json['name'];
    Gender gender = getGender(json['gender']);
    var customProperties = Map<String, dynamic>.from(json)..removeWhere((k, v) => k == 'name' || k == 'gender');
    return Author(name, gender, customProperties);
  }
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