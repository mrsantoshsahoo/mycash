import 'package:flutter/material.dart';
import 'package:mycash/view/dashboard/dashboard_main_sereen.dart';
import 'package:mycash/view/home/home_screen.dart';
import 'package:provider/provider.dart';
import '../../view_model/home_main_view_model.dart';
import '../profile/profile_main_screen.dart';

class HomeMainScreen extends StatelessWidget {
  const HomeMainScreen({Key? key}) : super(key: key);
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    DashboardMainScreen(),
    ProfileMainScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
        create: (context) => HomeViewModel(),
        child: Consumer<HomeViewModel>(builder: (context, counter, child) {
          return Scaffold(
            body: Center(
              child: _widgetOptions.elementAt(counter.currentIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.teal,
              currentIndex: counter.currentIndex,
              onTap: counter.changeView,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard_outlined), label: "Dashboard"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
              ],
            ),
          );
        }));
  }
}
