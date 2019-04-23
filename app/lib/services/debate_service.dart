import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app/models/debate.dart';

class DebateService {
  static Debate createDebate(String topic, [Map<String, dynamic> customProperties]) {
    var debate = Debate(topic, customProperties: customProperties);
    var metadata = <String, dynamic>{
      '_topic': debate.topic,
    }..addAll(debate.customProperties);

    // TODO(marcelherd): Account for potential collisions
    Firestore.instance
        .collection(debate.debateCode)
        .document('metadata')
        .setData(metadata);

    return debate;
  }

  static Future<Debate> getDebate(String debateCode) async {
    var querySnapshot =
        await Firestore.instance.collection(debateCode).getDocuments();

    if (querySnapshot.documents.isEmpty)
      return null; // Debate with debateCode does not exist

    var metadataDocument = querySnapshot.documents.firstWhere(
        (DocumentSnapshot snapshot) => snapshot.documentID == 'metadata');

    String topic = metadataDocument.data['_topic'];
    var customProperties = Map<String, dynamic>.of(metadataDocument.data)
        ..removeWhere((String key, dynamic value) => key == '_topic');

    var contributionDocuments = querySnapshot.documents.where(
        (DocumentSnapshot snapshot) => snapshot.documentID != 'metadata');

    var contributions = <Contribution>[];
    contributionDocuments.forEach((DocumentSnapshot snapshot) {
      String content = snapshot.data['content'];
      num duration = snapshot.data['duration'];

      String name = snapshot.data['name'];
      Gender gender = getGender(snapshot.data['gender']);
      
      // TODO(marcelherd): Custom properties
      var author = Author(name, gender, customProperties);
      var contribution = Contribution(content, author, duration);
      contributions.add(contribution);
    });

    return Debate(topic, debateCode: debateCode,  contributions: contributions, customProperties: customProperties);
  }
}
