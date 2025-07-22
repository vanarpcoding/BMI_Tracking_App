import 'package:shared_preferences/shared_preferences.dart';

Future<void> storedata(String name) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString("Myname", name);
}

Future<void> retreivedata() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var data = pref.getString("Myname");
  print(data);
}

Future<void> storebooldata(bool isUserLogin) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool("Login", isUserLogin);
}

Future<bool> retreivebooldata() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var data = pref.getBool("Login");
  if (data == null) {
    return false;
  } else {
    return data;
  }
}
