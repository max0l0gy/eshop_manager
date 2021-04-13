import 'package:E0ShopManager/services/attribute.dart';
import 'package:E0ShopManager/services/commodity_type.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AttributeAddScreen extends StatefulWidget {
  final EshopManager eshopManager;
  final CommodityType type;
  final List<String> dataTypeList;

  AttributeAddScreen(this.eshopManager, this.type, this.dataTypeList);

  @override
  _AttributesState createState() => _AttributesState();
}

class _AttributesState extends State<AttributeAddScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _dataType = '';
  String _measure = '';
  String _value = '';
  List<String> _dataTypeList = [];
  AttributeModel? _attributeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add attribute for type ${widget.type.name}'),
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
                  hintText: 'Enter attribute name',
                ),
                validator: (value) {
                  if (value!=null && value.isEmpty) {
                    return 'Please enter some name';
                  }
                  return null;
                },
                onChanged: (value) {
                  _name = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter attribute value',
                ),
                validator: (value) {
                  if (value!=null && value.isEmpty) {
                    return 'Please enter some value';
                  }
                  return null;
                },
                onChanged: (value) {
                  _value = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter measure (optional)',
                ),
                validator: (value) {
                  if (value!=null && value.isNotEmpty && value.contains(' ')) {
                    return 'Measure should be a world';
                  }
                  return null;
                },
                onChanged: (value) {
                  _measure = value;
                },
              ),
            ),
            Container(
              height: 55.0,
              color: Colors.lime,
              alignment: Alignment.center,
              padding: EdgeInsets.all(7.0),
              child: CupertinoPicker(
                onSelectedItemChanged: (selectedIndex) {
                  setState(() {
                    _dataType = _getSelectedType(selectedIndex);
                    print(_dataType);
                  });
                },
                itemExtent: 25.0,
                children: _getDataTypesWidgets(_dataTypeList),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: new Builder(builder: (BuildContext context) {
        return new FloatingActionButton(
          onPressed: () async {
            _addAttributeAction();
          },
          tooltip: 'Add type',
          child: const Icon(Icons.save),
        );
      }),
    );
  }

  void _addAttributeAction() async {
    if (_formKey.currentState!.validate()) {
      var resp = await _attributeModel!.addAttribute(RequestAttributeValue(
        typeId: widget.type.id!,
        name: _name,
        dataType: _dataType,
        measure: _measure,
        value: _value,
      ));
      Navigator.pop(context, resp);
    }
  }

  String _getSelectedType(int index) {
    return _dataTypeList[index];
  }

  List<Text> _getDataTypesWidgets(List<String> dataTypeList) {
    return dataTypeList.map((e) => Text(e)).toList();
  }

  @override
  void initState() {
    _attributeModel = AttributeModel(widget.eshopManager);
    _dataTypeList = widget.dataTypeList;
    _dataType = _dataTypeList[0];
  }
}
