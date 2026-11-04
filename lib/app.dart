import 'package:fintech/core/theme/app_theme.dart';
import 'package:fintech/features/Home/screens/home.dart';
import 'package:fintech/features/onboarding/view/onboarding_screen.dart';
import 'package:fintech/features/splash/view/spash_screen.dart';
import 'package:flutter/material.dart';

/// Lets us navigate from callbacks without needing a BuildContext.
final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fintech',
      navigatorKey: navigatorKey,
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: isLoggedIn
          ? const HomeScreen()
          : const SplashScreen(onFinished: _goToOnboarding),
      //home: HomeScreen(),
      routes: {
        // '/splash': (context) => const SplashScreen(),
        // '/signup': (context) => const SignUp(),
        // '/login': (context) => const LoginPage(),
      },
    );
  }
}

void _goToOnboarding() {
  navigatorKey.currentState!.pushReplacement(
    MaterialPageRoute(
      builder: (_) => OnboardingScreen(
        onCreateAccount: () =>
            _push(const _TodoScreen(title: 'Create account')),
        onLogin: () => _push(const _TodoScreen(title: 'Log in')),
      ),
    ),
  );
}

void _push(Widget screen) {
  navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => screen));
}

/// Temporary page until the Register and Login screens are built.
class _TodoScreen extends StatelessWidget {
  const _TodoScreen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$title screen goes here',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
