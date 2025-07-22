// ignore_for_file: use_build_context_synchronously
import 'package:basic_flutter/projectlogin.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen2 extends StatefulWidget {
  const Splashscreen2({super.key});

  @override
  State<Splashscreen2> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen2> {
  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  void moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProjectLogin()),
    );
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
            child: Image.asset('assets/images/splashproject2.jpg',
                fit: BoxFit.scaleDown),
          ),

          //FlutterLogo(size: 200),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Redirecting to Login Page",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    ));
  }
}
