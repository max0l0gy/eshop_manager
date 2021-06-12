import 'package:E0ShopManager/screens/select_type_screen.dart';
import 'package:E0ShopManager/services/commodity.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:flutter/material.dart';

import 'item_branches.dart';

class ItemsScreen extends StatefulWidget {
  final EshopManager eshopManager;

  ItemsScreen(this.eshopManager);

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  List<Widget> _itemListView = [];
  late CommodityModel _commodityModel;

  void _updateUI(CommodityGrid commodityGrid) {
    if (commodityGrid != null) {
      setState(() {
        _itemListView = _getItemListView(commodityGrid.commodityData);
      });
    } else {
      //
      print('Show error');
    }
  }

  List<Widget> _getItemListView(List<Commodity> items) {
    return items
        .map(
          (item) => Card(
            child: ListTile(
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('id.${item.id}'),
                  ),
                  Column(
                    children: [
                      Text(item.name),
                      Text('type: ${item.type.name}'),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                onPressed: () {
                  _navigateToDetails(item);
                },
                icon: Icon(
                  Icons.info,
                  color: Colors.yellow,
                ),
                tooltip: 'Item branches and details',
              ),
            ),
          ),
        )
        .toList();
  }

  void _navigateToDetails(Commodity item) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ItemBranchesScreen(widget.eshopManager, item);
        },
      ),
    );
    if (result != null) {
      print(result);
      //update type
      _loadItems();
      final snackBar = SnackBar(content: Text('Item updated'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void _loadItems() async {
    CommodityGrid itemGrid = await _commodityModel.getCommodityGrid(1, 200);
    _updateUI(itemGrid);
  }

  @override
  void initState() {
    _commodityModel = CommodityModel(widget.eshopManager);
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 100),
        child: ListView(
          children: _itemListView,
        ),
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return new FloatingActionButton(
          onPressed: () {
            _navigateToAddCommodity(context);
          },
          tooltip: 'Add item',
          child: const Icon(Icons.add),
        );
      }),
    );
  }

  void _navigateToAddCommodity(BuildContext context) async {
    var resp = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return SelectTypeScreen(widget.eshopManager);
      }),
    );
    print('Resp from add item screen ${resp}');
    if (resp != null) _loadItems();
  }
}
