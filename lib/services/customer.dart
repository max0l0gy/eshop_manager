import 'dart:convert';

import 'package:E0ShopManager/utils/constants.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:json_annotation/json_annotation.dart';

import 'networking.dart';

part 'customer.g.dart';

const endpoint = EshopManagerProperties.API_ROOT_URL;
const getCustomerByIdUrl = '$endpoint/rest/api/private/customer/id/{id}';

class CommodityModel {
  late EshopManager eshopManager;
  late NetworkHelper _networkHelper;

  CommodityModel(this.eshopManager) {
    _networkHelper =
        NetworkHelper(basicCridentials: eshopManager.getCridentials());
  }

  Future<Customer> getById(int id) async {
    dynamic customer = await _networkHelper
        .getPrivateData(getCustomerByIdUrl.replaceAll('{id}', id.toString()));
    return _convertFromJson(customer);
  }

  Customer _convertFromJson(dynamic orders) {
    Customer convertedCustomer = Customer.fromJson(orders);
    convertedCustomer.fullName = utf8.decode(convertedCustomer.fullName.codeUnits);
    convertedCustomer.address = utf8.decode(convertedCustomer.address.codeUnits);
    return convertedCustomer;
  }
}

@JsonSerializable(explicitToJson: true)
class Customer {
  int id;
  String email;
  String fullName;
  String country;
  String postcode;
  String city;
  String address;

  Customer(this.id, this.email, this.fullName, this.country, this.postcode,
      this.city, this.address);

  factory Customer.empty() => Customer(0, '', '', '', '', '', '');


  String fullAddress() {
    return '$postcode , $country, $city, $address';
  }

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
