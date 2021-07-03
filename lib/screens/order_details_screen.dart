import 'dart:convert';

import 'package:E0ShopManager/services/customer.dart';
import 'package:E0ShopManager/services/customer_order.dart';
import 'package:E0ShopManager/utils/constants.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetailScreen extends StatefulWidget {
  final EshopManager eshopManager;
  final CustomerOrder customerOrder;

  OrderDetailScreen(this.eshopManager, this.customerOrder);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late CommodityModel _customerModel;
  Customer _customer = Customer.empty();

  @override
  Widget build(BuildContext context) {
    CustomerOrder order = widget.customerOrder;
    String currency =
        order.purchases.length > 0 ? order.purchases[0].currency : '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${widget.customerOrder.id} details'),
      ),
      body: Column(
        children: [
          OrderDetailsCard(
            customer: _customer,
            eshopManager: widget.eshopManager,
            orderId: order.id,
            totalPrice: order.totalPrice,
            dateOfOreder: order.dateOfCreation,
            currencyCode: currency,
            actions: order.actions,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              itemExtent: 106.0,
              children: _purchases(order.purchases),
            ),
          ),
        ],
      ),
    );
  }

  List<PurchaseListItem> _purchases(List<Purchase> purchases) {
    print(purchases[0].images[0]);
    return purchases
        .map(
          (p) => PurchaseListItem(
            attributes: p.attributes,
            amount: p.amount,
            thumbnail: FadeInImage.assetNetwork(
              width: 600,
              height: 800,
              fadeInCurve: Curves.bounceIn,
              fit: BoxFit.contain,
              image: p.images[0],
              placeholder: 'images/placeholder.png',
            ),
            title: p.name,
            productCode: p.commodityId.toString(),
          ),
        )
        .toList();
  }

  void _updateOrderStateAction() async {
    if (_formKey.currentState!.validate()) {
      //todo update order state
      var resp = null;
      Navigator.pop(context, resp);
    }
  }

  Future<void> _loadCustomer() async {
    Customer c = await _customerModel.getById(widget.customerOrder.customerId);
    if (c != null)
      setState(() {
        _customer = c;
      });
  }

  @override
  void initState() {
    _customerModel = CommodityModel(widget.eshopManager);
    _loadCustomer();
  }
}

class OrderDetailsCard extends StatelessWidget {
  final Customer customer;
  final int orderId;
  final double totalPrice;
  final int dateOfOreder;
  final String currencyCode;
  final List<OrderAction> actions;
  final EshopManager eshopManager;

  const OrderDetailsCard({
    required this.customer,
    required this.orderId,
    required this.totalPrice,
    required this.dateOfOreder,
    required this.currencyCode,
    required this.actions,
    required this.eshopManager,
  });

  Future<void> _actionButtonPressed(OrderAction action, context) async {
    print('_actionButtonPressed');
    print(action.action);
    var resp =
        await OrderModel(eshopManager).setOrderStatus(orderId, action.action);
    if (resp != null) {
      print('SET ORDER RESP');
      print(resp);
      Navigator.pop(context, resp);
    }
  }

  List<Widget> _convertActions(BuildContext context) {
    return actions
        .map(
          (a) => RaisedButton(
            onPressed: () {
              _actionButtonPressed(a, context);
            },
            child: Text(
              a.action,
              style: TextStyle(fontSize: 20),
            ),
          ),
        )
        .toList();
  }

  Widget _actionButtons(BuildContext context) {
    return ButtonBar(
      children: _convertActions(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            Row(
              children: [
                EshopHeading('Order #'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(orderId.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text('date: '),
                ),
                Text(DateTime.fromMillisecondsSinceEpoch(dateOfOreder).toIso8601String()),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
              child: Row(
                children: [
                  EshopHeading('Total price:'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(totalPrice.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text(currencyCode),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                children: [
                  EshopHeading('Customer:'),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('${customer.fullName} | ${customer.email}'),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                children: [
                  EshopHeading('Delivery address:'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text('${customer.fullAddress()}'),
            ),
            _actionButtons(context),
          ],
        ),
      ),
    );
  }
}

class PurchaseListItem extends StatelessWidget {
  const PurchaseListItem({
    required this.thumbnail,
    required this.title,
    required this.attributes,
    required this.amount,
    required this.productCode,
  });

  final Widget thumbnail;
  final String title;
  final List<Attribute> attributes;
  final int amount;
  final String productCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              child: thumbnail,
              width: 200,
              height: 600,
            ),
          ),
          Expanded(
            flex: 3,
            child: _PurchaseDescription(
              title: title,
              attributes: attributes,
              amount: amount,
              productCode: productCode,
            ),
          ),
          const Icon(
            Icons.more_vert,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}

class _PurchaseDescription extends StatelessWidget {
  const _PurchaseDescription({
    Key? key,
    required this.title,
    required this.attributes,
    required this.amount,
    required this.productCode,
  }) : super(key: key);

  final String title;
  final List<Attribute> attributes;
  final int amount;
  final String productCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          _convertAttributes(),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            'Amount: $amount',
            style: const TextStyle(fontSize: 10.0),
          ),
          Text(
            'Code: $productCode',
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }

  Widget _convertAttributes() {
    return Column(
      children: attributes
          .map((e) => Row(
                children: [
                  EshopAttribute(e.name),
                  Padding(
                    child: EshopAttribute(e.value),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  ),
                  EshopAttribute(e.measure ?? ''),
                ],
              ))
          .toList(),
    );
  }
}
