import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  String? street;
  String? city;
  String? country;
  String? zipCode;

  Address({this.street, this.country, this.city, this.zipCode});

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Address &&
        other.street == street &&
        other.city == city &&
        other.country == country &&
        other.zipCode == zipCode;
  }

  @override
  int get hashCode => zipCode.hashCode;
}