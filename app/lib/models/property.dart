class Property {
  final List<String> choices;
  final String title;
  final PropertyType propertyType;

  Property(this.title, this.propertyType, [this.choices = const []]);

  static Map<PropertyType, String> propertyToString = {
    PropertyType.YesNo: "Ja / Nein",
    PropertyType.Text: "Text",
    PropertyType.SingleChoice: "Einzelauswahl",
    PropertyType.MultipleChoice: "Mehrfachauswahl"
  };
}

enum PropertyType {
  YesNo,
  Text,
  SingleChoice,
  MultipleChoice
}

PropertyType getPropertyType(String propertyType) => PropertyType.values.firstWhere((e) => e.toString() == 'PropertyType.' + propertyType);