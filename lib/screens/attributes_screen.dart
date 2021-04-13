import 'package:E0ShopManager/services/attribute.dart';
import 'package:E0ShopManager/services/commodity_type.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:flutter/material.dart';

import 'attribute_add_screen.dart';

class AttributesScreen extends StatefulWidget {
  final EshopManager eshopManager;
  final CommodityType type;

  AttributesScreen(this.eshopManager, this.type);

  @override
  _AttributesState createState() => _AttributesState();
}

class _AttributesState extends State<AttributesScreen> {
  List<DataRow> attributes = [];
  late AttributeModel _attributeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attributes of type ${widget.type.name}'),
      ),
      body: _attributesTable(),
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

  DataTable _attributesTable() {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Name',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Value',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Mesure',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Delete',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: attributes,
    );
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    List<String> dataTypeList = await _attributeModel.getDataTypes();
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return AttributeAddScreen(
          widget.eshopManager,
          widget.type,
          dataTypeList,
        );
      }),
    );
    if (result != null) {
      print(result);
      //update type
      _loadAttributes();
      final snackBar = SnackBar(content: Text('Attribute Added'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void _loadAttributes() async {
    List<CommodityAttribute> attributesFromModel =
        await _attributeModel.getAttributes(widget.type.id!);
    if (attributesFromModel != null) {
      setState(() {
        attributes = convertAttributes(attributesFromModel);
      });
    }
  }

  List<DataRow> convertAttributes(List<CommodityAttribute> attributes) {
    List<DataRow> attrCards = [];
    attributes.forEach((attr) {
      attrCards.addAll(
        attr.values
            .map(
              (v) => DataRow(
                cells: <DataCell>[
                  DataCell(Text(attr.name)),
                  DataCell(Text(v.value.toString())),
                  DataCell(Text(attr.measure ?? '')),
                  DataCell(
                    _DeleteFlatButton(v.id),
                  ),
                ],
              ),
            )
            .toList(),
      );
    });
    return attrCards;
  }

  @override
  void initState() {
    _attributeModel = AttributeModel(widget.eshopManager);
    _loadAttributes();
  }

  Widget _DeleteFlatButton(int valueId) {
    return Builder(builder: (BuildContext context) {
      return new FlatButton(
        onPressed: () async {
          var message = await _attributeModel.deleteAttribute(valueId);
          print(message['message']);
          final snackBar = SnackBar(content: Text('Attribute Value Deleted'));
          Scaffold.of(context).showSnackBar(snackBar);
          _loadAttributes();
        },
        child: Icon(
          Icons.delete,
          color: Colors.lime,
        ),
      );
    });
  }
}
