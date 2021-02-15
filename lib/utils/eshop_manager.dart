import 'dart:convert' as convert;

class EshopManager {
  String usr;
  String pswd;
  String getCridentials() {
    String str = usr + ':' + pswd;
    return convert.base64Encode(str.codeUnits);
  }
}
