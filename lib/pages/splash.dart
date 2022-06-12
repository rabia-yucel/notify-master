import 'dart:async';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constant.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  startTime() async {
    var _duration =  const Duration(seconds: 2);
    return  Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool value = pref.containsKey('key');

    if (value == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const Login();
          },
        ),
            (r) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const Login();
          },
        ),
            (r) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: secondaryColor,
          child: const Center(
            child: Image(
              image: AssetImage('assets/directlogo.png'),
              width: 250,
            ),
          )),
    );
  }
}
