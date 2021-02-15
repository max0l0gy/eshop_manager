import 'package:E0ShopManager/utils/constants.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:json_annotation/json_annotation.dart';

import 'networking.dart';
part 'customer_order.g.dart';

const endpoint = EshopManagerProperties.managerEndpoint;
const listAllOrdersUrl = '$endpoint/rest/api/private/order/list/';
const orderStatusUpdate = '$endpoint/rest/api/private/order/{id}/{status}';

class OrderModel {
  static Map<String, String> _actions = {
    'PAYMENT_APPROVED': 'Paid',
    'PREPARING_TO_SHIP': 'Preparing to shipment',
    'DISPATCHED': 'Dispatched',
    'DELIVERED': 'Delivered',
    'CANCELED_BY_CUSTOMER': 'Canceled by customer',
    'CANCELED_BY_ADMIN': 'Cancel'
  };
  final EshopManager eshopManager;
  NetworkHelper _networkHelper;

  OrderModel(this.eshopManager) {
    _networkHelper =
        NetworkHelper(basicCridentials: eshopManager.getCridentials());
  }

  static String actionName(String status) {
    return _actions[status];
  }

  Future<OrderGrid> getAllOrders() async {
    dynamic orders = await _networkHelper.getPrivateData(listAllOrdersUrl);
    print(orders);
    return _convertOrders(orders);
  }

  Future<dynamic> setOrderStatus(int id, String status) async {
    String setStatusUrl = orderStatusUpdate.replaceAll('{id}', id.toString());
    setStatusUrl = setStatusUrl.replaceAll('{status}', status);
    print(setStatusUrl);
    dynamic message = await _networkHelper.putData(setStatusUrl, null);
    return message;
  }

  OrderGrid _convertOrders(dynamic orders) {
    return OrderGrid.fromJson(orders);
  }
}

@JsonSerializable(explicitToJson: true)
class OrderGrid {
  int totalPages;
  int currentPage;
  int totalRecords;
  List<CustomerOrder> orderData;

  OrderGrid(
      this.totalPages, this.currentPage, this.totalRecords, this.orderData);

  factory OrderGrid.fromJson(Map<String, dynamic> json) =>
      _$OrderGridFromJson(json);
  Map<String, dynamic> toJson() => _$OrderGridToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CustomerOrder {
  int id;
  int customerId;
  DateTime dateOfCreation;
  String status;
  String paymentProvider;
  String paymentID;
  double totalPrice;
  List<Purchase> purchases;
  List<OrderAction> actions;

  CustomerOrder(
      this.id,
      this.customerId,
      this.dateOfCreation,
      this.status,
      this.paymentProvider,
      this.paymentID,
      this.totalPrice,
      this.purchases,
      this.actions);

  factory CustomerOrder.fromJson(Map<String, dynamic> json) =>
      _$CustomerOrderFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerOrderToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderAction {
  int id;
  String action;

  OrderAction(this.id, this.action);

  factory OrderAction.fromJson(Map<String, dynamic> json) =>
      _$OrderActionFromJson(json);
  Map<String, dynamic> toJson() => _$OrderActionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Purchase {
  int amount;
  int branchId;
  int commodityId;
  String name;
  String shortDescription;
  String overview;
  DateTime dateOfCreation;
  String type;
  double price;
  String currency;
  List<String> images;
  List<Attribute> attributes;

  Purchase(
      this.amount,
      this.branchId,
      this.commodityId,
      this.name,
      this.shortDescription,
      this.overview,
      this.dateOfCreation,
      this.type,
      this.price,
      this.currency,
      this.images,
      this.attributes);

  factory Purchase.fromJson(Map<String, dynamic> json) =>
      _$PurchaseFromJson(json);
  Map<String, dynamic> toJson() => _$PurchaseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Attribute {
  String name;
  String value;
  String measure;

  Attribute(this.name, this.value, this.measure);

  factory Attribute.fromJson(Map<String, dynamic> json) =>
      _$AttributeFromJson(json);
  Map<String, dynamic> toJson() => _$AttributeToJson(this);
}
