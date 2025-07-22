import 'package:basic_flutter/firstpage.dart';
//import 'package:basic_flutter/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';
//import 'projectlogin.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splashh(),
    );
  }
}
