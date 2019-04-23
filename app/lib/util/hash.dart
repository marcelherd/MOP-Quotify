import 'dart:convert';

import 'package:crypto/crypto.dart';

String createHash(String topic) {
  var bytes = utf8.encode(topic);
  return sha1.convert(bytes).toString().substring(0, 6).toUpperCase();
}