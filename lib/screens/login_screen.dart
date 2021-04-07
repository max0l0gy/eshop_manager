import 'package:E0ShopManager/screens/loading_screen.dart';
import 'package:E0ShopManager/services/auth.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late EshopManager manager;
  @override
  void initState() {
    super.initState();
    manager = EshopManager();
    print('_LoadingScreenState -> initState');
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'E-mail',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    manager.usr = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  obscureText: true,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    manager.pswd = value;
                  },
                ),
              ),
              _loginRaisedButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginRaisedButton() {
    return Builder(builder: (BuildContext context) {
      return RaisedButton(
        color: Colors.pink,
        onPressed: () {
          print('check sing in and route to loading screen');
          _chackAuthAndRoute(context);
        },
        child: Text(
          "SiNGIN",
          style: TextStyle(fontSize: 20.0),
        ),
      );
    });
  }

  Future<void> _chackAuthAndRoute(BuildContext context) async {
    Authenticate auth = Authenticate(manager);
    List<String> authorities = await auth.getAuthorities();
    if (authorities == null) {
      print('auth error');
    } else {
      bool authenticated = authorities.any((element) => element == 'ADMIN');
      if (authenticated) {
        print('Redirect with manager');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return LoadingScreen(manager);
          }),
        );
      }
    }
  }
}
