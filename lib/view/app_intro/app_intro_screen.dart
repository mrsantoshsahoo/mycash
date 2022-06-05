import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../home/home_main_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  Future splashNav(context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, "/signin");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: FutureBuilder(
          future: splashNav(context),
          builder: (context, snapshot) {
            return Center(
                child: Lottie.asset("assets/json/intro.json",
                    height: 300, repeat: false));
          }),
    );
  }
}
