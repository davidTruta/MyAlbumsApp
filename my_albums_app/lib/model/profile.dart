import 'package:json_annotation/json_annotation.dart';

import 'address.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  Address? address;

  Profile(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.address});

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

}
