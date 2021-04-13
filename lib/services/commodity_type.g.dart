// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commodity_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommodityType _$CommodityTypeFromJson(Map<String, dynamic> json) {
  return CommodityType(
    id: json['id'] as int?,
    name: json['name'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$CommodityTypeToJson(CommodityType instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  val['description'] = instance.description;
  return val;
}
