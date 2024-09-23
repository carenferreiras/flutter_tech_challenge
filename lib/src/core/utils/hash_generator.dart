import 'dart:convert';

import 'package:crypto/crypto.dart';

class HashGenerator {
  static String generateHash(String ts, String privateKey, String publicKey){
    final String input = ts + privateKey + publicKey;
    final List<int> bytes = utf8.encode(input);
    return md5.convert(bytes).toString();

  }
}