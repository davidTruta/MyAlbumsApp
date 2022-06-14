import 'package:my_albums_app/model/address.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/profile.dart';

class ProfileRepo {
  Future<void> saveProfile(Profile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile');
    await prefs.setString('profile',
        "${profile.id},${profile.firstName},${profile.lastName},${profile.email},${profile.phone},${profile.address!.id},${profile.address!.street},${profile.address!.country},${profile.address!.city},${profile.address!.zipCode}");
  }

  Future<Profile> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final String? profile = prefs.getString('profile');
      final args = profile!.split(",");
      return Profile(
        id: int.parse(args[0]),
        firstName: args[1],
        lastName: args[2],
        email: args[3],
        phone: args[4],
        address: Address(
            id: int.parse(args[5]),
            street: args[6],
            country: args[7],
            city: args[8],
            zipCode: args[9]),
      );
    } catch (err) {
      rethrow;
    }
  }
}
