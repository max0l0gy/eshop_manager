import 'dart:convert';
import 'package:E0ShopManager/utils/constants.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:json_annotation/json_annotation.dart';
import 'networking.dart';
part 'commodity_type.g.dart';

const endpoint = EshopManagerProperties.managerEndpoint;
const listTypesUrl = '$endpoint/rest/api/public/types/';
const addTypeUrl = '$endpoint/rest/api/private/type/';
const deleteTypeUrl = '$endpoint/rest/api/private/type/{id}';

class TypesModel {
  final EshopManager eshopManager;
  NetworkHelper _networkHelper;

  TypesModel(this.eshopManager) {
    _networkHelper =
        NetworkHelper(basicCridentials: eshopManager.getCridentials());
  }

  Future<List<CommodityType>> getTypes() async {
    dynamic types = await _networkHelper.getData(listTypesUrl);
    return _convertTypesFromJson(types);
  }

  List<CommodityType> _convertTypesFromJson(List dynamic) {
    return dynamic.map((e) => CommodityType.fromJson(e)).toList();
  }

  Future<dynamic> addType(CommodityType ct) async {
    dynamic message =
        await _networkHelper.postData(addTypeUrl, ct.toJsonString());
    return message;
  }

  Future<dynamic> deleteType(int id) async {
    dynamic message = await _networkHelper
        .deleteData(deleteTypeUrl.replaceAll('{id}', id.toString()));
    return message;
  }
}

@JsonSerializable(explicitToJson: true)
class CommodityType {
  final int id;
  final String name;
  final String description;

  CommodityType({this.id, this.name, this.description});

  factory CommodityType.fromJson(Map<String, dynamic> json) =>
      _$CommodityTypeFromJson(json);
  Map<String, dynamic> toJson() => _$CommodityTypeToJson(this);

  String toJsonString() => jsonEncode(toJson());
}
