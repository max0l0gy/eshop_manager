import 'package:E0ShopManager/services/commodity_type.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:flutter/material.dart';

class TypeUpdateScreen extends StatefulWidget {
  final CommodityType type;
  final EshopManager eshopManager;

  TypeUpdateScreen(this.type, this.eshopManager);

  @override
  _TypeUpdateScreenState createState() => _TypeUpdateScreenState();
}

class _TypeUpdateScreenState extends State<TypeUpdateScreen> {
  String name;
  String description;
  TypesModel _typesModel;
  final _formKey = GlobalKey<FormState>();

  void updateUI(CommodityType type) {
    setState(() {
      //todo
      name = type.name;
      description = type.description;
    });
  }

  @override
  void initState() {
    _typesModel = TypesModel(widget.eshopManager);
    updateUI(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items type ${widget.type.name}'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: widget.type.name,
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
                initialValue: widget.type.description,
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
            }
          });
        },
        tooltip: 'Update type',
        child: const Icon(Icons.save),
      ),
    );
  }
}
