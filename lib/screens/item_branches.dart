import 'package:E0ShopManager/components/commodity.dart';
import 'package:E0ShopManager/services/commodity.dart';
import 'package:E0ShopManager/utils/constants.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:E0ShopManager/validators/commodity_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'item_branch_edit.dart';

class ItemBranchesScreen extends StatefulWidget {
  final EshopManager eshopManager;
  final Commodity commodity;

  ItemBranchesScreen(this.eshopManager, this.commodity);

  @override
  _ItemBranchesState createState() => _ItemBranchesState();
}

class _ItemBranchesState extends State<ItemBranchesScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late CommodityModel _itemModel;
  late Commodity _item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Item id.${widget.commodity.id} branches'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 8, 20),
            child: ListView(
              children: _itemComponents(),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SaveCommodityInfoButton(
              eshopManager: widget.eshopManager,
              item: _item,
              itemModel: _itemModel,
              formGlobalKey: _formKey,
            ),
          ],
        ));
  }

  List<Widget> _itemComponents() {
    List<Widget> components = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ItemDetailsCard(
          eshopManager: widget.eshopManager,
          item: _item,
          itemModel: _itemModel,
        ),
      ),
    ];
    components.addAll(_branches());
    return components;
  }

  List<Widget> _branches() {
    return widget.commodity.branches
        .map(
          (e) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: BranchView(
              branch: e,
              item: widget.commodity,
              eshopManager: widget.eshopManager,
            ),
          ),
        )
        .toList();
  }

  @override
  void initState() {
    _item = widget.commodity;
    _itemModel = CommodityModel(widget.eshopManager);
  }
}

class SaveCommodityInfoButton extends StatelessWidget {
  final EshopManager eshopManager;
  final Commodity item;
  final CommodityModel itemModel;
  final GlobalKey<FormState> formGlobalKey;

  const SaveCommodityInfoButton(
      {Key? key,
      required this.eshopManager,
      required this.item,
      required this.itemModel,
      required this.formGlobalKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Builder(builder: (BuildContext context) {
        return MaterialButton(
          height: 50.0,
          shape: CircleBorder(),
          color: Colors.lime,
          onPressed: () async {
            if (formGlobalKey.currentState!.validate()) {
              print('Ready to update item ${item.name}');
              Message mess = await itemModel.updateCommodity(item);
              print('MESSAGE ${mess.message}');
              //_itemUpdate.
              //_navigateToNewBranch(context);
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Success')));
            }
          },
          child: const Icon(Icons.save),
        );
      });

  void _navigateToNewBranch(BuildContext context) {}
}

class AddBranchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Builder(builder: (BuildContext context) {
        return new FloatingActionButton(
          onPressed: () {
            _navigateToNewBranch(context);
          },
          tooltip: 'Add item branch',
          child: const Icon(Icons.add),
        );
      });

  void _navigateToNewBranch(BuildContext context) {}
}

class ItemDetailsCard extends StatefulWidget {
  final EshopManager eshopManager;
  final Commodity item;
  final CommodityModel itemModel;

  const ItemDetailsCard({
    required this.eshopManager,
    required this.item,
    required this.itemModel,
  });

  @override
  State<StatefulWidget> createState() => _ItemDetailsCardState(
        item: this.item,
        eshopManager: this.eshopManager,
      );
}

class _ItemDetailsCardState extends State<StatefulWidget> {
  final _formKey = GlobalKey<FormState>();
  final Commodity item;
  final EshopManager eshopManager;

  _ItemDetailsCardState({required this.item, required this.eshopManager});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            EshopHeading('Item id.'),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Text(item.id.toString()),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text('created: '),
                            ),
                            Text(DateFormat('dd-MM-yyyy – kk:mm').format(
                                DateTime.fromMicrosecondsSinceEpoch(
                                    item.dateOfCreation))),
                          ],
                        ),
                        Container(
                          width: 200,
                          child: TextFormField(
                            maxLines: null,
                            initialValue: item.name,
                            decoration: const InputDecoration(
                              hintText: 'Enter item name',
                            ),
                            validator: CommodityValidation.name,
                            onChanged: (value) {
                              item.name = value.trim();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ItemUploadImage(
                    images: item.images,
                    eshopManager: eshopManager,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: TextFormField(
                maxLines: null,
                initialValue: item.shortDescription,
                decoration: const InputDecoration(
                  hintText: 'Enter short description',
                ),
                validator: CommodityValidation.shortDescription,
                onChanged: (value) {
                  item.shortDescription = value.trim();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 10),
              child: TextFormField(
                maxLines: null,
                initialValue: item.overview,
                decoration: const InputDecoration(
                  hintText: 'Enter overview',
                ),
                validator: CommodityValidation.overview,
                onChanged: (value) {
                  item.overview = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BranchView extends StatefulWidget {
  final EshopManager eshopManager;
  final CommodityBranch branch;
  final Commodity item;

  const BranchView(
      {required this.branch, required this.eshopManager, required this.item});

  @override
  State<StatefulWidget> createState() => BranchViewState();
}

class BranchViewState extends State<BranchView> {
  List<Widget> _attributes = [];
  int _amount = 0;
  double _price = 0.0;
  String _currency = '';

  List<Widget> _attributesToView() {
    return widget.branch.attributes
        .map((attribute) => Row(
              children: [
                EshopHeading('${attribute.name}: '),
                Text(attribute.value.toString()),
                Text(attribute.measure ?? '')
              ],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              onPressed: () {
                _navigateToEditBranch();
              },
              icon: Icon(
                Icons.edit,
                color: Colors.yellow,
              ),
              tooltip: 'Edit item branch',
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Column(
                  children: _attributes,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: _BranchDetails(
                  amount: _amount,
                  price: _price,
                  currency: _currency,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fromBranchToState() {
    setState(() {
      _attributes = _attributesToView();
      _amount = widget.branch.amount;
      _price = widget.branch.price;
      _currency = widget.branch.currency;
    });
  }

  @override
  void initState() {
    _fromBranchToState();
  }

  void _navigateToEditBranch() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ItemBranchEditScreen(
            widget.eshopManager,
            widget.branch,
            widget.item,
          );
        },
      ),
    );

    if (result != null) {
      final snackBar = SnackBar(content: Text('Branch updated'));
      Scaffold.of(context).showSnackBar(snackBar);
      _fromBranchToState();
    }
  }
}

class _BranchDetails extends StatelessWidget {
  const _BranchDetails({
    required this.amount,
    required this.price,
    required this.currency,
  });

  final int amount;
  final double price;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          EshopHeading('Amount: ${amount}'),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          EshopHeading('price: ${price} ${currency}'),
        ],
      ),
    );
  }
}
