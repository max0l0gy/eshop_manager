// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioResponse _$PortfolioResponseFromJson(Map<String, dynamic> json) {
  return PortfolioResponse(
    json['status'] as String,
    json['data'] == null
        ? null
        : Portfolio.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PortfolioResponseToJson(PortfolioResponse instance) {
  final val = <String, dynamic>{
    'status': instance.status,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data?.toJson());
  return val;
}

PortfoliosResponse _$PortfoliosResponseFromJson(Map<String, dynamic> json) {
  return PortfoliosResponse(
    json['status'] as String,
    (json['data'] as List<dynamic>?)
        ?.map((e) => Portfolio.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PortfoliosResponseToJson(PortfoliosResponse instance) {
  final val = <String, dynamic>{
    'status': instance.status,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data?.map((e) => e.toJson()).toList());
  return val;
}

Portfolio _$PortfolioFromJson(Map<String, dynamic> json) {
  return Portfolio(
    json['id'] as int?,
    json['name'] as String,
    json['description'] as String,
    json['shortDescription'] as String,
    (json['images'] as List<dynamic>).map((e) => e as String?).toList(),
  );
}

Map<String, dynamic> _$PortfolioToJson(Portfolio instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  val['description'] = instance.description;
  val['shortDescription'] = instance.shortDescription;
  val['images'] = instance.images;
  return val;
}
