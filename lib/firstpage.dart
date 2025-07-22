//import 'package:basic_flutter/;oginform.dart';
//import 'package:basic_flutter/image.dart';
// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:basic_flutter/projectlogin.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Splashh extends StatefulWidget {
  const Splashh({super.key});

  @override
  State<Splashh> createState() => _SplashhState();
}

class _SplashhState extends State<Splashh> {
  @override
  void initState() {
    super.initState();
    movetonext();
  }

  void movetonext() async {
    await Future.delayed(Duration(seconds: 6));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProjectLogin()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/images/splashproject.jpg'))),
          Container(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "WELCOME TO BMI CALCULATOR",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          )),
          LoadingAnimationWidget.staggeredDotsWave(
            color: const Color.fromARGB(255, 18, 15, 15),
            size: 50,
          )
        ]),
      ),
    );
  }
}
