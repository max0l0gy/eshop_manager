// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commodity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    json['status'] as String,
    json['url'] as String,
    json['message'] as String,
    (json['errors'] as List<dynamic>)
        .map((e) => ErrorDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'status': instance.status,
      'url': instance.url,
      'message': instance.message,
      'errors': instance.errors.map((e) => e.toJson()).toList(),
    };

ErrorDetail _$ErrorDetailFromJson(Map<String, dynamic> json) {
  return ErrorDetail(
    json['field'] as String,
    json['message'] as String,
  );
}

Map<String, dynamic> _$ErrorDetailToJson(ErrorDetail instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

CommodityGrid _$CommodityGridFromJson(Map<String, dynamic> json) {
  return CommodityGrid(
    json['totalPages'] as int,
    json['currentPage'] as int,
    json['totalRecords'] as int,
    (json['commodityData'] as List<dynamic>)
        .map((e) => Commodity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CommodityGridToJson(CommodityGrid instance) =>
    <String, dynamic>{
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
      'totalRecords': instance.totalRecords,
      'commodityData': instance.commodityData.map((e) => e.toJson()).toList(),
    };

Commodity _$CommodityFromJson(Map<String, dynamic> json) {
  return Commodity(
    json['id'] as int,
    json['name'] as String,
    json['shortDescription'] as String,
    json['overview'] as String,
    json['dateOfCreation'] as int,
    CommodityType.fromJson(json['type'] as Map<String, dynamic>),
    (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    (json['branches'] as List<dynamic>)
        .map((e) => CommodityBranch.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CommodityToJson(Commodity instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortDescription': instance.shortDescription,
      'overview': instance.overview,
      'dateOfCreation': instance.dateOfCreation,
      'type': instance.type.toJson(),
      'images': instance.images,
      'branches': instance.branches.map((e) => e.toJson()).toList(),
    };

CommodityBranch _$CommodityBranchFromJson(Map<String, dynamic> json) {
  return CommodityBranch(
    json['id'] as int,
    json['commodityId'] as int,
    json['amount'] as int,
    (json['price'] as num).toDouble(),
    json['currency'] as String,
    (json['attributes'] as List<dynamic>)
        .map((e) => AttributeDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CommodityBranchToJson(CommodityBranch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'commodityId': instance.commodityId,
      'amount': instance.amount,
      'price': instance.price,
      'currency': instance.currency,
      'attributes': instance.attributes.map((e) => e.toJson()).toList(),
    };

AttributeDto _$AttributeDtoFromJson(Map<String, dynamic> json) {
  return AttributeDto(
    json['name'] as String,
    json['value'] as String,
    json['measure'] as String,
  );
}

Map<String, dynamic> _$AttributeDtoToJson(AttributeDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'measure': instance.measure,
    };

RequestCommodity _$RequestCommodityFromJson(Map<String, dynamic> json) {
  return RequestCommodity(
    name: json['name'] as String,
    shortDescription: json['shortDescription'] as String,
    overview: json['overview'] as String,
    amount: json['amount'] as int,
    price: (json['price'] as num).toDouble(),
    currencyCode: json['currencyCode'] as String,
    typeId: json['typeId'] as int,
    propertyValues:
        (json['propertyValues'] as List<dynamic>).map((e) => e as int).toSet(),
    images: (json['images'] as List<dynamic>).map((e) => e as String?).toList(),
    branchId: json['branchId'] as int,
  );
}

Map<String, dynamic> _$RequestCommodityToJson(RequestCommodity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'shortDescription': instance.shortDescription,
      'overview': instance.overview,
      'amount': instance.amount,
      'price': instance.price,
      'currencyCode': instance.currencyCode,
      'typeId': instance.typeId,
      'propertyValues': instance.propertyValues.toList(),
      'images': instance.images,
      'branchId': instance.branchId,
    };
