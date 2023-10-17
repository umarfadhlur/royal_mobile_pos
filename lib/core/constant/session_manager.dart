import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static final String keyLoggedIn = 'isLoggedIn';
  static final String keyUsername = 'username';

  // Fungsi untuk menyimpan status login
  static Future<void> setLoggedIn(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyLoggedIn, isLoggedIn);
  }

  // Fungsi untuk menyimpan username
  static Future<void> setUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyUsername, username);
  }

  // Fungsi untuk mendapatkan status login
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyLoggedIn) ?? false;
  }

  // Fungsi untuk mendapatkan username
  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUsername) ?? '';
  }

  // Fungsi untuk logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyLoggedIn);
    await prefs.remove(keyUsername);
  }
}