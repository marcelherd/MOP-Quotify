import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app/models/debate.dart';
import 'package:app/models/property.dart';

class DebateService {
  static Debate createDebate(String topic, [List<Property> properties]) {
    var customProperties = Map<String, dynamic>.fromIterable(properties,
      key: (p) => p.title,
      value: (p) => p.choices,
    );

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

  static void createContribution(String debateCode, String content, Author author, num duration) {
    Firestore.instance
        .collection(debateCode)
        .document()
        .setData({
          'content': content,
          'duration': duration,
          'author': {
            'name': author.name,
            'gender': getGenderString(author.gender),
          }..addAll(author.customProperties),
        });
  }

  static Future<bool> debateExists(String debateCode) async {
    var querySnapshot =
      await Firestore.instance.collection(debateCode).getDocuments();
    return querySnapshot.documents.isNotEmpty;
  }

  static Future<Debate> getDebate(String debateCode) async {
    var querySnapshot =
        await Firestore.instance.collection(debateCode).getDocuments();

    if (querySnapshot.documents.isEmpty)
      return null; // Debate with debateCode does not exist

    var metadataDocument = querySnapshot.documents.firstWhere(
        (DocumentSnapshot snapshot) => snapshot.documentID == 'metadata');

    String topic = metadataDocument.data['_topic'];
    var customPropertiesMetadata = Map<String, dynamic>.of(metadataDocument.data)
        ..removeWhere((String key, dynamic value) => key == '_topic');

    var contributionDocuments = querySnapshot.documents.where(
        (DocumentSnapshot snapshot) => snapshot.documentID != 'metadata');

    var contributions = contributionDocuments.fold(
        <Contribution>[], 
        (List<Contribution> prev, DocumentSnapshot e) => prev..add(Contribution.fromJson(e.data)));

    return Debate(
      topic, 
      debateCode: debateCode,  
      contributions: contributions, 
      customProperties: customPropertiesMetadata);
  }
}
