import 'package:E0ShopManager/screens/login_screen.dart';
import 'package:E0ShopManager/utils/constants.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: eshopTheme,
      home: LoginScreen(),
    );
  }
}
