import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycash/view/app_intro/app_intro_screen.dart';
import 'package:mycash/view_model/home_main_view_model.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'app_helper/app_local_database_helper/field_constants.dart';
import 'app_helper/app_local_database_helper/mycash_database.dart';
import 'app_helper/app_local_database_helper/name_constants.dart';
import 'app_helper/app_route_helper/app_router.dart';
import 'app_helper/app_route_helper/app_router_name.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // NotificationService().initNotification();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    statusBarColor: Colors.teal,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(),
          //builder: ,
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          initialRoute: RouteStrings.SPLASH,
          routes: AppRouter().getCommonRoutes()),
    );
  }
}
