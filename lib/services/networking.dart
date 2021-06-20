import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'commodity.dart';

class NetworkHelper {
  late String basicCridentials;

  NetworkHelper({required this.basicCridentials});

  Map<String, String> basicAuthorizationHeader() {
    return {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Basic ${basicCridentials}'
    };
  }

  dynamic decodeResponse(http.Response resp) {
    print("resp.body: ${resp.body}");
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body);
    } else {
      print('Error STATUS!=${resp.statusCode}');
      return jsonDecode(resp.body);
    }
  }

  Future<dynamic> getData(String url) async {
    try {
      http.Response uriResponse = await http.get(Uri.parse(url));
      return decodeResponse(uriResponse);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> postFile(UploadFile file, String url) async {
    try {
      var uri = Uri.parse(url);
      http.MultipartFile mf = await http.MultipartFile.fromBytes('file', file.bytes, filename: file.name );
      // multipart that takes file.. here this "image_file" is a key of the API request
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(basicAuthorizationHeader())
        ..files.add(mf);
      // send
      http.StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);
      return decodeResponse(response);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getPrivateData(String url) async {
    try {
      var resp = await http.get(Uri.parse(url), headers: basicAuthorizationHeader());
      return decodeResponse(resp);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> postData(String url, String json) async {
    try {
      http.Response resp =
          await http.post(Uri.parse(url), headers: basicAuthorizationHeader(), body: json);
      return decodeResponse(resp);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> putData(String url, String? json) async {
    try {
      http.Response resp =
          await http.put(Uri.parse(url), headers: basicAuthorizationHeader(), body: json);
      return decodeResponse(resp);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> deleteData(String url) async {
    try {
      var resp = await http.delete(Uri.parse(url), headers: basicAuthorizationHeader());
      if (resp.statusCode == 200) {
        return jsonDecode(resp.body);
      } else {
        print(resp.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
