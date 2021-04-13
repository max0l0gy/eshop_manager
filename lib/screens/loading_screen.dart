import 'package:E0ShopManager/screens/orders_screen.dart';
import 'package:E0ShopManager/screens/portfolio_list_screen.dart';
import 'package:E0ShopManager/screens/types_screen.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:flutter/material.dart';

import 'items_screen.dart';

class LoadingScreen extends StatefulWidget {
  final EshopManager manager;

  LoadingScreen(this.manager);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
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
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return TypesScreen(widget.manager);
                    }),
                  );
                },
                child: Text(
                  "My Types of Items",
                  style: TextStyle(fontSize: 22.0),
                ),
                style: _loadButtonStyle,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ItemsScreen(widget.manager);
                    }),
                  );
                },
                child: Text(
                  "My Items",
                  style: TextStyle(fontSize: 22.0),
                ),
                style: _loadButtonStyle,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return OrdersScreen(widget.manager);
                    }),
                  );
                },
                child: Text(
                  "My Orders",
                  style: TextStyle(fontSize: 22.0),
                ),
                style: _loadButtonStyle,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return PortfolioListScreen(widget.manager);
                    }),
                  );
                },
                child: Text(
                  "My Portfolio",
                  style: TextStyle(fontSize: 22.0),
                ),
                style: _loadButtonStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ButtonStyle _loadButtonStyle = TextButton.styleFrom(primary: Colors.green);

}
