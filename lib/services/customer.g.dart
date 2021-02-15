// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer(
    json['id'] as int,
    json['email'] as String,
    json['fullName'] as String,
    json['country'] as String,
    json['postcode'] as String,
    json['city'] as String,
    json['address'] as String,
  );
}

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'country': instance.country,
      'postcode': instance.postcode,
      'city': instance.city,
      'address': instance.address,
    };
