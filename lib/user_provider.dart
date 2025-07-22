import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String username;
  final String password;

  User({required this.username, required this.password});
}

class UserProvider with ChangeNotifier {
  List<User> _users = [];

  UserProvider() {
    _loadUserData();
  }

  List<User> get users => _users;

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final usernames = prefs.getStringList('usernames') ?? ['pranav'];
    final passwords = prefs.getStringList('passwords') ?? ['pranav'];

    _users = List.generate(usernames.length, (index) {
      return User(username: usernames[index], password: passwords[index]);
    });
    notifyListeners();
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final usernames = _users.map((user) => user.username).toList();
    final passwords = _users.map((user) => user.password).toList();

    await prefs.setStringList('usernames', usernames);
    await prefs.setStringList('passwords', passwords);
  }

  void addUser(String username, String password) {
    _users.add(User(username: username, password: password));
    _saveUserData();
    notifyListeners();
  }

  void updatePassword(String username, String newPassword) {
    final index = _users.indexWhere((user) => user.username == username);
    if (index != -1) {
      _users[index] = User(username: username, password: newPassword);
      _saveUserData();
      notifyListeners();
    }
  }
}
