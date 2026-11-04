import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  /// ----- SETTERS -----
  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setBool('isLoggedIn', true);
  }

  Future<void> setEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  Future<void> setTokenOnly(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }


  Future<void> setId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
  }


  /// ----- GETTERS -----
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<String?> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }


  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  /// ----- CLEAR -----
  Future<void> clearLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
