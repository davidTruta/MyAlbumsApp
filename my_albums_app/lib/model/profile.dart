import 'address.dart';

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
}
