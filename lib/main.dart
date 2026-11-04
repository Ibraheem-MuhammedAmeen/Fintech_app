import 'package:flutter/material.dart';


import 'app.dart';
import 'core/global/shared_prefrence_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //setupServiceLocator(); // if you’re using get_it
  final isLoggedIn = await SharedPrefService().isLoggedIn();
  runApp(MyApp(isLoggedIn: isLoggedIn,));
}
