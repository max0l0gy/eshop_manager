import 'package:E0ShopManager/screens/order_details_screen.dart';
import 'package:E0ShopManager/services/customer_order.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  final EshopManager eshopManager;

  OrdersScreen(this.eshopManager);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Widget> _ordersListView = [];
  late OrderModel _orderModel;

  void _updateUI(OrderGrid orderGrid) {
    if (orderGrid != null) {
      setState(() {
        _ordersListView = _getOrderListView(orderGrid.orderData);
        print('Loaded orders');
        print(orderGrid);
      });
    } else {
      //
      print('Show error');
    }
  }

  List<Widget> _getOrderListView(List<CustomerOrder> orders) {
    return orders
        .map(
          (order) => Card(
            child: ListTile(
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('#${order.id}'),
                  ),
                  Column(
                    children: [
                      Text(order.status),
                      Text('total price: ${order.totalPrice}'),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                onPressed: () {
                  _navigateToDetails(order);
                },
                icon: Icon(
                  Icons.info,
                  color: Colors.yellow,
                ),
                tooltip: 'Order Details',
              ),
            ),
          ),
        )
        .toList();
  }

  void _navigateToDetails(CustomerOrder order) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return OrderDetailScreen(widget.eshopManager, order);
        },
      ),
    );
    if (result != null) {
      print(result);
      //update type
      _loadOrders();
      final snackBar = SnackBar(content: Text('Order status Added'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void _loadOrders() async {
    OrderGrid orders = await _orderModel.getAllOrders();
    _updateUI(orders);
  }

  @override
  void initState() {
    _orderModel = OrderModel(widget.eshopManager);
    _loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
        ),
        body: ListView(
          children: _ordersListView,
        ));
  }
}
