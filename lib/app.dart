import 'package:fintech/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Nurri',
        theme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: isLoggedIn ? const HomeScreen() : const SplashScreen(),
        //home: HomeScreen(),
        routes: {
         // '/splash': (context) => const SplashScreen(),
         // '/signup': (context) => const SignUp(),
         // '/login': (context) => const LoginPage(),
          
        },
    );
  }
}