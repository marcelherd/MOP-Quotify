import 'package:app/models/debate.dart';

class SessionArguments {
  final Debate debate;
  final Author author;

  SessionArguments(this.debate, [this.author]) : assert(debate != null);
}
