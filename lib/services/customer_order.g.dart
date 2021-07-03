// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderGrid _$OrderGridFromJson(Map<String, dynamic> json) {
  return OrderGrid(
    json['totalPages'] as int,
    json['currentPage'] as int,
    json['totalRecords'] as int,
    (json['orderData'] as List<dynamic>)
        .map((e) => CustomerOrder.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OrderGridToJson(OrderGrid instance) => <String, dynamic>{
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
      'totalRecords': instance.totalRecords,
      'orderData': instance.orderData.map((e) => e.toJson()).toList(),
    };

CustomerOrder _$CustomerOrderFromJson(Map<String, dynamic> json) {
  return CustomerOrder(
    json['id'] as int,
    json['customerId'] as int,
    json['dateOfCreation'] as int,
    json['status'] as String,
    json['paymentProvider'] as String,
    json['paymentID'] as String,
    (json['totalPrice'] as num).toDouble(),
    (json['purchases'] as List<dynamic>)
        .map((e) => Purchase.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['actions'] as List<dynamic>)
        .map((e) => OrderAction.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CustomerOrderToJson(CustomerOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'dateOfCreation': instance.dateOfCreation,
      'status': instance.status,
      'paymentProvider': instance.paymentProvider,
      'paymentID': instance.paymentID,
      'totalPrice': instance.totalPrice,
      'purchases': instance.purchases.map((e) => e.toJson()).toList(),
      'actions': instance.actions.map((e) => e.toJson()).toList(),
    };

OrderAction _$OrderActionFromJson(Map<String, dynamic> json) {
  return OrderAction(
    json['id'] as int,
    json['action'] as String,
  );
}

Map<String, dynamic> _$OrderActionToJson(OrderAction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action': instance.action,
    };

Purchase _$PurchaseFromJson(Map<String, dynamic> json) {
  return Purchase(
    json['amount'] as int,
    json['branchId'] as int,
    json['commodityId'] as int,
    json['name'] as String,
    json['shortDescription'] as String,
    json['overview'] as String,
    json['dateOfCreation'] as int,
    json['type'] as String,
    (json['price'] as num).toDouble(),
    json['currency'] as String,
    (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    (json['attributes'] as List<dynamic>)
        .map((e) => Attribute.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PurchaseToJson(Purchase instance) => <String, dynamic>{
      'amount': instance.amount,
      'branchId': instance.branchId,
      'commodityId': instance.commodityId,
      'name': instance.name,
      'shortDescription': instance.shortDescription,
      'overview': instance.overview,
      'dateOfCreation': instance.dateOfCreation,
      'type': instance.type,
      'price': instance.price,
      'currency': instance.currency,
      'images': instance.images,
      'attributes': instance.attributes.map((e) => e.toJson()).toList(),
    };

Attribute _$AttributeFromJson(Map<String, dynamic> json) {
  return Attribute(
    json['name'] as String,
    json['value'] as String,
    json['measure'] as String,
  );
}

Map<String, dynamic> _$AttributeToJson(Attribute instance) => <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'measure': instance.measure,
    };
