import 'dart:convert';

import 'package:E0ShopManager/utils/constants.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:json_annotation/json_annotation.dart';

import 'networking.dart';

part 'portfolio.g.dart';

const endpoint = EshopManagerProperties.API_ROOT_URL;
const portfoliosUrl = '$endpoint/rest/api/public/portfolios';
const addPortfolioUrl = '$endpoint/rest/api/private/portfolios';
const updatePortfolioUrl = addPortfolioUrl;

class PortfolioModel {
  final EshopManager eshopManager;
  late NetworkHelper _networkHelper;

  PortfolioModel({required this.eshopManager}) {
    _networkHelper =
        NetworkHelper(basicCridentials: eshopManager.getCridentials());
  }

  Future<List<Portfolio>?> portfolios() async {
    print('Load portfolios from $portfoliosUrl');
    dynamic response = await _networkHelper.getData(portfoliosUrl);
    return _convertPortfoliosFromJson(response).data;
  }

  Future<Portfolio?> create(Portfolio portfolio) async {
    dynamic response = await _networkHelper.postData(
      addPortfolioUrl,
      portfolio.toJsonString(),
    );
    return _convertPortfolioFromJson(response).data;
  }

  Future<Portfolio?> update(Portfolio portfolio) async {
    dynamic response = await _networkHelper.putData(
      updatePortfolioUrl,
      portfolio.toJsonString(),
    );
    return _convertPortfolioFromJson(response).data;
  }

  PortfoliosResponse _convertPortfoliosFromJson(dynamic eshopResponse) {
    return PortfoliosResponse.fromJson(eshopResponse);
  }

  PortfolioResponse _convertPortfolioFromJson(dynamic eshopResponse) {
    return PortfolioResponse.fromJson(eshopResponse);
  }
}

@JsonSerializable(explicitToJson: true)
class PortfolioResponse {
  late String status;
  @JsonKey(includeIfNull: false)
  late Portfolio? data;

  PortfolioResponse(
    this.status,
    this.data,
  );

  factory PortfolioResponse.fromJson(Map<String, dynamic> json) =>
      _$PortfolioResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PortfoliosResponse {
  late String status;
  @JsonKey(includeIfNull: false)
  late List<Portfolio>? data;

  PortfoliosResponse(
    this.status,
    this.data,
  );

  factory PortfoliosResponse.fromJson(Map<String, dynamic> json) =>
      _$PortfoliosResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PortfoliosResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Portfolio {
  @JsonKey(includeIfNull: false)
  int? id;
  late String name;
  late String description;
  late String shortDescription;
  List<String?> images;

  Portfolio.create({
    this.id,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.images,
  }) {
    if (this.images.isEmpty) {
      this.images.add('');
    }
  }

  Portfolio(
    this.id,
    this.name,
    this.description,
    this.shortDescription,
    this.images,
  );

  factory Portfolio.fromJson(Map<String, dynamic> json) =>
      _$PortfolioFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioToJson(this);

  String toJsonString() => jsonEncode(toJson());
}
