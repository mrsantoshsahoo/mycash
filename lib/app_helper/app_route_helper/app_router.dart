import 'package:flutter/cupertino.dart';
import 'package:mycash/view/dashboard/dashboard_main_sereen.dart';
import 'package:mycash/view/home/add_cash_screen.dart';
import 'package:mycash/view/home/home_main_screen.dart';
import 'package:mycash/view/home/home_screen.dart';
import '../../view/app_auth/app_login_screen.dart';
import '../../view/app_intro/app_intro_screen.dart';
import '../../view/profile/profile_main_screen.dart';
import 'app_router_name.dart';

class AppRouter {
  Map<String, WidgetBuilder> getCommonRoutes() {
    return {
      RouteStrings.SPLASH: (context) => SplashScreen(),
      RouteStrings.HOME: (context) => HomeScreen(),
      RouteStrings.HOME_MAIN: (context) => HomeMainScreen(),
      RouteStrings.DASHBOARD: (context) => DashboardMainScreen(),
      RouteStrings.PROFILE: (context) => ProfileMainScreen(),
   //   RouteStrings.ADD_CASH:(context)=>AddCashScreen(),
    //  RouteStrings.SIGNIN:(context)=>SignInScreen(),
    };
  }
}
