import 'dart:convert';
import 'package:E0ShopManager/utils/constants.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:json_annotation/json_annotation.dart';
import 'networking.dart';
part 'attribute.g.dart';

const endpoint = EshopManagerProperties.API_ROOT_URL;
const listAttributesUrl = '$endpoint/rest/api/public/attributes/{typeId}';
const addAttributeUrl = '$endpoint/rest/api/private/attribute/';
const deleteAttributeValueUrl =
    '$endpoint/rest/api/private/attributeValue/{id}';
const listDataTypesUrl = '$endpoint/rest/api/public/attribute/value/dataTypes/';

class AttributeModel {
  late EshopManager eshopManager;
  late NetworkHelper _networkHelper;

  AttributeModel(this.eshopManager) {
    _networkHelper =
        NetworkHelper(basicCridentials: eshopManager.getCridentials());
  }

  Future<List<CommodityAttribute>> getAttributes(int typeId) async {
    dynamic attributes = await _networkHelper
        .getData(listAttributesUrl.replaceAll('{typeId}', typeId.toString()));
    return _convertAttributes(attributes);
  }

  List<CommodityAttribute> _convertAttributes(List attributes) {
    return attributes.map((e) => CommodityAttribute.fromJson(e)).toList();
  }

  Future<List<String>> getDataTypes() async {
    dynamic dataTypes = await _networkHelper.getData(listDataTypesUrl);
    return _convertDataTypes(dataTypes);
  }

  Future<dynamic> deleteAttribute(int valueId) async {
    dynamic message = await _networkHelper.deleteData(
        deleteAttributeValueUrl.replaceAll('{id}', valueId.toString()));
    return message;
  }

  List<String> _convertDataTypes(List dataTypes) {
    return dataTypes.map((e) => e.toString()).toList();
  }

  Future<dynamic> addAttribute(RequestAttributeValue attribute) async {
    dynamic message = await _networkHelper.postData(
        addAttributeUrl, attribute.toJsonString());
    return message;
  }
}

@JsonSerializable(explicitToJson: true)
class CommodityAttribute {
  final int id;
  final String name;
  final String dataType;
  @JsonKey(includeIfNull: false)
  final String? measure;
  final List<AttributeValue> values;

  CommodityAttribute(
      this.id, this.name, this.dataType, this.measure, this.values);

  factory CommodityAttribute.fromJson(dynamic json) =>
      _$CommodityAttributeFromJson(json);
  Map<String, dynamic> toJson() => _$CommodityAttributeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AttributeValue {
  final int id;
  final dynamic value;

  AttributeValue(this.id, this.value);

  factory AttributeValue.fromJson(dynamic json) =>
      _$AttributeValueFromJson(json);
  Map<String, dynamic> toJson() => _$AttributeValueToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RequestAttributeValue {
  late int typeId;
  late String name;
  late String dataType;
  @JsonKey(includeIfNull: false)
  String? measure;
  late String value;

  RequestAttributeValue({
    required this.typeId,
    required this.name,
    required this.dataType,
    required this.measure,
    required this.value,
  });

  Map<String, dynamic> toJson() => _$RequestAttributeValueToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
