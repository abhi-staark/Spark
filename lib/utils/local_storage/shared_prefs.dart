import 'package:shared_preferences/shared_preferences.dart';
import 'package:spark/utils/local_storage/helper.dart';

class SharedPrefs{
Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  // Save Login Status
  Future<bool> saveLoginStatus(bool isLoggedIn) async {
    final prefs = await _getPrefs();
    return prefs.setBool(SharedPrefsKeys.loginStatus, isLoggedIn);
  }

  // Fetch Login Status
  Future<bool?> getLoginStatus() async {
    final prefs = await _getPrefs();
    return prefs.getBool(SharedPrefsKeys.loginStatus);
  }

  // // Save User Details (assuming a User class)
  // Future<bool> saveUserDetails(User user) async {
  //   final prefs = await _getPrefs();
  //   // Encode the User object to JSON before saving
  //   final String encodedUser = jsonEncode(user.toJson());
  //   return prefs.setString('userDetails', encodedUser);
  // }

  // // Fetch User Details
  // Future<User?> fetchUserDetails() async {
  //   final prefs = await _getPrefs();
  //   final String? encodedUser = prefs.getString('userDetails');
  //   if (encodedUser != null) {
  //     // Decode the JSON string back to a User object
  //     return User.fromJson(jsonDecode(encodedUser));
  //   } else {
  //     return null; // Return null if no user details are found
  //   }
  // }

  // Remove Login Status
  Future<bool> removeLoginStatus() async {
    final prefs = await _getPrefs();
    return prefs.remove(SharedPrefsKeys.loginStatus,);
  }

  // Delete User Details
  Future<bool> deleteUserDetails() async {
    final prefs = await _getPrefs();
    prefs.clear();
    return prefs.remove('userDetails');

  }
  }