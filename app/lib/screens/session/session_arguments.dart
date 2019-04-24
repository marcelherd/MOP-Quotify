import 'package:app/models/debate.dart';

class SessionArguments {
  final Debate debate;
  final SessionReason reason;

  SessionArguments(this.debate, this.reason) : assert(debate != null), assert(reason != null);
}

enum SessionReason { created, joined }