import 'package:E0ShopManager/services/commodity_type.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:flutter/material.dart';

import 'item_add_screen.dart';

class SelectTypeScreen extends StatefulWidget {
  final EshopManager manager;

  SelectTypeScreen(this.manager);

  @override
  State<StatefulWidget> createState() => _SelectTypeScreen();
}

class _SelectTypeScreen extends State<SelectTypeScreen> {
  TypesModel _typesModel;
  List<Widget> _selectTypeButtons = [];

  void _updateUI(List<CommodityType> types) {
    if (types != null) {
      setState(() {
        _selectTypeButtons = _getButtonListView(types);
      });
    } else {
      //
      print('Show error');
    }
  }

  Future<void> _loadTypes() async {
    List<CommodityType> types = await _typesModel.getTypes();
    _updateUI(types);
  }

  @override
  void initState() {
    _typesModel = TypesModel(widget.manager);
    _loadTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _selectTypeButtons,
          ),
        ),
      ),
    );
  }

  List<Widget> _getButtonListView(List<CommodityType> types) {
    return types
        .map(
          (type) => RaisedButton(
            color: Colors.pink,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return ItemAddScreen(widget.manager, type);
                }),
              );
            },
            child: Text(
              type.name,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        )
        .toList();
  }
}
