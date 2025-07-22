// ignore_for_file: use_build_context_synchronously

import 'package:basic_flutter/bmipage.dart';
import 'package:basic_flutter/functionfile.dart';
//import 'package:basic_flutter/loginpage.dart';
//import 'package:basic_flutter/loginregistration.dart';
import 'package:basic_flutter/projectlogin.dart';
//import 'package:basic_flutter/whatsapp.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  void moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    final response = await retreivebooldata();
    if (response == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Project()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProjectLogin()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Center(
          child: SizedBox(
            width: 300,
            height: 500,
            child: Image.asset('assets/images/splashproject.jpg',
                fit: BoxFit.scaleDown),
          ),

          //FlutterLogo(size: 200),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "WELCOME TO BMI CALCULATOR",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    ));
  }
}
