// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as int?,
      street: json['street'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      zipCode: json['zipCode'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'street': instance.street,
      'city': instance.city,
      'country': instance.country,
      'zipCode': instance.zipCode,
    };
