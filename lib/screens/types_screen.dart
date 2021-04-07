import 'package:E0ShopManager/screens/attributes_screen.dart';
import 'package:E0ShopManager/screens/type_update_screen.dart';
import 'package:E0ShopManager/services/commodity_type.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:flutter/material.dart';

import 'type_add_screen.dart';

class TypesScreen extends StatefulWidget {
  final EshopManager eshopManager;

  TypesScreen(this.eshopManager);

  @override
  _TypesScreenState createState() => _TypesScreenState();
}

class _TypesScreenState extends State<TypesScreen> {
  List<Widget> _typesCardsList = [];
  late TypesModel _typesModel;

  void _updateUI(dynamic types) {
    if (types != null) {
      setState(() {
        _typesCardsList = _getTypes(types);
        print('Loaded types');
        print(types);
      });
    } else {
      //
      print('Show error');
    }
  }

  List<Widget> _getTypes(List<CommodityType> types) {
    return types
        .map(
          (e) => Card(
            child: ListTile(
              title: Text(e.name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return AttributesScreen(
                            widget.eshopManager,
                            e,
                          );
                        }),
                      );
                    },
                    icon: Icon(
                      Icons.build,
                      color: Colors.yellow,
                    ),
                    tooltip: 'Setup attributes',
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return TypeUpdateScreen(e, widget.eshopManager);
                        }),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.yellow,
                    ),
                    tooltip: 'Edit this Type',
                  ),
                  new Builder(
                    builder: (BuildContext context) {
                      return new IconButton(
                        onPressed: () {
                          if (e.id != null) {
                            deleteType(context, e.id!);
                          }
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.yellow,
                        ),
                        tooltip: 'Delete this Type',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  void _loadTypes() async {
    List<CommodityType> types = await _typesModel.getTypes();
    _updateUI(types);
  }

  void deleteType(BuildContext context, int id) async {
    var message = await _typesModel.deleteType(id);
    print(message['message']);
    final snackBar = SnackBar(content: Text('Type Deleted'));
    Scaffold.of(context).showSnackBar(snackBar);
    _loadTypes();
  }

  @override
  void initState() {
    _typesModel = TypesModel(widget.eshopManager);
    _loadTypes();
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return TypeAddScreen(widget.eshopManager);
      }),
    );
    if (result != null) {
      //update type
      print(result);
      _loadTypes();
      final snackBar = SnackBar(content: Text('Type Added'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items types'),
      ),
      body: ListView(
        children: _typesCardsList,
      ),
      floatingActionButton: new Builder(builder: (BuildContext context) {
        return new FloatingActionButton(
          onPressed: () {
            _navigateAndDisplaySelection(context);
          },
          tooltip: 'Add type',
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
