// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commodity_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommodityType _$CommodityTypeFromJson(Map<String, dynamic> json) {
  return CommodityType(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$CommodityTypeToJson(CommodityType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
