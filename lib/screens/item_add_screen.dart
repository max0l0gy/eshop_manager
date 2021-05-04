import 'package:E0ShopManager/components/commodity.dart';
import 'package:E0ShopManager/services/attribute.dart';
import 'package:E0ShopManager/services/commodity.dart';
import 'package:E0ShopManager/services/commodity_type.dart';
import 'package:E0ShopManager/utils/constants.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:E0ShopManager/validators/commodity_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/services.dart';

class ItemAddScreen extends StatefulWidget {
  final EshopManager eshopManager;
  final CommodityType type;

  ItemAddScreen(this.eshopManager, this.type);

  @override
  _ItemAddState createState() => _ItemAddState();
}

class _ItemAddState extends State<ItemAddScreen> {
  final _formKey = GlobalKey<FormState>();
  late CommodityModel _itemModel;
  late AttributeModel _attributeModel;
  late RequestCommodity _item = RequestCommodity.withCurrencyCode(
    currencyCode: 'USD',
    typeId: widget.type.id!,
  );
  List<CommodityAttribute> _attributes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item of a ${widget.type.name}'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ItemDetailsCard(
                _item,
                widget.eshopManager,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(3, 0, 75, 100),
              child: ItemAttributesCard(
                item: _item,
                attributes: _attributes,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return new FloatingActionButton(
          onPressed: () {
            _updateOrderStateAction(context);
          },
          tooltip: 'Add item',
          child: const Icon(Icons.save),
        );
      }),
    );
  }

  void _updateOrderStateAction(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      //valodate attributes of item
      if (_item.propertyValues.length == 0) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Select attributes of item')));
        return;
      }
      //validate images of item
      if (_item.images.length == 0 || _item.images.contains('')) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
                'You should upload ${EshopNumbers.UPLOAD_IMAGES.toString()} images of item')));
        return;
      }
      print('Item json ${_item.toJsonString()}');
      Message errorMessage = await _itemModel.addCommodity(_item);
      print(errorMessage.toJson());
      if (errorMessage != null) {
        //TODO parse message and select action
        if (Message.ERROR == errorMessage.status) {
          if ('Internal storage error' == errorMessage.message)
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                    'Try to load another images. Image url should be unique per item.')));
          if(errorMessage.errors!=null) {
            errorMessage.errors?.forEach((element) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('${element.message}')));
            });
          }
          return;
        }
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Success')));
        Navigator.pop(context, errorMessage);
      }
    }
  }

  Future<void> loadAttributes() async {
    List<CommodityAttribute> attr =
        await _attributeModel.getAttributes(widget.type.id!);
    setState(() {
      _attributes = attr;
    });
  }

  @override
  void initState() {
    _itemModel = CommodityModel(widget.eshopManager);
    _attributeModel = AttributeModel(widget.eshopManager);
    loadAttributes();
  }
}

class ItemDetailsCard extends StatefulWidget {
  final RequestCommodity item;
  final EshopManager eshopManager;

  const ItemDetailsCard(
    this.item,
    this.eshopManager,
  );

  @override
  State<ItemDetailsCard> createState() => ItemDetailCardState();
}

EdgeInsets ITEM_DETAIL_PADDING = EdgeInsets.fromLTRB(10, 0, 10, 0);

class ItemDetailCardState extends State<ItemDetailsCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: ITEM_DETAIL_PADDING,
        child: Column(
          children: [
            TextFormField(
              maxLines: null,
              initialValue: widget.item.name,
              decoration: const InputDecoration(
                hintText: 'Enter item name',
              ),
              validator: CommodityValidation.name,
              onChanged: (value) {
                widget.item.name = value.trim();
              },
            ),

            ItemUploadImage(
              images: widget.item.images,
              eshopManager: widget.eshopManager,
            ),

            Padding(
              padding: ITEM_DETAIL_PADDING,
              child: TextFormField(
                initialValue: widget.item.shortDescription,
                decoration: const InputDecoration(
                  hintText: 'Enter short description',
                ),
                validator: CommodityValidation.shortDescription,
                onChanged: (value) {
                  widget.item.shortDescription = value.trim();
                },
              ),
            ),
            Padding(
              padding: ITEM_DETAIL_PADDING,
              child: TextFormField(
                maxLines: null,
                initialValue: widget.item.overview,
                decoration: const InputDecoration(
                  hintText: 'Enter overview',
                ),
                validator: CommodityValidation.overview,
                onChanged: (value) {
                  widget.item.overview = value.trim();
                },
              ),
            ),

            Padding(
              padding: ITEM_DETAIL_PADDING,
              child: TextFormField(
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                initialValue: widget.item.amount.toString(),
                decoration: const InputDecoration(
                  hintText: 'Enter amount of items',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter amount';
                  }
                  return null;
                },
                onChanged: (value) {
                  widget.item.amount = int.tryParse(value)!;
                },
              ),
            ),

            Padding(
              padding: ITEM_DETAIL_PADDING,
              child: TextFormField(
                initialValue: widget.item.price.toString(),
                decoration: const InputDecoration(
                  hintText: 'Enter price per item',
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
                  widget.item.price = double.tryParse(value)!;
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class ItemAttributesCard extends StatefulWidget {
  final List<CommodityAttribute> attributes;
  final RequestCommodity item;

  ItemAttributesCard({Key? key, required this.attributes, required this.item})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ItemAttributesCardState(item);
}

class ItemAttributesCardState extends State<ItemAttributesCard> {
  final RequestCommodity item;

  ItemAttributesCardState(this.item);

  List<CheckboxListTile> getAttributesView() {
    List<CheckboxListTile> viewList = [];
    widget.attributes.forEach((attr) {
      viewList.addAll(
        attr.values
            .map(
              (v) => CheckboxListTile(
                checkColor: Colors.yellow,
                title: Row(
                  children: [
                    Expanded(flex: 2, child: Text(attr.name)),
                    Expanded(flex: 2, child: Text(v.value.toString())),
                    Expanded(flex: 1, child: Text(attr.measure ?? '')),
                  ],
                ),
                value: item.propertyValues.contains(v.id),
                onChanged: (bool? value) {
                  setState(() {
                    if (value!) {
                      item.propertyValues.add(v.id);
                      timeDilation = EshopNumbers.DELAITION_MAX;
                    } else {
                      item.propertyValues.remove(v.id);
                      timeDilation = EshopNumbers.DELAITION_MIN;
                    }
                    print("attributeValues>>");
                    print(item.propertyValues);
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
