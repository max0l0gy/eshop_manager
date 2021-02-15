import 'package:flutter/material.dart';

class EshopManagerProperties {
  static const String managerEndpoint = 'https://titsonfire.store/web';
}

const kTextFieldInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  hintStyle: TextStyle(color: Colors.blueGrey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    borderSide: BorderSide.none,
  ),
  hintText: 'name',
);

var eshopTheme = ThemeData(
  // Define the default brightness and colors.
  brightness: Brightness.dark,
  primaryColor: Colors.lime,
  accentColor: Colors.yellow,

  // Define the default font family.
  //fontFamily: 'Georgia',

  // Define the default TextTheme. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
  buttonTheme: ButtonThemeData(
    colorScheme: ColorScheme.dark(
      primary: Colors.yellow,
    ),
  ),
);

class EshopHeading extends StatelessWidget {
  final String text;

  EshopHeading(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      ),
    );
  }
}

class EshopAttribute extends StatelessWidget {
  final String text;

  EshopAttribute(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10.0,
      ),
    );
  }
}

class EshopNumbers {
  static const double DELAITION_MAX = 3;
  static const double DELAITION_MIN = 1;
  static const double CREATE_IMAGE_WIDTH = 300.0;
  static const double CREATE_IMAGE_HEIGHT = 400.0;
  static const int UPLOAD_IMAGES = 6;
}
