import 'package:flutter/widgets.dart';

class CommodityValidation {
  static String name(String value) {
    if (value.isEmpty) {
      return 'Please enter item name';
    }
    if (value.trim().length < 8 || value.trim().length > 256) {
      return 'Name length 8-256';
    }
    return null;
  }

  static String shortDescription(String value) {
    if (value.isEmpty) {
      return 'Please enter some short description';
    }
    if (value.trim().length < 16 || value.trim().length > 256) {
      return 'Short description length 16-256';
    }
    return null;
  }

  static String overview(String value) {
    if (value.isEmpty) {
      return 'Please enter overview';
    }
    if (value.trim().length < 64 || value.trim().length > 2048) {
      return 'overview length 64-2048';
    }
    return null;
  }
}
