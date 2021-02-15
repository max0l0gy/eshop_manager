import 'package:E0ShopManager/services/commodity_type.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:flutter/material.dart';

class TypeAddScreen extends StatefulWidget {
  final EshopManager eshopManager;

  TypeAddScreen(this.eshopManager);

  @override
  _TypeAddScreenState createState() => _TypeAddScreenState();
}

class _TypeAddScreenState extends State<TypeAddScreen> {
  String name;
  String description;
  final _formKey = GlobalKey<FormState>();
  TypesModel _typesModel;

  @override
  void initState() {
    _typesModel = TypesModel(widget.eshopManager);
  }

  void addTypeAction() {
    setState(() async {
      if (_formKey.currentState.validate()) {
        // Process data.
        print('Process form data');
        print('Name $name');
        CommodityType ct = CommodityType(
          id: null,
          name: name,
          description: description,
        );
        var resp = await _typesModel.addType(ct);
        Navigator.pop(context, resp);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item's Type"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter commodity type name',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some name';
                  }
                  return null;
                },
                onChanged: (value) {
                  name = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Enter description of type',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some description';
                  }
                  return null;
                },
                onChanged: (value) {
                  description = value;
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTypeAction();
        },
        tooltip: 'Update type',
        child: const Icon(Icons.save),
      ),
    );
  }
}
