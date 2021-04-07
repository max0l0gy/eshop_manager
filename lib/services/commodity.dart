import 'dart:convert';
import 'dart:typed_data';

import 'package:E0ShopManager/utils/constants.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quiver/core.dart';

import 'commodity_type.dart';
import 'networking.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'commodity.g.dart';

const endpoint = EshopManagerProperties.managerEndpoint;
const listCommodityGridUrl =
    '$endpoint/rest/api/public/commodities/?page={page}&rows={rows}';
const fileUpload = '$endpoint/rest/api/private/file';
const addCommodityUrl = '$endpoint/rest/api/private/commodity/';
const updateCommodityUrl = '$endpoint/rest/api/private/commodity';
const updateBranchUrl = '$endpoint/rest/api/private/branch';

class CommodityModel {
  late EshopManager eshopManager;
  late NetworkHelper _networkHelper;

  CommodityModel(this.eshopManager) {
    _networkHelper =
        NetworkHelper(basicCridentials: eshopManager.getCridentials());
  }

  Future<String> uploadFile(UploadFile file) async {
    dynamic resp = await _networkHelper.postFile(file, fileUpload);
    return resp['uri'];
  }

  Future<CommodityGrid> getCommodityGrid(int page, int rows) async {
    String getUrl = listCommodityGridUrl.replaceAll('{page}', page.toString());
    getUrl = getUrl.replaceAll('{rows}', rows.toString());
    print('GET commodities URL=${getUrl}');
    dynamic items = await _networkHelper.getData(getUrl);
    print(items);
    return CommodityGrid.fromJson(items);
  }

  Future<Message> addCommodity(RequestCommodity rc) async {
    dynamic message =
        await _networkHelper.postData(addCommodityUrl, rc.toJsonString());
    return Message.fromJson(message);
  }

  Future<Message> updateCommodity(Commodity req) async {
    dynamic message =
        await _networkHelper.putData(updateCommodityUrl, req.toJsonString());
    return Message.fromJson(message);
  }

  Future<Message> updateBranch(CommodityBranch req) async {
    dynamic message =
        await _networkHelper.putData(updateBranchUrl, req.toJsonString());
    return Message.fromJson(message);
  }
}

class UploadFile {

  late String name;
  late Uint8List bytes;

  UploadFile({required this.name, required this.bytes});

}

@JsonSerializable(explicitToJson: true)
class Message {
  static String SUCCESS = 'success';
  static String ERROR = 'error';
  String status;
  String url;
  String message;
  List<ErrorDetail> errors;

  Message(this.status, this.url, this.message, this.errors);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ErrorDetail {
  String field;
  String message;

  ErrorDetail(this.field, this.message);

  factory ErrorDetail.fromJson(Map<String, dynamic> json) =>
      _$ErrorDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorDetailToJson(this);
}

/**
 * https://flutter.dev/docs/development/data-and-backend/json
 * One-time code generation
 * y running flutter pub run build_runner build in the project root, you generate JSON serialization code for your models whenever they are needed. This triggers a one-time build that goes through the source files, picks the relevant ones, and generates the necessary serialization code for them.
 */
@JsonSerializable(explicitToJson: true)
class CommodityGrid {
  int totalPages;
  int currentPage;
  int totalRecords;
  List<Commodity> commodityData;

  CommodityGrid(
      this.totalPages, this.currentPage, this.totalRecords, this.commodityData);

  factory CommodityGrid.fromJson(Map<String, dynamic> json) =>
      _$CommodityGridFromJson(json);

  Map<String, dynamic> toJson() => _$CommodityGridToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Commodity {
  int id;
  String name;
  String shortDescription;
  String overview;
  int dateOfCreation;
  CommodityType type;
  List<String> images;
  List<CommodityBranch> branches;

  Commodity(this.id, this.name, this.shortDescription, this.overview,
      this.dateOfCreation, this.type, this.images, this.branches);

  DateTime getDateOfCreation() {
    return DateTime.fromMillisecondsSinceEpoch(dateOfCreation);
  }

  factory Commodity.fromJson(Map<String, dynamic> json) =>
      _$CommodityFromJson(json);

  Map<String, dynamic> toJson() => _$CommodityToJson(this);

  String toJsonString() => jsonEncode(toJson());
}

@JsonSerializable(explicitToJson: true)
class CommodityBranch {
  int id;
  int commodityId;
  int amount;
  double price;
  String currency;
  List<AttributeDto> attributes;

  CommodityBranch(this.id, this.commodityId, this.amount, this.price,
      this.currency, this.attributes);

  factory CommodityBranch.fromJson(Map<String, dynamic> json) =>
      _$CommodityBranchFromJson(json);

  Map<String, dynamic> toJson() => _$CommodityBranchToJson(this);

  String toJsonString() => jsonEncode(toJson());
}

@JsonSerializable()
class AttributeDto {
  String name;
  String value;
  String measure;

  AttributeDto(this.name, this.value, this.measure);

  factory AttributeDto.fromJson(Map<String, dynamic> json) =>
      _$AttributeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeDtoToJson(this);

  String toJsonString() => jsonEncode(toJson());

  bool operator ==(o) =>
      o is AttributeDto &&
      o.name == name &&
      o.value == value &&
      o.measure == measure;

  int get hashCode =>
      hash3(name.hashCode, value.hashCode, measure ?? measure.hashCode);
}

@JsonSerializable()
class RequestCommodity {
  late String name;
  late String shortDescription;
  late String overview;
  late int amount;
  late double price;
  late String currencyCode;
  late int typeId;
  late Set<int> propertyValues = {};
  late List<String?> images = [];
  late int branchId;

  RequestCommodity({
      required this.name,
      required this.shortDescription,
      required this.overview,
      required this.amount,
      required this.price,
      required this.currencyCode,
      required this.typeId,
      required this.propertyValues,
      required this.images,
      required this.branchId});

  RequestCommodity.currencyCode({required this.currencyCode}) {
    if (this.propertyValues == null) propertyValues = {};
    if (this.images == null) {
      this.images = [];
      for (int i = 0; i < EshopNumbers.UPLOAD_IMAGES; i++) {
        images.add(null);
      }
    }
    if (this.amount == null) this.amount = 1;
    if (this.price == null) this.price = 50;
  }

  Map<String, dynamic> toJson() => _$RequestCommodityToJson(this);

  String toJsonString() => jsonEncode(toJson());
}
