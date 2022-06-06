import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mycash/app_helper/app_prefreance/app_preferences.dart';
import '../home/home_main_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  Future splashNav(context) async {
    final isLoggedIn = await SharedPreferenceHelper.isLoggedIn;
    await Future.delayed(const Duration(seconds: 3));

    if (isLoggedIn != null && isLoggedIn) {
      Navigator.pushReplacementNamed(context, "/home_main");
    }else{
      Navigator.pushReplacementNamed(context, "/signin");
    }

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
