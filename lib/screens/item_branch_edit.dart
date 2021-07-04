import 'package:E0ShopManager/services/attribute.dart';
import 'package:E0ShopManager/services/commodity.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ItemBranchEditScreen extends StatefulWidget {
  final EshopManager eshopManager;
  final CommodityBranch branch;
  final Commodity item;

  ItemBranchEditScreen(this.eshopManager, this.branch, this.item);

  @override
  _ItemBranchState createState() => _ItemBranchState();
}

class _ItemBranchState extends State<ItemBranchEditScreen> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  late CommodityModel _commodityModel;
  late AttributeModel _attributeModel;
  List<CommodityAttribute> attributes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Commodity Branch ${widget.branch.id} '),
      ),
      body: Form(
        key: formGlobalKey,
        child: ListView(
          children: [
            BranchDetailsCard(
              branch: widget.branch,
            ),
            ItemAttributesCard(
              attributes: attributes,
              branch: widget.branch,
            ),
          ],
        ),
      ),
      floatingActionButton: new Builder(builder: (BuildContext context) {
        return new FloatingActionButton(
          onPressed: () async {
            if (formGlobalKey.currentState!.validate()) {
              Message message =
                  await _commodityModel.updateBranch(widget.branch);
              if (Message.SUCCESS == message.status) {
                Navigator.pop(context, message);
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Success')));
              } else {
                print(message.status);
                print(message.toJson());
                String errors = '';
                message.errors?.forEach((error) {
                  errors += ' ' + error.message;
                });
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(message.message + ': ' + errors.trim())));
              }
            }
          },
          tooltip: 'Update branch',
          child: const Icon(Icons.save),
        );
      }),
    );
  }

  void _loadAttributes() async {
    List<CommodityAttribute> attributesFromModel =
        await _attributeModel.getAttributes(widget.item.type.id!);
    if (attributesFromModel != null) {
      setState(() {
        attributes = attributesFromModel;
      });
    }
  }

  @override
  void initState() {
    //_item = widget.commodity;
    _commodityModel = CommodityModel(widget.eshopManager);
    _attributeModel = AttributeModel(widget.eshopManager);
    _loadAttributes();
  }
}

class BranchDetailsCard extends StatelessWidget {
  final CommodityBranch branch;

  const BranchDetailsCard({Key? key, required this.branch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextFormField(
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  initialValue: branch.amount.toString(),
                  decoration: const InputDecoration(
                    hintText: 'Enter amount of items',
                    labelText: 'Amount',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter amount';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    branch.amount = int.tryParse(value)!;
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: TextFormField(
                  initialValue: branch.price.toString(),
                  decoration: const InputDecoration(
                    hintText: 'Enter price per item',
                    labelText: 'Price',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter price per item';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Incorrect price';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    branch.price = double.tryParse(value)!;
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: TextFormField(
                  initialValue: branch.currency,
                  decoration: const InputDecoration(
                    hintText: 'Enter Currency Code',
                    labelText: 'Currency',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter valid currency code';
                    }
                    if ("USD" != value) {
                      return 'Incorrect currency code. Available just USD';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    branch.currency = value;
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemAttributesCard extends StatefulWidget {
  final List<CommodityAttribute> attributes;
  final CommodityBranch branch;

  ItemAttributesCard({Key? key, required this.attributes, required this.branch}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ItemAttributesCardState(branch);
}

class ItemAttributesCardState extends State<ItemAttributesCard> {
  final CommodityBranch branch;

  ItemAttributesCardState(this.branch);

  bool attributePresent(AttributeDto attr) {
    return branch.attributes.any((attribute) => attribute.name==attr.name && attribute.value.toString()==attr.value.toString());
  }

  List<CheckboxListTile> getAttributesView() {
    print('Branch attributes is ');
    branch.attributes.forEach((attribute) {
      print('${attribute.name}: ${attribute.value} : ${attribute.measure}');
    });
    List<CheckboxListTile> viewList = [];
    widget.attributes.forEach((attr) {
      viewList.addAll(
        attr.values
            .map(
              (v) => CheckboxListTile(
                checkColor: Colors.yellow,
                title: Row(
                  children: [
                    Expanded(flex: 1, child: Text(attr.name)),
                    Expanded(flex: 2, child: Text(v.value.toString())),
                    Expanded(flex: 2, child: Text(attr.measure ?? '')),
                  ],
                ),
                value: attributePresent(
                    AttributeDto(attr.name, v.value, attr.measure)),
                onChanged: (bool? value) {
                  setState(() {
                    if (value!) {
                      branch.attributes
                          .add(AttributeDto(attr.name, v.value, attr.measure));
                    } else {
                      branch.attributes.remove(
                          AttributeDto(attr.name, v.value, attr.measure));
                    }
                    print("attributeValues>> ${branch.attributes.length}");
                    //print(item.propertyValues);
                  });
                },
              ),
            )
            .toList(),
      );
    });
    return viewList;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: getAttributesView(),
        ),
      ),
    );
  }
}
