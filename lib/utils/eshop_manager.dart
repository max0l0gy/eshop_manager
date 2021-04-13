import 'dart:convert' as convert;

class EshopManager {
  late String usr;
  late String pswd;
  String getCridentials() {
    String str = usr + ':' + pswd;
    return convert.base64Encode(str.codeUnits);
  }
}
