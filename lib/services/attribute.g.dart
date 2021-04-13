// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommodityAttribute _$CommodityAttributeFromJson(Map<String, dynamic> json) {
  return CommodityAttribute(
    json['id'] as int,
    json['name'] as String,
    json['dataType'] as String,
    json['measure'] as String?,
    (json['values'] as List<dynamic>)
        .map((e) => AttributeValue.fromJson(e))
        .toList(),
  );
}

Map<String, dynamic> _$CommodityAttributeToJson(CommodityAttribute instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'dataType': instance.dataType,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('measure', instance.measure);
  val['values'] = instance.values.map((e) => e.toJson()).toList();
  return val;
}

AttributeValue _$AttributeValueFromJson(Map<String, dynamic> json) {
  return AttributeValue(
    json['id'] as int,
    json['value'],
  );
}

Map<String, dynamic> _$AttributeValueToJson(AttributeValue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
    };

RequestAttributeValue _$RequestAttributeValueFromJson(
    Map<String, dynamic> json) {
  return RequestAttributeValue(
    typeId: json['typeId'] as int,
    name: json['name'] as String,
    dataType: json['dataType'] as String,
    measure: json['measure'] as String?,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$RequestAttributeValueToJson(
    RequestAttributeValue instance) {
  final val = <String, dynamic>{
    'typeId': instance.typeId,
    'name': instance.name,
    'dataType': instance.dataType,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('measure', instance.measure);
  val['value'] = instance.value;
  return val;
}
